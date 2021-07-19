import 'package:flutter/material.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';

class ScoreGraph extends StatefulWidget {
  @override
  _ScoreGraphState createState() => _ScoreGraphState();
}

final List<Feature> features = [
  Feature(
    title: "Overall",
    color: Colors.blue,
    data: [0.42, 0.56, 0.46, 0.64, 0.69],
  ),
  Feature(
    title: "Mindset",
    color: Colors.pink,
    data: [.23, 0.25, 0.21, 0.28, 0.35],
  ),
  Feature(
    title: "Energy",
    color: Colors.cyan,
    data: [0.65, 0.72, 0.69, 0.73, 0.78],
  ),
  Feature(
    title: "Performance",
    color: Colors.green,
    data: [0.7, 0.75, 0.79, 0.82, .80],
  ),
  Feature(
    title: "Drive",
    color: Colors.amber,
    data: [0.81, .78, 0.72, 0.81, 0.87],
  ),
];

class _ScoreGraphState extends State<ScoreGraph> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 64.0),
          child: Text(
            "Score Breakdown",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
        LineGraph(
          features: features,
          size: Size(320, 450),
          labelX: ['Wk 1', 'Wk 2', 'Wk 3', 'Wk 4', 'Wk 5'],
          labelY: ['2.0', '4.0', '6.0', '8.0', '10.0'],
          showDescription: true,
          graphColor: Colors.grey,
          graphOpacity: 0.2,
          verticalFeatureDirection: true,
          descriptionHeight: 210,
        ),
        SizedBox(
          height: 50,
        )
      ],
    );
  }
}
