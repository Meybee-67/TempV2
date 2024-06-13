// ignore_for_file: library_private_types_in_public_api, use_super_parameters

import 'package:flutter/material.dart';

class NoDataPage extends StatefulWidget {
  const NoDataPage({Key? key}) : super(key: key);

  @override
  _NoDataPageState createState() => _NoDataPageState();
}

class _NoDataPageState extends State<NoDataPage>{
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
          title: const Text('Error',style:TextStyle(color:Color.fromARGB(255, 206, 31, 19), fontSize: 25,fontWeight: FontWeight.bold )),
        ),
        body: Center(
        child: Column(
            children:<Widget>[
              Container(
                child : Image.asset("assets/images/data_not_found.jpg",scale:1,),
                ),
              Container(
                alignment: Alignment.center,
                child: const Text('AP connection lost...',style: TextStyle(
                  color: Color.fromARGB(255, 3, 3, 3),
                  fontSize:16),)
              ),
              Positioned(
            bottom: 100,
            left: 30,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Retry"),
            ),
          )
            ],
          )
        ),
        );
  }
}