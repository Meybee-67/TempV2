// ignore_for_file: library_private_types_in_public_api, use_super_parameters

import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:temp/screens/home-page.dart';
import 'package:wifi_iot/wifi_iot.dart';

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
          backgroundColor: Colors.white,
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
              onPressed: () {
                showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('WiFi disabled'),
        content: const Text('Please enable WiFi, and try again'),
        actions: [
          TextButton(
            onPressed: () async {
              if (!mounted) return; // Ajoutez cette ligne ici aussi
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
                (Route<dynamic> route) => false
              );
              
            if (Platform.isAndroid) {
            await WiFiForIoTPlugin.setEnabled(true, shouldOpenSettings: true);
            }
            
            },
            child: const Text('Enable WiFi'),
          ),
        ],
      ),
    );
              },
              child: const Text("Reconnect")
            ),
          )
            ],
          )
        ),
        );
  }
}