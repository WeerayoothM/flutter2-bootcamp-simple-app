import 'package:flutter/material.dart';
import 'package:layout/pages/add.dart';
import 'package:layout/pages/contact.dart';
import 'package:layout/pages/home.dart';
import 'package:layout/pages/todolist.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  final tabs = [Todolist(), AddPage(), ContactPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.brown[800],
        //   title: Text("แนะนำซีรี่ส์ Harry Potter"),
        // ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Todolist"),
            BottomNavigationBarItem(icon: Icon(Icons.create), label: "Add"),
            BottomNavigationBarItem(
                icon: Icon(Icons.contact_mail), label: "Contact"),
          ],
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        body: tabs[_currentIndex]);
  }
}
