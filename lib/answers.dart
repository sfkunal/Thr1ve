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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 200,
            bottom: 50,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                onPressed: () {
                  setState(() {
                    setColors('terrible');
                  });
                },
                color: color_map['terrible'],
                padding: EdgeInsets.all(25),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Image.asset(
                  'images/terrible.png',
                  scale: 2,
                ),
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    setColors('sad');
                  });
                },
                color: color_map['sad'],
                padding: EdgeInsets.all(25),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Image.asset(
                  'images/sad.png',
                  scale: 2,
                ),
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    setColors('neutral');
                  });
                },
                color: color_map['neutral'],
                padding: EdgeInsets.all(25),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Image.asset(
                  'images/neutral.png',
                  scale: 1.45,
                ),
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    setColors('happy');
                  });
                },
                color: color_map['happy'],
                padding: EdgeInsets.all(25),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Image.asset(
                  'images/happy.png',
                  scale: 2,
                ),
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    setColors('great');
                  });
                },
                color: color_map['great'],
                padding: EdgeInsets.all(25),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Image.asset(
                  'images/great.png',
                  scale: 2,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 50,
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
