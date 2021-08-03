import 'package:flutter/material.dart';

class SameDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'You\'ve already answered your check-in for today. Come back tomorrow!',
                textAlign: TextAlign.center,
                textScaleFactor: 4,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: SizedBox(
                  height: 100,
                  width: 100,
                  child: new Image.asset(
                    'images/logo.png',
                    color: Colors.white,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
