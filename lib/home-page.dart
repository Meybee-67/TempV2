// ignore_for_file: non_constant_identifier_names, unused_local_variable, prefer_const_constructors, use_super_parameters

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:temp/no-data.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
String time = "";
bool _isLoading = false;
String _temperature = '';
bool hotspot = true;

Future<void> fetchData() async {
  setState(() {
    _isLoading = true;
  });
    try {
      final temperature = await http.get(
        Uri.parse('http://192.168.4.1/data'),
      );
      log("this is the response: $temperature");

      if (temperature.statusCode == 200) {
        setState(() {
          _temperature = json.decode(temperature.body)['temperature'];
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
        time = '$_temperature';
        setState(() {
        });
        //mytimer.cancel() //to terminate this timer
});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title:Text("Data display",style: TextStyle(color :Color.fromARGB(255, 201, 170, 207 ),)),
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
        ),
        body: Center(
          child : hotspot
            // ignore: prefer_interpolation_to_compose_strings
            ? Text(time+"°C", style: TextStyle(fontSize: 30),)
            : const NoDataPage()
            //show time on UI
          )
        );
  }
}