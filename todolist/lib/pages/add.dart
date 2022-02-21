import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

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
          RoundedLoadingButton(
            child: Text('Tap me!', style: TextStyle(color: Colors.white)),
            controller: _btnController,
            onPressed: () async {
              print("############");
              print('title: ${todo_title.text}');
              print('title: ${todo_detail.text}');
              await createTodo();
              _btnController.success();
              Timer(Duration(seconds: 1), () {
                Navigator.pop(
                  context,
                  todo_title.text,
                );
                setState(() {
                  todo_title.clear();
                  todo_detail.clear();
                });
              });
            },
          )
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
          //   child: ElevatedButton(
          //     onPressed: () {
          //       print("############");
          //       print('title: ${todo_title.text}');
          //       print('title: ${todo_detail.text}');
          //       createTodo();
          //       setState(() {
          //         todo_title.clear();
          //         todo_detail.clear();
          //       });
          //     },
          //     child: Text("Add"),
          //     style: ButtonStyle(
          //         backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
          //         padding: MaterialStateProperty.all(
          //             EdgeInsets.fromLTRB(50, 20, 50, 20)),
          //         textStyle:
          //             MaterialStateProperty.all(TextStyle(fontSize: 20))),
          //   ),
          // )
        ]),
      ),
    );
  }

  Future createTodo() async {
    //
    String baseUrl = dotenv.get('BASE_API_URL');
    print(baseUrl);
    var url = Uri.https(baseUrl, '/todo');
    Map<String, String> header = {
      "Content-type": "application/json; charset=UTF-8"
    };
    String jsonData = jsonEncode(
        <String, String>{"title": todo_title.text, "detail": todo_detail.text});
    // '{"title":${todo_title.text}, "detail":${todo_detail.text}}';
    var response = await http.post(url, headers: header, body: jsonData);
    print(response.body);

    return '';
  }
}
