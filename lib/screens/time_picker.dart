import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class TimerPickerExample extends StatefulWidget {
  const TimerPickerExample({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TimerPickerExampleState createState() => _TimerPickerExampleState();
}

class _TimerPickerExampleState extends State<TimerPickerExample> {
var h = 0;
var m = 0;
var s =0;
bool _isLoading = true;
String _sleep_time="";
late int total;

//Send State
Future<void> sendRequest(String message) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final sleep_time = await http.post(
        Uri.parse('http://192.168.4.1/morse'),
        body: {'message': message},
      );
      log("this is the morse response: $sleep_time");

      if (sleep_time.statusCode == 200) {
        setState(() {
          _sleep_time = 'data sent';
          _isLoading = false;
        });
      } else {
        setState(() {
          _sleep_time = 'Failed to send request';
          _isLoading = false;
        });
      }
    } catch (e) {
      log("", error: e, name: "error");
      setState(() {
        _sleep_time = 'Failed to send request';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ESP32 Sleeping time',style:  GoogleFonts.roboto( color:Colors.white,
              fontSize: 25)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
          // BoxDecoration takes the image
          decoration: const BoxDecoration(
            // Image set to background of the body
            image: DecorationImage(
                image: AssetImage("assets/pictures/moon(2).jpg"), fit: BoxFit.cover,scale:0.7),
          )
          ),
          Padding(
            padding: const EdgeInsets.only(top:60,left:50),
            child :Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            const Text("Sleeping time",style : TextStyle(fontSize: 24,color : Colors.white)),
            const SizedBox(height: 15),
            Text("${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, "0")}:${s.toString().padLeft(2, '0')}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 35,color: Colors.white)),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border : Border.all(width: 1, color :Colors.transparent),
                  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NumberPicker(
                    minValue: 0,
                    maxValue: 12,
                    value: h,
                    zeroPad: true,
                    infiniteLoop: true,
                    itemWidth: 80,
                    itemHeight: 60,
                    onChanged: (value) {
                      setState(() {
                        h = value;
                      });
                    },
                    textStyle:
                        const TextStyle(color: Colors.grey, fontSize: 20),
                    selectedTextStyle:
                        const TextStyle(color: Colors.white, fontSize: 30),
                    decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(
                            color: Colors.white,
                          ),
                          bottom: BorderSide(color: Colors.white)),
                    ),
                  ),
                  NumberPicker(
                    minValue: 0,
                    maxValue: 59,
                    value: m,
                    zeroPad: true,
                    infiniteLoop: true,
                    itemWidth: 80,
                    itemHeight: 60,
                    onChanged: (value) {
                      setState(() {
                        m = value;
                      });
                    },
                    textStyle:
                        const TextStyle(color: Colors.grey, fontSize: 20),
                    selectedTextStyle:
                        const TextStyle(color: Colors.white, fontSize: 30),
                    decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(
                            color: Colors.white,
                          ),
                          bottom: BorderSide(color: Colors.white)),
                    ),
                  ),
                  NumberPicker(
                    minValue: 0,
                    maxValue: 59,
                    value: s,
                    zeroPad: true,
                    infiniteLoop: true,
                    itemWidth: 80,
                    itemHeight: 60,
                    onChanged: (value) {
                      setState(() {
                        s = value;
                      });
                    },
                    textStyle:
                        const TextStyle(color: Colors.grey, fontSize: 20),
                    selectedTextStyle:
                        const TextStyle(color: Colors.white, fontSize: 30),
                    decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(
                            color: Colors.white,
                          ),
                          bottom: BorderSide(color: Colors.white)),
                    ),
                  ),
                    ],
                  )
            ),
          ]
          ),
            ),
            Positioned(
              top : 600,
              right:165,
              child: FloatingActionButton(
                    backgroundColor: const Color.fromARGB(255, 190, 190, 190),
                    child: Icon(Icons.play_arrow),
                    mini : true,
                    onPressed: (){
                      total = h*3600+m*60+s;
                     } //seconds
    )
    ),
    ],
    )
    );
  }
}