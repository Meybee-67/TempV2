import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';

class TimerPickerExample extends StatefulWidget {
  const TimerPickerExample({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TimerPickerExampleState createState() => _TimerPickerExampleState();
}

class _TimerPickerExampleState extends State<TimerPickerExample> {
var hour = 0;
  var minute = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ESP32 Sleeping time',style:  GoogleFonts.roboto( color:const Color.fromARGB(255, 136, 107, 195),
              fontSize: 25,
              shadows: [
                    Shadow(
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                      color: Colors.black.withOpacity(.15),
                    )
                  ])),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Sleeping time",style : TextStyle(fontSize: 24)),
            const SizedBox(height: 15),
            Text("${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, "0")}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 35)),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border : Border.all(width: 1, color :Colors.white),
                  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NumberPicker(
                    minValue: 0,
                    maxValue: 12,
                    value: hour,
                    zeroPad: true,
                    infiniteLoop: true,
                    itemWidth: 80,
                    itemHeight: 60,
                    onChanged: (value) {
                      setState(() {
                        hour = value;
                      });
                    },
                    textStyle:
                        const TextStyle(color: Colors.grey, fontSize: 20),
                    selectedTextStyle:
                        const TextStyle(color: Color.fromARGB(255, 55, 55, 55), fontSize: 30),
                    decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(
                            color: Color.fromARGB(255, 55, 55, 55),
                          ),
                          bottom: BorderSide(color: Color.fromARGB(255, 55, 55, 55))),
                    ),
                  ),
                  NumberPicker(
                    minValue: 0,
                    maxValue: 59,
                    value: minute,
                    zeroPad: true,
                    infiniteLoop: true,
                    itemWidth: 80,
                    itemHeight: 60,
                    onChanged: (value) {
                      setState(() {
                        minute = value;
                      });
                    },
                    textStyle:
                        const TextStyle(color: Colors.grey, fontSize: 20),
                    selectedTextStyle:
                        const TextStyle(color: Color.fromARGB(255, 55, 55, 55), fontSize: 30),
                    decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(
                            color: Color.fromARGB(255, 55, 55, 55),
                          ),
                          bottom: BorderSide(color: Color.fromARGB(255, 55, 55, 55))),
                    ),
                  ),
                    ],
                  )
            ),
            Positioned(
              top : 500,
              right:20,
              child: ElevatedButton(
                child: Text('Save',style : TextStyle(color : Colors.black)),
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 209, 208, 208),),
                onPressed: () {},
          ),
              ),
          ]
              ),
            ),
    );
  }
}