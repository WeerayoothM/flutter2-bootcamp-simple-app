import 'package:flutter/material.dart';
import 'package:layout/pages/detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[800],
        title: Text("แนะนำซีรี่ส์ Harry Potter"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Mybox("Harry Potter Ep1", "Harry Potter and the Philosopher's Stone",
              "https://blog.estantevirtual.com.br/wp-content/uploads/Capa-blog-HP.png"),
          SizedBox(
            height: 10,
          ),
          Mybox("Harry Potter Ep2", "Harry Potter and the Chamber of Secrets",
              "https://img-ha.mthcdn.com/a3K2ksVKj_ZII_h0zq2rOWxpKVs=/950x275/smart/mono29.com/app/wp-post-thumbnail/04Rhq1.jpg"),
          SizedBox(
            height: 10,
          ),
          Mybox("Harry Potter Ep3", "Harry Potter and the Prisoner of Azkaban",
              "https://potterstoryweb.com/wp-content/uploads/2015/11/pt3.jpg"),
          SizedBox(
            height: 10,
          ),
          Mybox("Harry Potter Ep4", "Harry Potter and the Goblet of Fire",
              "https://imgix.bustle.com/rehost/2016/9/13/aa2d5a63-4454-4d6a-bce5-b138f3b0ae08.jpg?w=1200&h=630&fit=crop&crop=faces&fm=jpg"),
        ],
      ),
    );
  }

  Widget Mybox(String title, String description, String url) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // color: Colors.blue[50],
          image: DecorationImage(
              image: NetworkImage(url),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4), BlendMode.darken))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            description,
            style: TextStyle(
                fontSize: 15, color: Colors.white, fontStyle: FontStyle.italic),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DetailPage()));
                },
                child: Text(
                  "Read more...",
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
