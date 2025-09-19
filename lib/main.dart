import 'package:flutter/material.dart';
import 'package:tdd_udemy3/widgets/keypad.dart';

import 'constants.dart';
import 'logic.dart';

void main() {
  runApp(const MyApp()); // ✅ const OK
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // ✅ null-safety

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String txtResult = "0";
  final Logic _logic = Logic();

  @override
  Widget build(BuildContext context) {

    onPress(String text){
      _logic.input(text);
      setState(() {
        txtResult = _logic.text;
      });
    }

    return Scaffold(
      backgroundColor: colorMain,
      body: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // 結果表示
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    txtResult,
                    style: const TextStyle(
                      color: colorText,
                      fontSize: 60,
                    ),
                    textAlign: TextAlign.right,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            KeyPad(onPress),
          ],
        ),
      ),
    );
  }
}



