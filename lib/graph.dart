import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_data.dart';

class ScoreGraph extends StatefulWidget {
  @override
  _ScoreGraphState createState() => _ScoreGraphState();
}

final int daysOnRecord = 30;

List<Point> mindsetData = [];
List<Point> energyData = [];
List<Point> performanceData = [];
List<Point> driveData = [];

List<double> mindset = [0];
List<double> energy = [0];
List<double> performance = [0];
List<double> drive = [0];

late bool isShowingMainData;

class _ScoreGraphState extends State<ScoreGraph> {
  List<List<Node>> pastMonth = [];

  Future<List<List<Node>>> _read() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<List<Node>> data = [];

    int startIndex = prefs.getInt('index') ?? 0;
    startIndex = startIndex - 1;
    //todo: render different page if index == -1
    int endIndex = startIndex - 30 < 0 ? 0 : startIndex - 30;
    for (int i = startIndex; i > endIndex; i--) {
      // print(i.toString() + 'h');
      final String answerString = prefs.getString('answer_key$i').toString();
      final List<Node> nodes = Node.decode(answerString);
      setState(() {
        data.add(nodes);
      });
    }
    return data;
  }

  Future<List<List<Node>>> _prefill() async {
    List<List<Node>> data = await _read();
    setState(() {
      pastMonth = data;
    });
    // print(pastMonth.toString());
    return pastMonth;
  }

  void _fill() {
    List<double> currMindset = [-1];
    List<double> currEnergy = [-1];
    List<double> currPerformance = [-1];
    List<double> currDrive = [-1];
    for (int i = 0; i < pastMonth.length; i++) {
      for (int j = 0; j < pastMonth[i].length; j++) {
        String currCategory = pastMonth[i][j].category;
        double currRating = pastMonth[i][j].rating;

        if (currCategory == 'Mindset') {
          setState(() {
            currMindset.add(currRating);
          });
        } else if (currCategory == 'Energy') {
          setState(() {
            currEnergy.add(currRating);
          });
        } else if (currCategory == 'Performance') {
          setState(() {
            currPerformance.add(currRating);
          });
        } else if (currCategory == 'Drive') {
          setState(() {
            currDrive.add(currRating);
          });
        } else {
          print('unexpected value in graph class');
        }
      }
    }

    setState(() {
      currMindset.removeAt(0);
      currEnergy.removeAt(0);
      currPerformance.removeAt(0);
      currDrive.removeAt(0);
      mindset = List.from(currMindset.reversed);
      energy = List.from(currEnergy.reversed);
      performance = List.from(currPerformance.reversed);
      drive = List.from(currDrive.reversed);
    });
    int startIndex =
        mindset.length - daysOnRecord < 0 ? 0 : mindset.length - daysOnRecord;
    mindset = mindset.sublist(startIndex);
    energy = energy.sublist(startIndex);
    performance = performance.sublist(startIndex);
    drive = drive.sublist(startIndex);

    for (int i = 0; i < mindset.length; i++) {
      setState(() {
        mindsetData.add(new Point(i, mindset[i]));
      });
    }
    for (int i = 0; i < energy.length; i++) {
      energyData.add(new Point(i, energy[i]));
    }
    for (int i = 0; i < performance.length; i++) {
      performanceData.add(new Point(i, performance[i]));
    }
    for (int i = 0; i < drive.length; i++) {
      driveData.add(new Point(i, drive[i]));
    }

    // print('mindset: ' + mindset.toString());
    // print('energy: ' + energy.toString());
    // print('performance: ' + performance.toString());
    // print('drive: ' + drive.toString());
  }

  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    isShowingMainData = true;
    _prefill();
  }

  double avg(List<double> list) {
    double average = 0;
    list.forEach((element) {
      average += element;
    });
    average = average / list.length;
    return average;
  }

  @override
  Widget build(BuildContext context) {
    _fill();
    return Container(
      decoration: new BoxDecoration(color: Colors.deepPurple),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1 / 1,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.purple.shade900,
                    Color(0xff46426c),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(
                        height: 37,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const Text(
                        'Thr1ve Results',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 37,
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 16.0, left: 6.0),
                          child: LineChart(
                            sampleData1(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
              height: 246,
              child: Column(
                children: [],
              ))
        ],
      ),
    );
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 14:
                return 'Responses This Month';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 2:
                return '2';
              case 4:
                return '4';
              case 6:
                return '6';
              case 8:
                return '8';
              case 10:
                return '10';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 30,
      maxY: 10,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<FlSpot> toList(List<double> lst) {
    List<FlSpot> answers = [];
    for (int i = 0; i < lst.length; i++) {
      if (i < 28) {
        answers.add(new FlSpot(i.toDouble(), lst[i]));
      }
    }
    return answers;
  }

  List<LineChartBarData> linesBarData1() {
    final lineChartBarData1 = LineChartBarData(
      spots: toList(mindset),
      isCurved: true,
      colors: [Colors.blue],
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    final lineChartBarData2 = LineChartBarData(
      spots: toList(energy),
      isCurved: true,
      colors: [Colors.greenAccent.shade400],
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x00aa4cfc),
      ]),
    );
    final lineChartBarData3 = LineChartBarData(
      spots: toList(performance),
      isCurved: true,
      colors: [
        Colors.purple,
      ],
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    final lineChartBarData4 = LineChartBarData(
      spots: toList(drive),
      isCurved: true,
      colors: [Colors.black],
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    return [
      lineChartBarData1,
      lineChartBarData2,
      lineChartBarData3,
      lineChartBarData4,
    ];
  }
}

class Point {
  final int day;
  final double rating;
  Point(this.day, this.rating);
  String toString() {
    return "(" + this.day.toString() + "," + this.rating.toString() + ")";
  }
}
