import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create New Todo')),
      body: ListView(padding: EdgeInsets.all(16.0), children: [
        TextField(
          controller: todo_title,
          decoration:
              InputDecoration(labelText: 'title', border: OutlineInputBorder()),
        ),
        SizedBox(
          height: 30,
        ),
        TextField(
          minLines: 3,
          maxLines: 8,
          controller: todo_detail,
          decoration: InputDecoration(
              labelText: 'detail', border: OutlineInputBorder()),
        ),
        SizedBox(
          height: 30,
        ),
      ]),
    );
  }
}
