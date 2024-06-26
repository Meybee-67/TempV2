import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:real_time_chart/real_time_chart.dart';

class MyChartPage extends StatefulWidget{
  const MyChartPage({Key? key}) : super(key: key);

  @override
  _MyChartPageState createState() => _MyChartPageState();
}

class _MyChartPageState extends State<MyChartPage>{

String temp = "";
bool _isLoading = false;
String _temperature = '';
bool hotspot = true;

Future<void> fetchData() async {
  setState(() {
    _isLoading = true;
  });
    try {
      final response = await http.get(
        Uri.parse('http://192.168.4.1/data'),
      );
      log("this is the response: $response");

      if (response.statusCode == 200) {
        setState(() {
          _temperature = json.decode(response.body)['temperature'];
          _isLoading = false;
        });
      } else {
        setState(() {
          _temperature = "Failed to fetch data";
          _isLoading = false;
          hotspot = false;
        });
      }
    } catch (e) {
      log("", error: e, name: "error");
      setState(() {
        _temperature = "Failed to fetch data";
        _isLoading = false;
        hotspot=false;
      });
    }
    _isLoading = false;
  }
@override
  void initState() {
  Timer mytimer = Timer.periodic(Duration(seconds: 5), (timer) {
        fetchData();
        temp = '$_temperature';
        setState(() {
        });
        //mytimer.cancel() //to terminate this timer
});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final stream = positiveDataStream();

    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display a real-time graph of positive data
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 0.5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RealTimeGraph(
                    stream: stream.map((value) => value - 10),
                    supportNegativeValuesDisplay: true,
                    displayMode: ChartDisplay.points,
                  ),
                ),
              ),
            ]
          )
        )
      ),
      );
}
Stream<double> positiveDataStream() {
    return Stream.periodic(const Duration(milliseconds: 500), (_) {
      return double.parse(temp);
    }).asBroadcastStream();
  }
}
