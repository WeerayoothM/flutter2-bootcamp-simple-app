import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:layout/utils/toJson/todo.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:http/http.dart' as http;

class Todolist extends StatefulWidget {
  const Todolist({Key? key}) : super(key: key);

  @override
  _TodolistState createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  @override
  void initState() {
    super.initState();
    // fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: FutureBuilder(
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            context.loaderOverlay.show();
            return Container();
          }
          List<Todo> data = snapshot.data;
          print('load data');
          print(data[0].title);
          context.loaderOverlay.hide();
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TodoItem(data[index].title, data[index].detail));
            },
            itemCount: data.length,
          );
        },
        future: fetchTodo(),
      ),
    );
  }

  Widget TodoItem(String title, String detail) {
    var v1, v2;
    v1 = title;
    v2 = detail;

    return Container(
      padding: EdgeInsets.all(20),
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // color: Colors.blue[50],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            detail,
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontStyle: FontStyle.italic),
          ),
          // SizedBox(
          //   height: 20,
          // ),
          // Container(
          //   alignment: Alignment.centerRight,
          //   child: TextButton(
          //       onPressed: () {
          //         Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => DetailPage(v1, v2, v3, v4)));
          //       },
          //       child: Text(
          //         "Read more...",
          //         style: TextStyle(color: Colors.black),
          //       )),
          // )
        ],
      ),
    );
  }

  Future fetchTodo() async {
    const String url = 'http://localhost:8000/todo';
    final response = await http.get(Uri.parse(url)); // here i passed http.get

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //* solution 1
      // Iterable l = jsonDecode(response.body);
      // List<Todo> todos = List<Todo>.from(l.map((e) => Todo.fromJson(e)));
      // return todos;

      //* solution 2
      List<Todo> todos = (json.decode(response.body) as List)
          .map((e) => Todo.fromJson(e))
          .toList();
      return todos;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load todo');
    }
  }
}
