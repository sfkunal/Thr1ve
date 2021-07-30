import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './question.dart';
import './user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  var questionIndex = 0;

  String encourage = '';

  List getAnswerList() {
    return _answerList;
  }

  List _questionList = [];
  List _categoryList = [];

  Map<String, String> encourage_map = {
    'terrible': 'Work on this!',
    'sad': 'Don\'t give up! You got it.',
    'neutral': 'Solid. Keep working!',
    'happy': 'On fire!',
    'great': 'Keep Thr1ving!',
  };

  Map<String, List<String>> _questionMap = {
    'Energy': [
      'How intense was your footwork today?',
      'Rate your physical strength today',
      'How conscious are you of what you eat?',
    ],
    // 'How intense was your footwork today?': 'Energy',
    // 'Rate your physical strength today': 'Energy',
    // 'How conscious are you of what you eat?': 'Energy',
    'Mindset': [
      'How supported do you feel by coaches?',
      'How easily are you able to consider constructive feedback?',
      'How well did you stay calm during adversity?',
    ],
    // 'How supported do you feel by coaches?': 'Mindset',
    // 'How easily are you able to consider constructive feedback?': 'Mindset',
    // 'How well did you stay calm during adversity?': 'Mindset',
    'Drive': [
      'How much do you enjoy pushing your limits?',
      'How much do you focus on results and outcomes?',
      'How well do you think you will compete today?',
    ],
    // 'How much do you enjoy pushing your limits?': 'Drive',
    // 'How much do you focus on results and outcomes?': 'Drive',
    // 'How well do you think you will compete today?': 'Drive',
    'Performance': [
      'How well did your mindset support your performance today?',
      'How much did you improve today?',
      'How much do you feel like your training is heading in the right direction?',
    ],
    //   'How well did your mindset support your performance today?': 'Performance',
    //   'How much did you improve today?': 'Performance',
    //   'How much do you feel like your training is heading in the right direction?':
    //       'Performance',
  };

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

  _save(List<Node> n) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int index = prefs.getInt('index') ?? 0;
    final String encoded = Node.encode(n);
    String name = 'answer_key$index';
    await prefs.setString(name, encoded);
    await prefs.setInt('index', index + 1);
    print('saved');
  }

  void getQuestions() {
    // create 4 separate maps corresponding to each category
    // convert each map to a list of its questions
    // select 2 questions from each list and add them to questionLIst
    // add the corresponding category twice.
    //
    List<String> mindset = _questionMap['Mindset']!.toList();
    List<String> energy = _questionMap['Energy']!.toList();
    List<String> performance = _questionMap['Performance']!.toList();
    List<String> drive = _questionMap['Drive']!.toList();

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

    print('today\'s question list: ' + _questionList.toString());

    // var keys = _questionMap.keys.toList()..shuffle();
    // if (_questionList.length < numQuestions) {
    //   for (var k in keys) {
    //     _questionList.add(k);
    //   }
    // }
  }

  Node packData(double rating, String question, String category) {
    Node n = new Node(
      rating: rating,
      question: currQuestion,
      category: currCategory,
    );
    return n;
  }

  // @protected
  // @mustCallSuper
  // void initState() {
  //   super.initState();

  //   getQuestions();
  //   //todo loop thru past month lists and properly initialize all instance variables
  //   //then set feature value instances
  // }

  @override
  Widget build(BuildContext context) {
    getQuestions();
    currQuestion = _questionList[questionIndex];
    // if (_questionMap.containsKey(currQuestion)) {
    //   currCategory = _questionMap[currQuestion].toString();
    // }
    currCategory = _categoryList[questionIndex];

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
        Question(currQuestion),
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
                          Navigator.pop(context, _answerList);
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
