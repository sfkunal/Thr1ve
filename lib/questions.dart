import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './question.dart';

class Questions extends StatefulWidget {
  @override
  QuestionsState createState() => QuestionsState();
}

class QuestionsState extends State<Questions> {
  var _answerList = [];
  var rating = 5.0;
  var numQuestions = 5;
  var questionIndex = 0;

  String encourage = '';
  String currQuestion = '';

  List getAnswerList() {
    return _answerList;
  }

  Map<String, String> encourage_map = {
    'terrible': 'Work on this!',
    'sad': 'Don\'t give up! You got it.',
    'neutral': 'Solid. Keep working!',
    'happy': 'On fire!',
    'great': 'Keep Thr1ving!',
  };

  List _questionList = [
    'How intense was your footwork today?',
    'How supported do you feel by coaches?',
    'How easily are you able to consider constructive feedback?',
    'question 4',
    'question 5'
  ];

  Image terrible = Image.asset(
    'images/happy.png',
    scale: 1.8,
  );
  Image sad = Image.asset(
    'images/happy.png',
    scale: 1.8,
  );
  Image neutral = Image.asset(
    'images/happy.png',
    scale: 1.6,
  );
  Image happy = Image.asset(
    'images/happy.png',
    scale: 1.8,
  );
  Image great = Image.asset(
    'images/happy.png',
    scale: 1.8,
  );

  Icon icon1 = Icon(Icons.circle_outlined);
  Icon icon2 = Icon(Icons.circle_outlined);
  Icon icon3 = Icon(Icons.circle_outlined);
  Icon icon4 = Icon(Icons.circle_outlined);
  Icon icon5 = Icon(Icons.circle_outlined);

  Icon getProgressIcon(int index) {
    if (index <= questionIndex) {
      if (index == 1) {
        setState(() {
          icon1 = Icon(Icons.circle);
        });
      }
      if (index == 2) {
        setState(() {
          icon2 = Icon(Icons.circle);
        });
      }
      if (index == 3) {
        setState(() {
          icon3 = Icon(Icons.circle);
        });
      }
      if (index == 4) {
        setState(() {
          icon4 = Icon(Icons.circle);
        });
      }
      if (index == 5) {
        setState(() {
          icon5 = Icon(Icons.circle);
        });
      }
      return Icon(Icons.circle);
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

  void encourageText(String name) {
    encourage = encourage_map[name].toString();
  }

  void imageUpdate(double newRating) {
    if (newRating < 2 && newRating >= 0) {
      setState(() {
        terrible = Image.asset(
          'images/terrible.png',
          color: Colors.blueAccent,
          scale: 1.8,
        );
        sad = Image.asset('images/sad.png', scale: 1.8);
        neutral = Image.asset('images/neutral.png', scale: 1.6);
        happy = Image.asset('images/happy.png', scale: 1.8);
        great = Image.asset('images/great.png', scale: 1.8);
      });
    } else if (newRating < 4 && newRating >= 2) {
      setState(() {
        sad = Image.asset(
          'images/sad.png',
          color: Colors.blueAccent,
          scale: 1.8,
        );
        terrible = Image.asset('images/terrible.png', scale: 1.8);
        neutral = Image.asset('images/neutral.png', scale: 1.6);
        happy = Image.asset('images/happy.png', scale: 1.8);
        great = Image.asset('images/great.png', scale: 1.8);
      });
    } else if (newRating < 6 && newRating >= 4) {
      setState(() {
        neutral = Image.asset(
          'images/neutral.png',
          color: Colors.blueAccent,
          scale: 1.6,
        );
        terrible = Image.asset('images/terrible.png', scale: 1.8);
        sad = Image.asset('images/sad.png', scale: 1.8);
        happy = Image.asset('images/happy.png', scale: 1.8);
        great = Image.asset('images/great.png', scale: 1.8);
      });
    } else if (newRating < 8 && newRating >= 6) {
      setState(() {
        happy = Image.asset(
          'images/happy.png',
          color: Colors.blueAccent,
          scale: 1.8,
        );
        terrible = Image.asset('images/terrible.png', scale: 1.8);
        sad = Image.asset('images/sad.png', scale: 1.8);
        neutral = Image.asset('images/neutral.png', scale: 1.6);
        great = Image.asset('images/great.png', scale: 1.8);
      });
    } else {
      setState(() {
        great = Image.asset(
          'images/great.png',
          color: Colors.blueAccent,
          scale: 1.8,
        );
        terrible = Image.asset('images/terrible.png', scale: 1.8);
        sad = Image.asset('images/sad.png', scale: 1.8);
        neutral = Image.asset('images/neutral.png', scale: 1.6);
        happy = Image.asset('images/happy.png', scale: 1.8);
      });
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
                top: 20,
                bottom: 0,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      terrible,
                      sad,
                      neutral,
                      happy,
                      great,
                    ],
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Text(
                    rating.toInt().toString(),
                    textScaleFactor: 5,
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Container(
                    child: Text(
                      encourage,
                      textScaleFactor: 3,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 370,
                    height: 100,
                    child: CupertinoSlider(
                      value: rating,
                      onChanged: (newRating) {
                        imageUpdate(newRating);
                        setState(() => rating = newRating);
                        encourageText('neutral');
                        if (rating >= 0) {
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
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getProgressIcon(1),
                getProgressIcon(2),
                getProgressIcon(3),
                getProgressIcon(4),
                getProgressIcon(5)
              ],
            )
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
              label: '',
              icon: IconButton(
                  iconSize: 40,
                  onPressed: () {
                    back();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: IconButton(
                  iconSize: 40,
                  onPressed: () {
                    next();
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void next() {
    if (questionIndex < numQuestions) {
      setState(() {
        questionIndex = questionIndex + 1;
        _answerList.add(rating);
        print('question index: ' + questionIndex.toString());
        print('current answer list: ' + _answerList.toString());
        if (questionIndex == numQuestions) {
          questionIndex = 0;
          Navigator.pop(context);
        }
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
