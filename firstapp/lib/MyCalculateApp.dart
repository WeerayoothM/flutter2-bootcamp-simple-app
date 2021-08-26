import 'package:flutter/material.dart';

class MyCalculateApp extends StatefulWidget {
  final String title;

  const MyCalculateApp({Key? key, required this.title}) : super(key: key);

  @override
  _MyCalculateAppState createState() => _MyCalculateAppState();
}

class _MyCalculateAppState extends State<MyCalculateApp> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Image.asset(
            'assets/images/Hello-World-logo.png',
            width: 100,
          ),
          Text(
            'Hello, Wolrd',
            style: TextStyle(fontSize: 30, fontFamily: 'HoneyBaby'),
          ),
        ],
      )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
