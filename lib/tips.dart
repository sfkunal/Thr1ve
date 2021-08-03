import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'datasets.dart';

class Tips extends StatefulWidget {
  @override
  _TipsState createState() => _TipsState();
}

class _TipsState extends State<Tips> {
  List avgs = [];
  String weakestCategory = 'Mindset';
  String logo = 'images/logo.png';
  String id = '2W7POjFb88g';
  String currUrl = 'https://www.youtube.com/watch?v=yG7v4y_xwzQ';
  String currQuote = '';

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
          List l = Data.mindsetVids..shuffle();
          currUrl = l.first;
        });
        break;
      case 1:
        setState(() {
          weakestCategory = 'Energy';
          List l = Data.energyVids..shuffle();
          currUrl = l.first;
        });
        break;
      case 2:
        setState(() {
          weakestCategory = 'Performance';
          List l = Data.performanceVids..shuffle();
          currUrl = l.first;
        });
        break;
      case 3:
        setState(() {
          weakestCategory = 'Drive';
          List l = Data.driveVids..shuffle();
          currUrl = l.first;
        });
        break;
    }
  }

  Widget getLogo() {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Image.asset(
          logo,
          scale: .5,
        ),
      ],
    );
  }

  Widget quoteTip() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            color: Colors.deepPurple.shade500,
            child: Column(
              children: [
                Text(
                  currQuote,
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
            height: 10,
          ),
          Image.asset(
            logo,
          )
        ],
      ),
    );
  }

  Widget videoTip() {
    return Column(
      children: [
        Container(
          height: 20,
          color: Colors.deepPurple.shade500,
        ),
        YoutubePlayer(
          controller: YoutubePlayerController(
            initialVideoId: YoutubePlayer.convertUrlToId(currUrl).toString(),
            flags: YoutubePlayerFlags(
              autoPlay: true,
              mute: false,
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
        SizedBox(
          height: 10,
        ),
        Image.asset(
          logo,
        )
      ],
    );
  }

  late Widget animateQuoteVid;

  getQuote() {
    switch (weakestCategory) {
      case 'Mindset':
        final random = new Random();
        var i = random.nextInt(Data.mindsetQuotes.length);
        setState(() {
          currQuote = Data.mindsetQuotes[i];
        });
        break;
      case 'Energy':
        final random = new Random();
        var i = random.nextInt(Data.energyQuotes.length);
        setState(() {
          currQuote = Data.energyQuotes[i];
        });
        break;
      case 'Performance':
        final random = new Random();
        var i = random.nextInt(Data.performanceQuotes.length);
        setState(() {
          currQuote = Data.performanceQuotes[i];
        });
        break;
      case 'Drive':
        final random = new Random();
        var i = random.nextInt(Data.driveQuotes.length);
        setState(() {
          currQuote = Data.driveQuotes[i];
        });
        break;
    }
  }

  void initState() {
    super.initState();
    animateQuoteVid = getLogo();
    readAvgs();
    getQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade400,
      appBar: AppBar(
        title: Text(''),
      ),
      body: Stack(children: [
        Center(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                'I sense your ' +
                    weakestCategory.toLowerCase() +
                    ' could use some work!',
                textScaleFactor: 3,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                child: animateQuoteVid,
              ),
            ],
          ),
        ),
        Container(
          child: Column(
            children: [
              Expanded(
                child: Container(),
              ),
              // this will be you container
              Container(
                height: 150,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Colors.deepPurple,
                                    Colors.purple
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(16.0),
                              primary: Colors.white,
                              textStyle: TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              setState(() {
                                animateQuoteVid = quoteTip();
                              });
                            },
                            child: Text('Quote'),
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Colors.deepPurple,
                                    Colors.purple
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(16.0),
                              primary: Colors.white,
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              setState(() {
                                animateQuoteVid = videoTip();
                              });
                            },
                            child: Text('Video'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
