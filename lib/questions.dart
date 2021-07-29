import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import './question.dart';
import 'dart:io';
import './user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Questions extends StatefulWidget {
  @override
  QuestionsState createState() => QuestionsState();
}

class QuestionsState extends State<Questions> {
  String currQuestion = '';
  String currCategory = '';
  var _answerList = [];
  var rating = 5.0;
  var numQuestions = 5;
  var questionIndex = 0;

  String encourage = '';

  List getAnswerList() {
    return _answerList;
  }

  List _questionList = [];

  Map<String, String> encourage_map = {
    'terrible': 'Work on this!',
    'sad': 'Don\'t give up! You got it.',
    'neutral': 'Solid. Keep working!',
    'happy': 'On fire!',
    'great': 'Keep Thr1ving!',
  };

  Map<String, String> _questionMap = {
    'How intense was your footwork today?': 'Energy',
    'How supported do you feel by coaches?': 'Mindset',
    'How easily are you able to consider constructive feedback?': 'Mindset',
    'How conscious are you of what you eat?': 'Energy',
    'How much do you enjoy pushing your limits?': 'Drive',
    'How well did your mindset support your performance today?': 'Performance',
    'How well did you stay calm during adversity?': 'Mindset'
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

  _clear() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/response.txt');
      file.writeAsStringSync('');
      print('cleared');
      print(file.readAsString().toString());
    } catch (e) {
      print('Couldn\'t read file');
    }
  }

  _read() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String musicsString = await prefs.getString('answer_key').toString();
    final List<Node> nodes = Node.decode(musicsString);

    print('read: ' + nodes.toString());
  }

  _save(Node n) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encoded = Node.encode([n]);
    await prefs.setString('answer_key', encoded);

    print('saved: ' + n.toString() + ' as ' + encoded);
  }

  void getQuestions() {
    var keys = _questionMap.keys.toList()..shuffle();
    if (_questionList.length < numQuestions) {
      for (var k in keys) {
        _questionList.add(k);
      }
      print('today\'s question list: ' + _questionList.toString());
    }
  }

  Node packData(double rating, String question, String category) {
    Node n = new Node(
      rating: rating,
      question: currQuestion,
      category: currCategory,
    );
    print(n.toString());
    _save(n);
    _read();
    // _clear();
    return n;
  }

  @override
  Widget build(BuildContext context) {
    getQuestions();
    currQuestion = _questionList[questionIndex];
    if (_questionMap.containsKey(currQuestion)) {
      currCategory = _questionMap[currQuestion].toString();
    }

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
                      packData(rating, currQuestion, currCategory);
                      setState(() {
                        questionIndex = questionIndex + 1;
                        _answerList.add(rating);
                        if (questionIndex == numQuestions) {
                          questionIndex = 0;
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
