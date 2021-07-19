import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  var question;
  Question(String question) {
    this.question = question;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 20,
      ),
      decoration: BoxDecoration(color: Colors.indigo[100]),
      child: Text(
        question,
        textScaleFactor: 2,
        textAlign: TextAlign.center,
      ),
    );
  }
}
