import 'package:flutter/material.dart';
import './answers.dart';
import './question.dart';

class Questions extends StatefulWidget {
  @override
  QuestionsState createState() => QuestionsState();
}

class QuestionsState extends State<Questions> {
  var questionIndex = 0;
  var maxQuestions = 4;
  String currQuestion = '';
  var _questionList = [
    'How intense was your footwork today?',
    'How supported do you feel by coaches?',
    'How easily are you able to consider constructive feedback?',
    'question 4',
    'question 5'
  ];

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
        Answers(),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
                iconSize: 40,
                onPressed: () {
                  // s.back();
                },
                icon: Icon(Icons.arrow_back_ios_sharp)),
            label: 'back',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
                iconSize: 40,
                onPressed: () {
                  // s.back();
                },
                icon: Icon(Icons.arrow_forward_ios_sharp)),
            label: 'next',
          ),
        ],
      ),
    );
  }

  void next() {
    setState(() {
      questionIndex = questionIndex + 1;
    });
  }

  void back() {
    setState(() {
      questionIndex = questionIndex - 1;
    });
  }

  void buttonPressed() {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (ctxt) => new Questions()),
    );
    // print('button pressed');
    // setState(() {
    //   answerCount = answerCount + 1;
    // });
    // if (answerCount > maxQuestions) {
    //   answerCount = 0;
    // }
    // answerCount++;
    // print(answerCount);
  }
}
