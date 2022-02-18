import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text('Create New Todo')),
        body: ListView(padding: EdgeInsets.all(20.0), children: [
          TextField(
            controller: todo_title,
            decoration: InputDecoration(
                labelText: 'title', border: OutlineInputBorder()),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
            child: ElevatedButton(
              onPressed: () {
                print("############");
                print('title: ${todo_title.text}');
                print('title: ${todo_detail.text}');
                createTodo();
              },
              child: Text("Add"),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.fromLTRB(50, 20, 50, 20)),
                  textStyle:
                      MaterialStateProperty.all(TextStyle(fontSize: 20))),
            ),
          )
        ]),
      ),
    );
  }

  Future createTodo() async {
    //
    var url = Uri.https('rxohm.ngrok.io', '/todo');
    Map<String, String> header = {
      "Content-type": "application/json; charset=UTF-8"
    };
    String jsonData = jsonEncode(
        <String, String>{"title": todo_title.text, "detail": todo_detail.text});
    // '{"title":${todo_title.text}, "detail":${todo_detail.text}}';
    var response = await http.post(url, headers: header, body: jsonData);
    print(response.body);
    todo_title.clear();
    todo_detail.clear();
    return '';
  }
}
