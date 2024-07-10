
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class MySliderPage extends StatefulWidget {
  const MySliderPage({Key? key}) : super(key: key);
  @override
  State<MySliderPage> createState() => _MySliderPageState();
}

class _MySliderPageState extends State<MySliderPage> {
bool _isLoading = false;
double _slider = 0;
String _Value="";

Future<void> sendRequest(String message) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final value = await http.post(
        Uri.parse('http://192.168.4.1/morse'),
        body: {'message': message},
      );
      log("this is the morse response: $value");

      if (value.statusCode == 200) {
        setState(() {
          _Value = '$_Value';
          _isLoading = false;
        });
      } else {
        setState(() {
          _Value = 'Failed to send Morse request';
          _isLoading = false;
        });
      }
    } catch (e) {
      log("", error: e, name: "error");
      setState(() {
        _Value = 'Failed to send Morse request';
        _isLoading = false;
      });
    }
  }

void initState() {
    Timer mytimer = Timer.periodic(Duration(seconds: 5), (timer) {
      _Value = '$_Value';
      sendRequest(_Value);
        setState(() {
        });
        //mytimer.cancel() //to terminate this timer
});
    super.initState();
  }


@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
        title: Text('Servomotor',style:  GoogleFonts.roboto( color: Color.fromARGB(255, 116, 75, 153),
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
      body:SfSlider(
        value:_slider,
        min : 0.0,
        max : 180.0,
        interval : 20,
        showLabels : true,
        showTicks: true,
        enableTooltip: true,
        numberFormat: NumberFormat(""),
        onChanged: (value){
          setState((){
          _slider = value;
          _Value=value.toString();
          });
        }
        ));
}
  }