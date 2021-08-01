import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  Image help = Image.asset(
    'images/HelpScreen.png',
    scale: 9,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade400,
      appBar: AppBar(
        title: Text('Info'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 40),
            help,
          ],
        ),
      ),
    );
  }
}
