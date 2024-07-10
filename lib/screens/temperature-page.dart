import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    appBar: AppBar(
        title: Text('Dashboard',style:  GoogleFonts.roboto( color: Color.fromARGB(255, 116, 75, 153),
              fontSize: 25,
              shadows: [
                    Shadow(
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                      color: Colors.black.withOpacity(.15),
                    )
                  ])),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,
      ),
    drawer: Drawer(
      backgroundColor: Colors.white,
      child : Column(
      children :[
        DrawerHeader(child: Text("More options",style:  GoogleFonts.roboto( color: Color.fromARGB(255, 116, 75, 153),
              fontSize: 25,
              shadows: [
                    Shadow(
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                      color: Colors.black.withOpacity(.15),
                    )
                  ]))),
        ListTile(
          leading: Icon(Icons.power_settings_new),
          title : Text("Sleep mode"),
          onTap:(){},
        ),
        ListTile(
          leading: Icon(Icons.battery_charging_full_rounded),
          title : Text("Power supply"),
          onTap:(){},
        ),
      ],
      ),
    ),
    body : Stack(
      children: <Widget>[
          const Positioned(
          top: 10,
          left : 20,
          child : Text("Wissembourg", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
          ),
        Positioned(
          top :40,
          left :20,
          child : Text(formattedDate,style:const TextStyle(fontSize:15),)),
        Positioned(
          top:100,
          right:50,
          child : Text(tempR+"°C",style: TextStyle(fontSize: 30))
        ),
        ]
    )
    );
  }
}