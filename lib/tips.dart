import 'package:flutter/material.dart';

class Tips extends StatefulWidget {
  @override
  _TipsState createState() => _TipsState();
}

class _TipsState extends State<Tips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade400,
      appBar: AppBar(
        title: Text('Tips'),
      ),
      body: Center(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
