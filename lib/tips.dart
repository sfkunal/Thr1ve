import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Tips extends StatefulWidget {
  @override
  _TipsState createState() => _TipsState();
}

class _TipsState extends State<Tips> {
  List avgs = [];
  String weakestCategory = '';
  String logo = 'images/logo.png';
  String id = '';

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            color: Colors.deepPurple.shade500,
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
          SizedBox(
            height: 50,
          ),
          Image.asset(
            logo,
          )
        ],
      ),
    );
  }

  Widget videoTip(String url) {
    String newId = YoutubePlayer.convertUrlToId(url).toString();
    setState(() {
      id = newId;
    });
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          height: 20,
          color: Colors.deepPurple.shade500,
        ),
        YoutubePlayer(
          controller: YoutubePlayerController(
            initialVideoId: id,
            flags: YoutubePlayerFlags(
              autoPlay: true,
              mute: true,
              loop: true,
            ),
          ),
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.amber,
          bottomActions: [
            ProgressBar(isExpanded: true),
          ],
        ),
        Container(
          height: 20,
          color: Colors.deepPurple.shade500,
        ),
        SizedBox(height: 35),
        Image.asset(
          logo,
          scale: 1,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    readAvgs();
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade400,
      appBar: AppBar(
        title: Text(''),
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
            videoTip('https://www.youtube.com/watch?v=kO1kgl0p-Hw'),
            // quoteTip(
            //     '“Winning is not a sometime thing; it’s an all time thing. You don’t win once in a while, you don’t do things right once in a while, you do them right all the time. Winning is habit. Unfortunately, so is losing.”',
            //     'Vince Lombardi'),
          ],
        ),
      ),
    );
  }
}
