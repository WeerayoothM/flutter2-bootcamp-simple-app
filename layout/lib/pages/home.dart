import 'dart:convert';

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
    return FutureBuilder(
      builder: (context, snapshot) {
        // snapshot => ลักษณะของข้อมูล
        var data = json.decode(snapshot.data.toString());
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Mybox(data[index]['title'], data[index]['subtitle'],
                  data[index]['image_url']),
            );
          },
          itemCount: data.length,
        );
      },
      // function ที่เกี่ยวกับการประมวลผลข้อมูลเผื่อในกรณีที่ data ยังโหลดไม่เสร็จ
      // ได้ผลลัพท์มาเป็นเหมือน list -> snapshot
      future:
          DefaultAssetBundle.of(context).loadString('assets/data/data.json'),
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
