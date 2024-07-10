import 'package:flutter/material.dart';
import 'package:temp/data/datatable.dart';
import 'package:temp/screens/chart-screen.dart';
import 'package:temp/screens/temperature-page.dart';

class BottomBarWidget extends StatefulWidget {
  const BottomBarWidget({Key? key}) : super(key: key);

  @override
  _BottomBarWidgetState createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  int _selectedIndex = 0;
  List <Widget> body = [
    TemperaturePage(),
    ArchiveScreen(),
    MyChartScreenPage(),
  ];

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  //Save page state
  body : IndexedStack(
        index: _selectedIndex,
        children: body,
      ),
  
  //Each icon in an index
  bottomNavigationBar: BottomNavigationBar(
    currentIndex: _selectedIndex, //New
    onTap: (int newIndex){
      setState((){_selectedIndex=newIndex;});
      
    },

//Create the bottom bar
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.archive_outlined),
        label: 'Database',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.show_chart_outlined),
        label: 'Chart',
      ),
    ],
  ),
  );
}
}