import 'package:flutter/material.dart';
import './answers.dart';
import './question.dart';

class Questions extends StatefulWidget {
  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  var _questionMap = {
    'How energized did you wake up this morning?': 'Physical',
    'How supported did you feel by coaches?': 'Enjoyment',
    'How easily are you able to consider constructive feedback?': 'Performance'
  };
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
          'How supported did you feel by coaches?',
        ),
        Answers(),
      ]),
    );
  }
}
