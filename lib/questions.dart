import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './question.dart';
import './user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

class Questions extends StatefulWidget {
  @override
  QuestionsState createState() => QuestionsState();
}

class QuestionsState extends State<Questions> {
  List<Node> answers = [];
  String currQuestion = '';
  String currCategory = '';
  var _answerList = [];
  var rating = 5.0;
  var numQuestions = 4;
  var questionIndex = -1;
  String encourage = 'Start your daily check-in!';

  List getAnswerList() {
    return _answerList;
  }

  List _questionList = [];
  List _categoryList = [];

  Map<String, String> _encourageMap = {
    'terrible': 'Work on this!',
    'sad': 'Don\'t give up! You got it.',
    'neutral': 'Solid. Keep working!',
    'happy': 'On fire!',
    'great': 'Keep Thr1ving!',
  };

  Map<String, List<String>> questionMap = {
    'Energy': [
      'How intense was your footwork today?',
    ],
    'Mindset': [
      'How supported do you feel by coaches?',
    ],
    'Drive': [
      'How much do you enjoy pushing your limits?',
    ],
    'Performance': [
      'How well did your mindset support your performance today?',
    ],
  };

  Image terrible = Image.asset(
    'images/terrible.png',
    scale: 1.8,
  );
  Image sad = Image.asset(
    'images/sad.png',
    scale: 1.8,
  );
  Image neutral = Image.asset(
    'images/neutral.png',
    scale: 1.6,
  );
  Image happy = Image.asset(
    'images/happy.png',
    scale: 1.8,
  );
  Image great = Image.asset(
    'images/great.png',
    scale: 1.8,
  );

  Icon icon1 = Icon(Icons.circle_outlined);
  Icon icon2 = Icon(Icons.circle_outlined);
  Icon icon3 = Icon(Icons.circle_outlined);
  Icon icon4 = Icon(Icons.circle_outlined);

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
      return Icon(Icons.circle_outlined);
    }
  }

  void encourageText(String name) {
    encourage = _encourageMap[name].toString();
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

  _save(List<Node> n) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int index = prefs.getInt('index') ?? 0;
    final String encoded = Node.encode(n);
    String name = 'answer_key$index';
    await prefs.setString(name, encoded);
    await prefs.setInt('index', index + 1);
  }

  void getQuestions() {
    List<String> mindset = questionMap['Mindset']!.toList();
    List<String> energy = questionMap['Energy']!.toList();
    List<String> performance = questionMap['Performance']!.toList();
    List<String> drive = questionMap['Drive']!.toList();

    mindset..shuffle();
    energy..shuffle();
    performance..shuffle();
    drive..shuffle();

    _questionList.addAll(mindset.sublist(0, 1));
    _categoryList.addAll(['Mindset']);

    _questionList.addAll(energy.sublist(0, 1));
    _categoryList.addAll(['Energy']);

    _questionList.addAll(performance.sublist(0, 1));
    _categoryList.addAll(['Performance']);

    _questionList.addAll(drive.sublist(0, 1));
    _categoryList.addAll(['Drive']);
  }

  Node packData(double rating, String question, String category) {
    Node n = new Node(
      rating: rating,
      question: currQuestion,
      category: currCategory,
    );
    return n;
  }

  String logo = 'images/logo.png';

  Widget readyPage() {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Text(
              'Get in the zone. Check in now.',
              textAlign: TextAlign.center,
              textScaleFactor: 4,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 100,
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    questionIndex++;
                  });
                },
                icon: SizedBox(
                  height: 100,
                  width: 100,
                  child: new Image.asset(
                    logo,
                    color: Colors.white,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  void initState() {
    super.initState();
    fillQuestions();
  }

  @override
  Widget build(BuildContext context) {
    if (questionIndex == -1) {
      return readyPage();
    } else {
      getQuestions();
      currQuestion = _questionList[questionIndex];
      currCategory = _categoryList[questionIndex];
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Image.asset(
            logo,
            scale: 3.2,
          ),
        ),
        body: Column(children: [
          Question(currQuestion),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: 0,
                  right: 0,
                  top: 10,
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
                      height: 40,
                    ),
                    Text(
                      rating.toInt().toString(),
                      textScaleFactor: 5,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: Text(
                        encourage,
                        textScaleFactor: 3,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 5,
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
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getProgressIcon(1),
                  getProgressIcon(2),
                  getProgressIcon(3),
                  getProgressIcon(4),
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
                      if (questionIndex > 0) {
                        setState(() {
                          questionIndex = questionIndex - 1;
                          answers.removeLast();
                        });
                      }
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
                      if (questionIndex < numQuestions) {
                        answers.add(new Node(
                          rating: rating,
                          question: currQuestion,
                          category: currCategory,
                        ));
                        packData(rating, currQuestion, currCategory);
                        setState(() {
                          questionIndex = questionIndex + 1;
                          _answerList.add(rating);
                          if (questionIndex == numQuestions) {
                            questionIndex = 0;
                            _save(answers);
                            saveDate();
                            Navigator.pop(context, true);
                          }
                        });
                      }
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
  }

  void saveDate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String today = DateTime.now().toString().substring(0, 10);
    await prefs.setString('date', today);
    // print('saved: ' + today);
  }

  Future fillQuestions() async {
    final myData = await rootBundle.loadString('images/questionsdata.csv');
    LineSplitter ls = new LineSplitter();
    List<String> lines = ls.convert(myData);
    lines.removeAt(0);
    for (String line in lines) {
      List split = line.split(',');
      questionMap[split[0]]!.add(split[1]);
    }
    return questionMap;
  }
}
