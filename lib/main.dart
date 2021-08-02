import 'dart:io';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
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
  final double imageScale = 1.5;
  final int startLevel = 56;
  final int endLevel = 1300;
  String encourage = '';
  List<String> encourageList = [
    'You keep improving. Insane!',
    'The next GOAT. Thr1ve way.',
    'Stack these leaves!',
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

  void test(int n) {
    print(fromPathToId(fromIdToPath(n)) == n);
  }

  String currTreeLoc = 'images/tree/01-10/tree01-10_056.jpg';
  Image tree = Image.asset(
    'images/tree/01-10/tree01-10_056.jpg',
    scale: 1.45,
  );

  void updateTree() {
    int currLevel = fromPathToId(currTreeLoc);
    print(currLevel);
    setState(() {
      tree = Image.asset(fromIdToPath(currLevel + 5), scale: 1.45);
      currTreeLoc = fromIdToPath(currLevel + 5);
    });
    // for (int i = 10; i < 100; i++) {
    //   setState(() {
    //     // treeLocation = 'images/frame_0$i.png';
    //     // tree
    //   });
    //   sleep(Duration(milliseconds: 1000));
    //   print('done');
    // }
    // print('done');

    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // int startIndex = prefs.getInt('index') ?? 0;
    // print('level: ' + startIndex.toString());
    //todo get the next 5 frames
    // then initialize a timer
    //set state to update tree location
    //pause the timer for .1 sec
    //do above 2 lines for each frame.
  }

  String getEncourage() {
    List shuffled = encourageList..shuffle();
    return shuffled[0];
  }

  String getToday() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MM-dd-yyyy');
    final String formatted = formatter.format(now);
    List<String> date = formatted.split('-');
    String answer = Data.months[date[0]].toString() +
        ' ' +
        int.parse(date[1]).toString() +
        ', ' +
        date[2].toString();
    return answer;
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
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
        ),
      ),
      body: Stack(children: [
        Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              Text(
                getEncourage(),
                textScaleFactor: 3,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    iconSize: 45,
                    onPressed: () {
                      updateTree();
                    },
                    icon: Icon(Icons.next_plan),
                  ),
                  // IconButton(
                  // iconSize: 45, onPressed: () {}, icon: Icon(Icons.back_plan)),
                ],
              ),
              SizedBox(height: 275),
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    getToday(),
                    textScaleFactor: 3.4,
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 200,
          child: tree,
        ),
        Positioned(
            top: 515.0,
            right: 0.0,
            child: Column(
              children: [
                IconButton(
                    iconSize: 50,
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
