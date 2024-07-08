import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:temp/data/chart.dart';

class MyChartScreenPage extends StatefulWidget {
  MyChartScreenPage({Key? key}) : super(key: key);
  @override
  _MyChartScreenPageState createState() => _MyChartScreenPageState();
}

class _MyChartScreenPageState extends State<MyChartScreenPage> {
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Realtime chart',style:  GoogleFonts.roboto( color:Color.fromARGB(255, 116, 75, 153),
              fontSize: 25,
              shadows: [
                    Shadow(
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                      color: Colors.black.withOpacity(.15),
                    )
                  ])),
        backgroundColor: Color.fromARGB(255, 255, 254, 254),
        centerTitle: true,
      ),
      body : Stack(
      children: <Widget>[
        Positioned(
        top: 20,
        left : 20,
        child : Container(
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
          child : MyChartPage(),
        )
        ),
      ]
      ),
    );
}
}