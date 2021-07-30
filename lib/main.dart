import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './questions.dart';
import './statistics.dart';

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

  int _selectedIndex = 0;

  void updateTree() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int startIndex = prefs.getInt('index') ?? 0;
    //todo get the next 5 frames
    // then initialize a timer
    //set state to update tree location
    //pause the timer for .1 sec
    //do above 2 lines for each frame.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.title,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 25),
            Text(
              'You are doing well!',
              textScaleFactor: 2.7,
            ),
            SizedBox(height: 5),
            Image.asset(
              treeLocation,
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
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
            label: 'questions',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.assessment_outlined,
            ),
            label: 'statistics',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueGrey,
        onTap: (index) {
          _selectedIndex = index;
          if (_selectedIndex == 1) {
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (ctxt) => new Questions()),
            ).then((value) {
              updateTree();
            });
          }
          if (_selectedIndex == 2) {
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (ctxt) => new Statistics()),
            ).then((value) {
              updateTree();
            });
          }
        },
      ),
    );
  }
}
