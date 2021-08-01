import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class Tips extends StatefulWidget {
  @override
  _TipsState createState() => _TipsState();
}

class _TipsState extends State<Tips> {
  List avgs = [];
  String weakestCategory = '';

  void readAvgs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    avgs.add(prefs.getDouble('mindsetAvg'));
    avgs.add(prefs.getDouble('energyAvg'));
    avgs.add(prefs.getDouble('performanceAvg'));
    avgs.add(prefs.getDouble('driveAvg'));
    double smallest = avgs.cast<double>().reduce(min);
    int indexOfSmallest = avgs.indexOf(smallest);

    switch (indexOfSmallest) {
      case 0:
        setState(() {
          weakestCategory = 'Mindset';
        });
        break;
      case 1:
        setState(() {
          weakestCategory = 'Energy';
        });
        break;
      case 2:
        setState(() {
          weakestCategory = 'Performance';
        });
        break;
      case 3:
        setState(() {
          weakestCategory = 'Drive';
        });
        break;
    }
  }

  Widget quoteTip(String quote, String author) {
    return Container(
      color: Colors.deepPurple.shade500,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              quote,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "-" + author,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    readAvgs();
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade400,
      appBar: AppBar(
        title: Text('Tips'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              'Thr1ve senses your ' + weakestCategory + ' could use some work!',
              textScaleFactor: 3,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 50,
            ),
            quoteTip(
                '“Winning is not a sometime thing; it’s an all time thing. You don’t win once in a while, you don’t do things right once in a while, you do them right all the time. Winning is habit. Unfortunately, so is losing.”',
                'Vince Lombardi')
          ],
        ),
      ),
    );
  }
}
