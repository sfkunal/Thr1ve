import 'package:flutter/material.dart';
import './answers.dart';
import './question.dart';

class Questions extends StatefulWidget {
  @override
  QuestionsState createState() => QuestionsState();
}

class QuestionsState extends State<Questions> {
  var answerCount = 0;
  var maxQuestions = 4;
  var _questionMap = {
    'How energized did you wake up this morning?': 'Physical',
    'How supported do you feel by coaches?': 'Enjoyment',
    'How easily are you able to consider constructive feedback?': 'Performance',
    'question 4': 'Physical',
    'question 5': 'Physical',
  };
  var _questionList = [
    'How energized did you wake up this morning?',
    'How supported do you feel by coaches?',
    'How easily are you able to consider constructive feedback?',
    'question 4',
    'question 5'
  ];

  void buttonPressed() {
    if (answerCount > 4) {
      answerCount = 0;
    }
    // print(answerCount);
    answerCount++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text(
            'Questionnaire',
          ),
        ),
      ),
      body: Column(children: [
        Question(
          _questionList[answerCount],
        ),
        Answers(),
      ]),
    );
  }
}
