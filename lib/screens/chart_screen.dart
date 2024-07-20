import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:solar_tracker/data/chart.dart';

class MyChartScreenPage extends StatefulWidget {
  MyChartScreenPage({Key? key}) : super(key: key);
  @override
  _MyChartScreenPageState createState() => _MyChartScreenPageState();
}

class _MyChartScreenPageState extends State<MyChartScreenPage> {
  @override
  DateTime now = DateTime.now();
  String formattedDate = DateFormat.yMMMMEEEEd().format(DateTime.now());

  //Get data
String temp="";
bool _isLoading = false;
String _temperature = "";
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
          _temperature = json.decode(data.body)['temperature'];
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
    int time = 0;
    Timer mytimer = Timer.periodic(Duration(seconds: 12),(timer){
      fetchData();
      temp = '$_temperature';
      setState((){
      });
    });
    super.initState();
  }
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Realtime chart',style:  GoogleFonts.roboto( color:Colors.white,
              fontSize: 25,)),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body :Stack(
      children: <Widget>[
        Positioned(
        top: 20,
        left : 20,
        child :
          Container(
          height :300,
          width : 350,
          decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 20,
                spreadRadius: 1,
                color: Colors.black.withOpacity(.25))
          ],
          borderRadius: BorderRadius.circular(20),
          ),
          child :
            MyChartPage(),
        ),
        ),
        Positioned(
          top :350,
          left : 20,
          child: Container(
            margin: const EdgeInsets.only(bottom: (150 * .155) / 4),
            padding: const EdgeInsets.all(20),
            height: 150,
            width :150,
            decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 20,
                spreadRadius: 1,
                color: Colors.black.withOpacity(.25))
          ],
          borderRadius: BorderRadius.circular(20),
          ),
          child : Column(
          children :[
            Text("Current \n Temperature :", style : GoogleFonts.roboto(color: Colors.black, fontSize: 14),textAlign: TextAlign.center),
            const SizedBox(height: 15), //gap
            Text(temp+"°C",style : GoogleFonts.roboto(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
            ]
          )
            )
          ),
      ]
      ),
    );
}
}