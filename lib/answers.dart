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
    'terrible': 'Uh-oh! Make this a priority in your training!',
    'sad': 'No worries. Focus on improving slightly every day.',
    'neutral': 'Don\'t stress. Everyone has off days!',
    'happy': 'Hard work pays off. Great job.',
    'great': 'Excellent. You\'re on the path to greatness.',
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
            top: 45,
            bottom: 0,
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
                    iconSize: 68,
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
              Text(
                rating.toInt().toString(),
                textScaleFactor: 3,
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
                    if (rating > 0) {
                      setState(() {
                        encourageText('terrible');
                      });
                    }
                    if (rating > 2) {
                      setState(() {
                        encourageText('sad');
                      });
                    }
                    if (rating > 4) {
                      setState(() {
                        encourageText('neutral');
                      });
                    }
                    if (rating > 6) {
                      setState(() {
                        encourageText('happy');
                      });
                    }
                    if (rating > 8) {
                      setState(() {
                        encourageText('great');
                      });
                    }
                    // print(rating);
                  },
                  min: 0,
                  max: 10,
                  divisions: 10,
                  thumbColor: Colors.black,
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
