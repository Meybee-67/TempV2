import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MySwitchPage extends StatefulWidget {
  const MySwitchPage({Key? key}) : super(key: key);
  @override
  State<MySwitchPage> createState() => _MySwitchPageState();
}

class _MySwitchPageState extends State<MySwitchPage> {
bool light = false;
bool _isLoading = true;
var textValue = 'Switch is OFF';
String _lightstate="";

//Send State
Future<void> sendRequest(String message) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final lightstate = await http.post(
        Uri.parse('http://192.168.4.1/morse'),
        body: {'message': message},
      );
      log("this is the morse response: $lightstate");

      if (lightstate.statusCode == 200) {
        setState(() {
          _lightstate = 'data sent';
          _isLoading = false;
        });
      } else {
        setState(() {
          _lightstate = 'Failed to send request';
          _isLoading = false;
        });
      }
    } catch (e) {
      log("", error: e, name: "error");
      setState(() {
        _lightstate = 'Failed to send request';
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
        textValue = 'Switch Button is ON';
        _lightstate = "ON";
        sendRequest(_lightstate);
      });
      print('Switch Button is ON');
    }
    else
    {
      setState(() {
        light = false;
        textValue = 'Switch Button is OFF';
        _lightstate = "OFF";
        sendRequest(_lightstate);
      });
      print('Switch Button is OFF');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: const Text('Switch button'),
      centerTitle: true,
    ),
    body : Stack(
    children: <Widget>[
      Positioned(
      top : 300,
      left : 170,
      child : Switch(
      // This bool value toggles the switch.
      value: light,
      activeColor: Colors.blueAccent,
      onChanged: toggleSwitch,
    ),
    ),
    Positioned(
      top : 350,
      left : 120,
      child : Text('$textValue', style: TextStyle(fontSize: 20),),
    )
    ]
      )
    );
  }
}