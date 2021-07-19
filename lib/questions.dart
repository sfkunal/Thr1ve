import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './question.dart';

class Questions extends StatefulWidget {
  @override
  QuestionsState createState() => QuestionsState();
}

class QuestionsState extends State<Questions> {
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
  var numQuestions = 5;
  var questionIndex = 0;
  String currQuestion = '';
  var _questionList = [
    'How intense was your footwork today?',
    'How supported do you feel by coaches?',
    'How easily are you able to consider constructive feedback?',
    'question 4',
    'question 5'
  ];
  Icon icon1 = Icon(Icons.circle_outlined);
  Icon icon2 = Icon(Icons.circle_outlined);
  Icon icon3 = Icon(Icons.circle_outlined);
  Icon icon4 = Icon(Icons.circle_outlined);
  Icon icon5 = Icon(Icons.circle_outlined);

  Icon getProgressIcon(int index) {
    if (index <= questionIndex) {
      if (index == 1) {
        setState(() {
          icon1 = Icon(Icons.check_circle_outline_sharp);
        });
      }
      if (index == 2) {
        setState(() {
          icon2 = Icon(Icons.check_circle_outline_sharp);
        });
      }
      if (index == 3) {
        setState(() {
          icon3 = Icon(Icons.check_circle_outline_sharp);
        });
      }
      if (index == 4) {
        setState(() {
          icon4 = Icon(Icons.check_circle_outline_sharp);
        });
      }
      if (index == 5) {
        setState(() {
          icon5 = Icon(Icons.check_circle_outline_sharp);
        });
      }
      return Icon(Icons.check_circle_outline_sharp);
    } else {
      if (index == 1) {
        setState(() {
          icon1 = Icon(Icons.circle_outlined);
        });
      }
      if (index == 2) {
        setState(() {
          icon2 = Icon(Icons.circle_outlined);
        });
      }
      if (index == 3) {
        setState(() {
          icon3 = Icon(Icons.circle_outlined);
        });
      }
      if (index == 4) {
        setState(() {
          icon4 = Icon(Icons.circle_outlined);
        });
      }
      if (index == 5) {
        setState(() {
          icon5 = Icon(Icons.circle_outlined);
        });
      }
      return Icon(Icons.circle_outlined);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
            // child: Text(
            //   'Grow',
            // ),
            ),
      ),
      body: Column(children: [
        Question(
          _questionList[questionIndex],
        ),
        Column(
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
                    textScaleFactor: 5,
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
                textScaleFactor: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ]),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.deepPurple,
        ),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: IconButton(
                  iconSize: 40,
                  onPressed: () {
                    back();
                  },
                  icon: Icon(Icons.arrow_back_ios_sharp)),
              label: '',
            ),
            BottomNavigationBarItem(icon: getProgressIcon(1), label: ''),
            BottomNavigationBarItem(icon: getProgressIcon(2), label: ''),
            BottomNavigationBarItem(icon: getProgressIcon(3), label: ''),
            BottomNavigationBarItem(icon: getProgressIcon(4), label: ''),
            BottomNavigationBarItem(icon: getProgressIcon(5), label: ''),
            BottomNavigationBarItem(
              label: '',
              icon: IconButton(
                  iconSize: 40,
                  onPressed: () {
                    next();
                  },
                  icon: Icon(Icons.arrow_forward_ios_sharp)),
            ),
          ],
        ),
      ),
    );
  }

  void next() {
    if (questionIndex < numQuestions - 1) {
      setState(() {
        questionIndex = questionIndex + 1;
      });
    }
  }

  void back() {
    if (questionIndex > 0) {
      setState(() {
        questionIndex = questionIndex - 1;
      });
    }
  }
}
