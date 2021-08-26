import 'package:flutter/material.dart';

class CalculatePage extends StatefulWidget {
  const CalculatePage({Key? key}) : super(key: key);

  @override
  _CalculatePageState createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
  TextEditingController price = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController result = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    result.text =
        "ซื้อแอปเปิ้ลจำนวน x ผล ราคาผลละ 10 บาท รวมลูกค้าต้องจ่ายทั้งหมด xx บาท";
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Center(
            child: Container(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/apple.png",
                    width: 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("โปรแกรมคำนวณ"),
                  ),
                  TextField(
                      controller: price,
                      decoration: InputDecoration(
                          labelText: "ราคาแอปเปิ้ล",
                          border: OutlineInputBorder())),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                      controller: quantity,
                      decoration: InputDecoration(
                          labelText: "จำนวณแอปเปิ้ล",
                          border: OutlineInputBorder())),
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: onPressed,
                        child: Text("คำนวณ"),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.fromLTRB(50, 20, 50, 20)),
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xffe35b46)),
                            textStyle: MaterialStateProperty.all(
                                TextStyle(fontSize: 30))),
                      )),
                  Text(
                    result.text,
                    style: TextStyle(fontSize: 30),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void onPressed() {
    double cal = double.parse(quantity.text) * double.parse(price.text);
    print("Apple quantity : ${quantity.text} total price : ${cal}");
    setState(() {
      result.text =
          "ซื้อแอปเปิ้ลจำนวน ${quantity.text} ผล ราคาผลละ 10 บาท รวมลูกค้าต้องจ่ายทั้งหมด ${cal} บาท";
    });
  }
}
