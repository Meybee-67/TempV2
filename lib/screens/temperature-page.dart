import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


class TemperaturePage extends StatefulWidget{
  const TemperaturePage({Key? key}) : super(key: key);

  @override
  _TemperaturePageState createState() => _TemperaturePageState();
}


class _TemperaturePageState extends State<TemperaturePage>{
  //Get time
  DateTime now = DateTime.now();
  String formattedDate = DateFormat.yMMMMEEEEd().format(DateTime.now());

  //Get data
String tempR = "";
bool _isLoading = false;
String _temperatureR = '';
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
          _temperatureR = json.decode(data.body)['rounded temperature'];
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
  Timer mytimer = Timer.periodic(Duration(seconds: 5), (timer) {
        fetchData();
        tempR = '$_temperatureR';
        setState(() {
        });
        //mytimer.cancel() //to terminate this timer
});
    super.initState();
  }


  Widget build(BuildContext context){
    return Scaffold(
    body : Stack(
      children: <Widget>[
          const Positioned(
          top: 60,
          left : 20,
          child : Text("Wissembourg", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
          ),
        Positioned(
          top :95,
          left :20,
          child : Text(formattedDate,style:const TextStyle(fontSize:15),)),
        Positioned(
          top:140,
          right:50,
          child : Text(tempR+"°C",style: TextStyle(fontSize: 30))
        ),
        ]
    )
    );
  }
}