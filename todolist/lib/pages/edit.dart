import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:rounded_loading_button/rounded_loading_button.dart';

class EditPage extends StatefulWidget {
  // const EditPage({Key? key}) : super(key: key);

  final id, title, detail;
  EditPage(this.id, this.title, this.detail);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  var _id, _title, _detail;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _id = widget.id;
    _title = widget.title;
    _detail = widget.detail;
    setState(() {
      todo_title.text = _title;
      todo_detail.text = _detail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Todo'),
          actions: [
            IconButton(
                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                onPressed: () async {
                  print('Delete Id : $_id');
                  await deleteTodo();
                  String statusMessage = '';
                  try {
                    statusMessage = 'delete success';
                  } catch (err) {
                    print(err);
                    statusMessage = 'delete fail';
                  } finally {
                    Navigator.pop(
                      context,
                      statusMessage,
                    );
                  }
                },
                icon: Icon(
                  Icons.delete,
                  color: Color.fromARGB(255, 249, 178, 202),
                ))
          ],
        ),
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
              await updateTodo();
              _btnController.success();
              Navigator.pop(
                context,
                todo_title.text,
              );
            },
          )
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
          //   child: ElevatedButton(
          // onPressed: () async {
          //   print("############");
          //   print('title: ${todo_title.text}');
          //   print('title: ${todo_detail.text}');
          //   await updateTodo();
          //   Navigator.pop(
          //     context,
          //     todo_title.text,
          //   );
          //   // setState(() {
          //   //   todo_title.clear();
          //   //   todo_detail.clear();
          //   // });
          // },
          //     child: Text("Save"),
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

  Future updateTodo() async {
    var url = Uri.https('catowner-todolistapi.herokuapp.com', '/todo/${_id}');
    print(url);
    Map<String, String> header = {
      "Content-type": "application/json; charset=UTF-8"
    };
    String jsonData = jsonEncode(
        <String, String>{"title": todo_title.text, "detail": todo_detail.text});
    var response = await http.patch(url, headers: header, body: jsonData);

    return '';
  }

  Future deleteTodo() async {
    print('define url');
    var url = Uri.https('catowner-todolistapi.herokuapp.com', '/todo/${_id}');
    Map<String, String> header = {
      "Content-type": "application/json; charset=UTF-8"
    };

    await http.delete(url, headers: header);

    return '';
  }
}
