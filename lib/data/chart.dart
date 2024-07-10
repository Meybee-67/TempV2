import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class MyChartPage extends StatefulWidget {
  MyChartPage({Key? key}) : super(key: key);
  @override
  _MyChartPageState createState() => _MyChartPageState();
}

class _MyChartPageState extends State<MyChartPage> {
  late List<LiveData> chartData;
  late ChartSeriesController _chartSeriesController;

//Get data
bool _isLoading = false;
String _temperatureR = "";
bool hotspot = true;

Future<void> fetchData() async {
  setState(() {
    _isLoading = true;
  });
    try {
      final data = await http.get(
        Uri.parse('http://192.168.4.1/data'),
      );
      log("this is the response: $data");

      if (data.statusCode == 200) {
        setState(() {
          _temperatureR = json.decode(data.body)['temperature'];
          _isLoading = false;
        });
      } else {
        setState(() {
          _temperatureR = "Failed to fetch data";
          _isLoading = false;
          hotspot = false;
        });
      }
    } catch (e) {
      log("", error: e, name: "error");
      setState(() {
        _temperatureR = "Failed to fetch data";
        _isLoading = false;
        hotspot=false;
      });
    }
    _isLoading = false;
  }


  @override
  void initState() {
    int time = 0;
    chartData = getChartData();
    Timer mytimer = Timer.periodic(Duration(seconds: 1),(timer){
      fetchData();
      String tempR = '$_temperatureR';
      setState(() {
        if(hotspot=true){
        double? tempRD = double.tryParse(tempR);
        chartData.add(LiveData(time++,tempRD));
      chartData.removeAt(0);
      _chartSeriesController.updateDataSource(
      addedDataIndex: chartData.length - 1, removedDataIndex: 0);
      }});
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
    child : Scaffold(
            body: SfCartesianChart(
              title: const ChartTitle(
                text:'Temperature',
                alignment: ChartAlignment.near,
                  textStyle: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  )
              ),
                series: <LineSeries<LiveData, int>>[
          LineSeries<LiveData, int>(
            onRendererCreated: (ChartSeriesController controller) {
              _chartSeriesController = controller;
            },
            dataSource: chartData,
            color: const Color.fromARGB(255, 126, 205, 245),
            xValueMapper: (LiveData sales, _) => sales.time,
            yValueMapper: (LiveData sales, _) => sales.speed,
          )
        ],
                primaryXAxis: const NumericAxis(
                    majorGridLines: MajorGridLines(width: 0),
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    interval: 10,
                    title: AxisTitle(text: 'Time (seconds)')),
                primaryYAxis: const NumericAxis(
                    axisLine: AxisLine(width: 0),
                    majorTickLines: MajorTickLines(size: 0),
                    minimum: -10,
                    maximum: 40,
                    interval: 5,
                    title: AxisTitle(text: '(°C)')))));
  }


  List<LiveData> getChartData() {
    return <LiveData>[
      LiveData(0, 0),
      LiveData(1,0),
      LiveData(2, 5),
      LiveData(3, 10),
      LiveData(4, 15),
      LiveData(5, 15),
      LiveData(6, 15),
      LiveData(7, 15),
      LiveData(8, 15),
      LiveData(9, 15),
    ];
  }
}

class LiveData {
  LiveData(this.time, this.speed);
  final int time;
  final double? speed;
}