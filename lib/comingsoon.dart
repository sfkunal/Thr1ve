import 'package:flutter/material.dart';

class ComingSoon extends StatelessWidget {
  Image ss = Image.asset(
    'images/future.png',
    scale: 1.5,
  );
  Text description = Text(
    'UTR via Thr1ve coming soon!',
    textScaleFactor: 3,
    textAlign: TextAlign.center,
    style: TextStyle(color: Colors.white),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade400,
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [ss, Center(child: description)],
      ),
    );
  }
}
