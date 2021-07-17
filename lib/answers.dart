import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './questions.dart';

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
  void encourageText(String name) {
    encourage = encourage_map[name].toString();
  }

  var rating = 5.0;
  QuestionsState s = new QuestionsState();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: 0,
            right: 0,
            top: 100,
            bottom: 90,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 60,
                    onPressed: () {},
                    icon: Image.asset(
                      'images/terrible.png',
                    ),
                  ),
                  IconButton(
                    iconSize: 60,
                    onPressed: () {},
                    icon: Image.asset(
                      'images/sad.png',
                    ),
                  ),
                  IconButton(
                    iconSize: 60,
                    onPressed: () {},
                    icon: Image.asset(
                      'images/neutral.png',
                    ),
                  ),
                  IconButton(
                    iconSize: 60,
                    onPressed: () {},
                    icon: Image.asset(
                      'images/happy.png',
                    ),
                  ),
                  IconButton(
                    iconSize: 60,
                    onPressed: () {},
                    icon: Image.asset(
                      'images/great.png',
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 370,
                height: 100,
                child: CupertinoSlider(
                  value: rating,
                  onChanged: (newRating) {
                    setState(() => rating = newRating);
                    setState(() {
                      encourageText('neutral');
                    });
                    if (rating == 0) {
                      setState(() {
                        encourageText('terrible');
                      });
                    }
                    if (rating == 2.5) {
                      setState(() {
                        encourageText('sad');
                      });
                    }
                    if (rating == 5.0) {
                      setState(() {
                        encourageText('neutral');
                      });
                    }
                    if (rating == 7.5) {
                      setState(() {
                        encourageText('happy');
                      });
                    }
                    if (rating == 10.0) {
                      setState(() {
                        encourageText('great');
                      });
                    }
                    // print(rating);
                  },
                  min: 0,
                  max: 10,
                  divisions: 4,
                  thumbColor: Colors.black,
                ),
              ),
              CupertinoButton(
                child: Text('Next'),
                color: Colors.blueGrey,
                onPressed: () {
                  s.buttonPressed();
                },
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
