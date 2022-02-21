import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:http/http.dart' as http;
import 'package:todolist/pages/add.dart';
import 'package:todolist/pages/edit.dart';
import 'package:todolist/toJson/todo.dart';

class Todolist extends StatefulWidget {
  const Todolist({Key? key}) : super(key: key);

  @override
  _TodolistState createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  @override
  void initState() {
    super.initState();
    print('initial');
    // fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todolist"),
        actions: [IconButton(onPressed: fetchTodo, icon: Icon(Icons.refresh))],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                    context, MaterialPageRoute(builder: (context) => AddPage()))
                .then((value) {
              final snackBar = SnackBar(
                content: const Text('Yay! Create Complete!'),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),
              );

              // Find the ScaffoldMessenger in the widget tree
              // and use it to show a SnackBar.
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              setState(() {
                fetchTodo();
              });
            });
          }),
      body: LoaderOverlay(
        child: FutureBuilder(
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              context.loaderOverlay.show();
              return Container();
            }
            List<Todo> data = snapshot.data;

            context.loaderOverlay.hide();
            return Padding(
              padding: const EdgeInsets.all(20),
              child: ListView.builder(
                // padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                itemBuilder: (BuildContext context, int index) {
                  return TodoItem(
                    context,
                    data[index].id,
                    data[index].title,
                    data[index].detail,
                  );
                },
                itemCount: data.length,
              ),
            );
          },
          future: fetchTodo(),
        ),
      ),
    );
  }

  Widget TodoItem(BuildContext context, int id, String title, String detail) {
    var v1, v2;
    v1 = title;
    v2 = detail;

    return Card(
        child: ListTile(
            title: Text(title),
            subtitle: Text(detail),
            onTap: () {
              _awaitReturnValueFromSecondScreen(context, id, title, detail);
            }));
  }

  void _awaitReturnValueFromSecondScreen(
      BuildContext context, int id, String v1, String v2) async {
    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditPage(id, v1, v2)),
    );

    if (result == null) {
      return;
    }
    if (result == 'delete success') {
      final snackBar = SnackBar(
        content: Text('Yay! ${result}!'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      fetchTodo();
    });
  }

  Future fetchTodo() async {
    String baseUrl = dotenv.get('BASE_API_URL');
    final String url = 'https://$baseUrl/todo';
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
