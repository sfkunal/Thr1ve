import 'package:audioplayers/audioplayers.dart';
import 'package:image_sequence_animator/image_sequence_animator.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './questions.dart';
import './statistics.dart';
import './help.dart';
import 'datasets.dart';
import 'tips.dart';
import 'package:flutter/services.dart';

// to pull:
// git pull (do this everytime you switch devices)

// to push:
// git add *
// git commit -m 'message'
// git push

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Thr1ve',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Naturaling',
      ),
      home: MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Questions questionPage = new Questions();
  final bool enableAudio = true;
  //remember to change to true
  bool audio = true;
  final double imageScale = 1.5;
  final int startLevel = 56;
  final int endLevel = 1300;
  String logo = 'images/logo.png';
  String encourage = '';
  List<String> encourageList = [
    'You keep improving. Insane!',
    'The next GOAT. Thr1ve away.',
    'Stack those leaves!',
    'You\'re on fire!',
  ];

  int _selectedIndex = 0;

  //180   200   200   200   200   200   140
  //1-10 10-20 20-30 30-40 40-50 50-60 60-74
  String getMidFolder(int level) {
    if (level > 0 && level < 1320) {
      if (level < 180) {
        return '01-10';
      } else if (level < 380) {
        return '10-20';
      } else if (level < 580) {
        return '20-30';
      } else if (level < 780) {
        return '30-40';
      } else if (level < 980) {
        return '40-50';
      } else if (level < 1180) {
        return '50-60';
      } else {
        return '60-74';
      }
    } else {
      return 'error';
    }
  }

  String to3digit(int id) {
    if (id < 10) {
      if (id == 0) {
        return '001';
      }
      return '00$id';
    } else if (id < 100) {
      return '0$id';
    } else
      return id.toString();
  }

  int calcRemainderId(int id) {
    if (id > 0 && id < 1320) {
      if (id < 180) {
        return id;
      } else if (id < 380) {
        return id - 180;
      } else if (id < 580) {
        return id - 380;
      } else if (id < 780) {
        return id - 580;
      } else if (id < 980) {
        return id - 780;
      } else if (id < 1180) {
        return id - 980;
      } else {
        return id - 1180;
      }
    }
    return -1;
  }

  String fromIdToPath(int id) {
    String head = 'images/tree/';
    String midFolder = getMidFolder(id);
    String body = '/tree';
    String textId = to3digit(calcRemainderId(id));
    String path = head + midFolder + body + midFolder + '_' + textId + '.jpg';
    return path;
  }

  int fromPathToId(String path) {
    int base = 0;
    String midFolder = path.split('/')[2];
    // print(midFolder);
    switch (midFolder) {
      case '01-10':
        base += 0;
        break;
      case '10-20':
        base += 180;
        break;
      case '20-30':
        base += 380;
        break;
      case '30-40':
        base += 580;
        break;
      case '40-50':
        base += 780;
        break;
      case '50-60':
        base += 980;
        break;
      case '60-74':
        base += 1180;
        break;
    }
    String id = path.split('.')[0].substring(28);
    int fin = int.parse(id);
    return fin + base;
  }
  // images/tree/01-10/tree01-10_056.jpg

  String currTreeLoc = 'images/tree/01-10/tree01-10_001.jpg';
  Image tree = Image.asset(
    'images/tree/01-10/tree01-10_001.jpg',
    scale: 1.45,
  );

  String getEncourage() {
    List shuffled = encourageList..shuffle();
    return shuffled[0];
  }

  String getToday() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MM-dd-yyyy');
    final String formatted = formatter.format(now);
    List<String> date = formatted.split('-');
    String answer =
        Data.months[date[0]].toString() + ' ' + int.parse(date[1]).toString();
    return answer;
  }

  String getYear() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MM-dd-yyyy');
    final String formatted = formatter.format(now);
    List<String> date = formatted.split('-');
    return date[2];
  }

  AudioPlayer instance = new AudioPlayer();
  AudioCache musicCache = AudioCache(prefix: "audio/");

  void playLoopedMusic() async {
    instance = await musicCache.loop("music.mp3");
    // await instance.setVolume(0.5); you can even set the volume
  }

  void pauseMusic() {
    if (instance != null) {
      instance.pause();
    }
  }

  Icon displayVol() {
    if (audio == true) {
      if (enableAudio) {
        playLoopedMusic();
      }
      return Icon(
        Icons.volume_up,
        color: Colors.white,
      );
    } else {
      if (enableAudio) {
        instance.pause();
      }
      return Icon(
        Icons.volume_off,
        color: Colors.white,
      );
    }
  }

  Future readAccountLevel() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int index = prefs.getInt('index') ?? 0;
    print('read account Level: ' + index.toString());
    return index;
  }

  Future addAccountLevel() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int index = prefs.getInt('index') ?? 0;
    print('read account Level: ' + index.toString());
    prefs..setInt('index', index + 1);
    print('saved new level as ' + (index + 1).toString());
    return index + 1;
  }

  List<String> fullPaths = [];
  List<String> addPaths(int startframe, int endframe) {
    for (int i = startframe; i < endframe; i++) {
      fullPaths.add(fromIdToPath(i));
    }
    return fullPaths;
  }

  void initState() {
    super.initState();
    encourage = getEncourage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade400,
      appBar: AppBar(
          leading: Row(
            children: [
              IconButton(
                icon: Icon(Icons.help_outline),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (ctxt) => new Help()));
                },
              ),
            ],
          ),
          title: new Image.asset(
            logo,
            scale: 3.2,
          )),
      body: Stack(children: [
        Center(
          child: Column(
            children: [
              SizedBox(height: 180),
              Container(
                height: 20,
                color: Colors.black,
              ),
              ImageSequenceAnimator(
                "assets/ImageSequence",
                "Frame_",
                0,
                5,
                "jpg",
                5,
                key: Key("offline"),
                fullPaths: addPaths(1, 1300),
              ),
              Container(
                height: 20,
                color: Colors.black,
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
        Center(
          child: Column(
            children: [
              SizedBox(
                height: 470,
              ),
              Text(
                getToday(),
                textScaleFactor: 3.9,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                getYear(),
                textScaleFactor: 3.6,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Center(
          child: Column(
            children: [
              SizedBox(height: 45),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  encourage,
                  textScaleFactor: 3.4,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
        Positioned(
            top: 460.0,
            right: 0.0,
            child: Column(
              children: [
                IconButton(
                    iconSize: 32,
                    onPressed: () {
                      HapticFeedback.heavyImpact();
                      Navigator.push(context,
                          new MaterialPageRoute(builder: (ctxt) => new Tips()));
                    },
                    icon: Icon(
                      Icons.lightbulb_outline_sharp,
                      color: Colors.white,
                    )),
                Text(
                  'tips',
                  style: TextStyle(color: Colors.white),
                )
              ],
            )),
        Positioned(
            right: 0,
            child: IconButton(
              icon: displayVol(),
              onPressed: () {
                setState(() {
                  audio = !audio;
                });
              },
            )),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.sticky_note_2_outlined,
            ),
            label: 'check-in',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.assessment_outlined,
            ),
            label: 'results',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueGrey,
        onTap: (index) {
          _selectedIndex = index;
          if (_selectedIndex == 1) {
            Navigator.push(context,
                new MaterialPageRoute(builder: (ctxt) => new Questions()));
            // .then((value) => print('value'));
          }
          if (_selectedIndex == 2) {
            Navigator.push(context,
                new MaterialPageRoute(builder: (ctxt) => new Statistics()));
          }
        },
      ),
    );
  }
}
