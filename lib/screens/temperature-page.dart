import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:solar_tracker/screens/switch.dart';

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
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
    drawer: Drawer(
      backgroundColor: Colors.white,
      child : Column(
      children :[
        DrawerHeader(child: Text("More options",style:  GoogleFonts.roboto( color: const Color.fromARGB(255, 116, 75, 153),
              fontSize: 25,
              shadows: [
                    Shadow(
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                      color: Colors.black.withOpacity(.15),
                    )
                  ]))),
        ListTile(
          leading: const Icon(Icons.power_settings_new),
          title : const Text("Sleep mode"),
          onTap:(){
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MySwitchPage()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.battery_charging_full_rounded),
          title : const Text("Power supply"),
          onTap:(){},
        ),
      ],
      ),
    ),
    body : DecoratedBox(
          // BoxDecoration takes the image
          decoration: const BoxDecoration(
            // Image set to background of the body
            image: DecorationImage(
                image: AssetImage("assets/pictures/solar-2.jpg"), fit: BoxFit.cover,scale:0.7),
          ),
          child : Stack(
      children: <Widget>[
          const Positioned(
          top: 100,
          left : 20,
          child : Text("Wissembourg", style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color:Colors.white),)
          ),
        Positioned(
          top :140,
          left :20,
          child : Text(formattedDate,style:const TextStyle(fontSize:15,color:Colors.white),)),
        Positioned(
          top:500,
          left:20,
          child : Text(tempR+"°C",style: TextStyle(fontSize: 50,color : Colors.white))
        ),
        ]
    )
    )
    );
  }
}