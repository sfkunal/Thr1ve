import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import './questions.dart';
import './statistics.dart';
import './help.dart';
import 'tips.dart';
import 'package:flutter/services.dart';

// to pull:
// git pull (do this everytime you switch devices)

// to push:
// git add *
// git commit -m 'message'
// git push

void main() {
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
      home: MyHomePage(title: 'Home Thr1ve'),
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
  String treeLocation = 'images/frame_010.png';
  String encourage = '';
  List<String> encourageList = [
    'You keep improving. Insane!',
    'The next GOAT. Thr1ve way.',
    'Stack these leaves!',
    'You\'re on fire!',
  ];

  int _selectedIndex = 0;

  void updateTree() {
    for (int i = 10; i < 100; i++) {
      setState(() {
        treeLocation = 'images/frame_0$i.png';
      });
      sleep(Duration(milliseconds: 1000));
      print('done');
    }
    print('done');
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

  @override
  Widget build(BuildContext context) {
    // updateTree();
    return Scaffold(
      backgroundColor: Colors.white,
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
              SizedBox(height: 20),
              Text(
                getEncourage(),
                textScaleFactor: 3,
              ),
              SizedBox(height: 200),
              Image.asset(
                treeLocation,
                scale: .001,
              )
            ],
          ),
        ),
        Positioned(
            top: 500.0,
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
                      color: Colors.deepPurple,
                    )),
                Text('tips')
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
