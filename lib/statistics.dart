import 'package:fl_chart/fl_chart.dart';
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
            Container(
              padding: EdgeInsets.only(
                left: 0,
                right: 0,
                top: 15,
                bottom: 90,
              ),
              child: Column(
                children: [
                  Text(
                    'Overall Graph',
                    textScaleFactor: 1.4,
                  ),
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: LineChart(
                      LineChartData(
                          // read about it in the LineChartData section
                          ),
                      swapAnimationDuration:
                          Duration(milliseconds: 150), // Optional
                      swapAnimationCurve: Curves.linear, // Optional
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
