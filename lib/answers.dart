import 'package:flutter/material.dart';

class Answers extends StatefulWidget {
  @override
  _AnswersState createState() => _AnswersState();
}

class _AnswersState extends State<Answers> {
  String encourage = '';
  Map<String, String> encourage_map = {
    'terrible': 'Hopefully tomorrow brings better performance!',
    'sad': 'Don\'t stress. Everyone has off days.',
    'neutral': 'An average performance.',
    'happy': 'Hard work pays off. Great job.',
    'great': 'Excellent. You are on the path to greatness.',
  };
  //todo alternate from a word bank of encouragement
  var color_map = {
    'terrible': Colors.white,
    'sad': Colors.white,
    'neutral': Colors.white,
    'happy': Colors.white,
    'great': Colors.white,
  };
  void setColors(String name) {
    color_map.forEach((k, v) => color_map[k] = Colors.white);
    color_map[name] = Colors.blue.shade100;
    encourage = encourage_map[name].toString();
  }

  var rating = -1.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: 0,
            right: 0,
            top: 100,
            bottom: 100,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 60,
                onPressed: () {
                  setState(() {
                    setColors('terrible');
                  });
                },
                color: color_map['terrible'],
                icon: Image.asset(
                  'images/terrible.png',
                ),
              ),
              IconButton(
                iconSize: 60,
                onPressed: () {
                  setState(() {
                    setColors('sad');
                  });
                },
                color: color_map['sad'],
                icon: Image.asset(
                  'images/sad.png',
                ),
              ),
              IconButton(
                iconSize: 60,
                onPressed: () {
                  setState(() {
                    setColors('neutral');
                  });
                },
                color: color_map['neutral'],
                icon: Image.asset(
                  'images/neutral.png',
                ),
              ),
              IconButton(
                iconSize: 60,
                onPressed: () {
                  setState(() {
                    setColors('happy');
                  });
                },
                color: color_map['happy'],
                icon: Image.asset(
                  'images/happy.png',
                ),
              ),
              IconButton(
                iconSize: 60,
                onPressed: () {
                  setState(() {
                    setColors('great');
                  });
                },
                color: color_map['great'],
                icon: Image.asset(
                  'images/great.png',
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Text(
            encourage,
            textScaleFactor: 1.6,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
