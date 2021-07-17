import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  var rating = 1.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Statistics'),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Slider(
              value: rating,
              onChanged: (newRating) {
                setState(() => rating = newRating);
                // print(rating);
              },
              divisions: 10,
            )
          ],
        ),
      ),
    );
  }
}
