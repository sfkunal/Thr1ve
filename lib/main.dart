import 'package:flutter/material.dart';
import './questions.dart';
import './statistics.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Thr1ve',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'Thr1ve Home Page'),
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
  int _selectedIndex = 0;
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
            SizedBox(height: 100),
            Text(
              'You are doing well!',
              textScaleFactor: 2.7,
            ),
            SizedBox(height: 200),
            Image.asset(
              'images/base_tree2.png',
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
            );
          }
          if (_selectedIndex == 2) {
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (ctxt) => new Statistics()),
            );
          }
        },
      ),
    );
  }
}
