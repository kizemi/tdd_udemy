import 'package:flutter/cupertino.dart';

import '../constants.dart';
import 'button.dart';

class KeyPad extends StatelessWidget {

  funcOnPress onPress;
  KeyPad(this.onPress, {super.key});


  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: <Widget>[
          Expanded(child: Button("C",   colorMain, colorFunc, onPress)),  // 黒文字×薄灰背景
          Expanded(child: Button("+/-", colorMain, colorFunc, onPress)),
          Expanded(child: Button("%",   colorMain, colorFunc, onPress)),
          Expanded(child: Button("/",   colorText, colorCalc, onPress)),  // 白文字×オレンジ背景
          // Button("C",   colorFunc, colorMain, onPress),
          // Button("+/-", colorFunc, colorMain, onPress),
          // Button("%",   colorFunc, colorMain, onPress),
          // Button("/",   colorCalc, colorText, onPress),
        ],
      ),
      // 2段目（数字）
      Row(
        children: <Widget>[
          Expanded(child: Button("7", colorText, colorNum, onPress)), // 白文字×淡い背景
          Expanded(child: Button("8", colorText, colorNum, onPress)),
          Expanded(child: Button("9", colorText, colorNum, onPress)),
          Expanded(child: Button("x", colorText, colorCalc, onPress)), // 白文字×オレンジ背景
          // Button("7", colorMain, colorText, onPress),
          // Button("8", colorMain, colorText, onPress),
          // Button("9", colorMain, colorText, onPress),
          // Button("x", colorCalc, colorText, onPress),
        ],
      ),
      // 3段目（数字）
      Row(
        children: <Widget>[
          Expanded(child: Button("4", colorText, colorNum, onPress)),
          Expanded(child: Button("5", colorText, colorNum, onPress)),
          Expanded(child: Button("6", colorText, colorNum, onPress)),
          Expanded(child: Button("-", colorText, colorCalc, onPress)),
          // Button("4", colorMain, colorText, onPress),
          // Button("5", colorMain, colorText, onPress),
          // Button("6", colorMain, colorText, onPress),
          // Button("-", colorCalc, colorText, onPress),
        ],
      ),
      // 4段目（数字）
      Row(
        children: <Widget>[
          Expanded(child: Button("1", colorText, colorNum, onPress)),
          Expanded(child: Button("2", colorText, colorNum, onPress)),
          Expanded(child: Button("3", colorText, colorNum, onPress)),
          Expanded(child: Button("+", colorText, colorCalc, onPress)),
          // Button("1", colorMain, colorText, onPress),
          // Button("2", colorMain, colorText, onPress),
          // Button("3", colorMain, colorText, onPress),
          // Button("+", colorCalc, colorText, onPress),
        ],
      ),
      // 5段目（0は横長）
      Row(
        children: <Widget>[
          Expanded(flex: 2, child: Button("0", colorText, colorNum, onPress)),
          Expanded(child: Button(".", colorText, colorNum, onPress)),
          Expanded(child: Button("=", colorText, colorCalc, onPress)),
          // Button("0", colorMain, colorText, onPress),
          // Button(".", colorCalc, colorText, onPress),
          // Button("=", colorCalc, colorText, onPress),
        ],
      ),
    ],);
  }
}
