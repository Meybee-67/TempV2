import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:solar_tracker/screens/time_picker.dart';

class MySwitchPage extends StatefulWidget {
  const MySwitchPage({Key? key}) : super(key: key);
  @override
  State<MySwitchPage> createState() => _MySwitchPageState();
}

class _MySwitchPageState extends State<MySwitchPage> {
bool light = true;
bool deep_sleep=false;
bool _isLoading = true;
String _WiFiState="";

//Send State
Future<void> sendRequest(message) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final WiFiState = await http.post(
        Uri.parse('http://192.168.4.1/morse'),
        body: {'message': message},
      );
      log("this is the morse response: $WiFiState");

      if (WiFiState.statusCode == 200) {
        setState(() {
          _WiFiState = 'data sent';
          _isLoading = false;
        });
      } else {
        setState(() {
          _WiFiState = 'Failed to send request';
          _isLoading = false;
        });
      }
    } catch (e) {
      log("", error: e, name: "error");
      setState(() {
      _WiFiState = 'Failed to send request';
        _isLoading = false;
      });
    }
  }


//State switch
  void toggleSwitch(bool value) {
    if(light== false)
    {
      setState(() {
        light = true;
        _WiFiState= "ON";
        deep_sleep=false;
        sendRequest(_WiFiState);
      });
    }
    else
    {
      setState(() {
        light = false;
        _WiFiState = "OFF";
        sendRequest(_WiFiState);
      });
    }
  }

//Deep sleep
void deepSleep(bool value){
  if(deep_sleep==true){
    setState(() {
      deep_sleep=true;
      light = false;
      Navigator.push(context,MaterialPageRoute(builder: (context) => const TimerPickerExample()),);
    });
  }
  if(light==true){
    setState(() {
      deep_sleep=false;
    });
  }
  if(deep_sleep==false){
    setState(() {
      deep_sleep=false;
      _WiFiState = "OFF";
      sendRequest(_WiFiState);
    });
  }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text('Sleep mode', style: GoogleFonts.roboto(color:const Color.fromARGB(255, 136, 107, 195),
              fontSize: 25,
              shadows: [
                    Shadow(
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                      color: Colors.black.withOpacity(.15),
                    )
                  ])),
      centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 255, 254, 254),
    ),
    body : Stack(
    children: <Widget>[
      Positioned(
      top : 110,
      right:40,
      child : Switch(
      // This bool value toggles the switch.
      value: light,
      activeColor: Colors.white,
      activeTrackColor: const Color.fromARGB(255, 136, 107, 195),
      onChanged: toggleSwitch,
    ),
    ),
    const Positioned(
      top : 120,
      left :90,
      child : Text('WiFi', style: TextStyle(fontSize: 20),),
    ),
    const Positioned(
      top:120,
      left:50,
      child: Icon(Icons.wifi),
      ),
      Positioned(
      top : 160,
      right:40,
      child : Switch(
      // This bool value toggles the switch.
      value: light,
      activeColor: Colors.white,
      activeTrackColor: const Color.fromARGB(255, 136, 107, 195),
      onChanged: toggleSwitch,
    ),
    ),
    const Positioned(
      top : 170,
      left :90,
      child : Text('Bluetooth', style: TextStyle(fontSize: 20),),
    ),
    const Positioned(
      top:170,
      left:50,
      child: Icon(Icons.bluetooth),
      ),
      Positioned(
      top : 210,
      right:40,
      child : Switch(
      // This bool value toggles the switch.
      value: deep_sleep,
      activeColor: Colors.white,
      activeTrackColor: const Color.fromARGB(255, 136, 107, 195),
      onChanged: (bool value){
        setState(() {
          deep_sleep=value;
          deepSleep(value);
        });
      }
    ),
    ),
    const Positioned(
      top : 220,
      left :90,
      child : Text('Deep sleep', style: TextStyle(fontSize: 20),),
    ),
    const Positioned(
      top:220,
      left:50,
      child: Icon(CupertinoIcons.moon_zzz_fill,size: 28.0,),
      ),
    ]
      )
    );
  }
}