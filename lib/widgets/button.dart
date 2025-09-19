import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';


typedef funcOnPress = void Function(String text);

class Button extends StatelessWidget {

  final String text;
  final Color colorButton;

  final Color colorText;
  // final Color colorFill;   // 背景色

  final funcOnPress onPressed;

  Button(this.text, this.colorButton, this.colorText, this.onPressed, {super.key});


  @override
  Widget build(BuildContext context) {
    final bool isIcon = mapIcon.containsKey(text);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        onPressed: () => onPressed(text),
        style: ElevatedButton.styleFrom(
          foregroundColor: colorButton,   // テキスト/アイコン色
          backgroundColor: colorText,     // 背景色
          shape: text == "0" ? const StadiumBorder() : const CircleBorder(),
          padding: text == "0"
              ? const EdgeInsets.symmetric(horizontal: 20, vertical: 20)
              : const EdgeInsets.all(22),
        ),
        child: isIcon
            ? Icon(mapIcon[text], size: 28) // 演算子はアイコンで
            : Text(                         // 数字などはテキストで
          text,
          style: TextStyle(fontSize: 30, color: colorButton),
        ),
      ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 5),
//       child: ElevatedButton(
//         onPressed: () {
//           onPressed(text);
//         },
//         style: ElevatedButton.styleFrom(
//           foregroundColor: colorButton,  // アイコン色
//           backgroundColor: colorFill,    // 背景色
//           shape: text == "0" ? const StadiumBorder() : const CircleBorder(),
//         ),
//         child: Padding(
//           padding: text == "0"
//               ? const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20)
//               : text.length == 1
//               ? const EdgeInsets.all(22)
//               : const EdgeInsets.symmetric(horizontal: 15, vertical: 22),
//           child: Icon(mapIcon[text], size: 30),
//         ),
//       ),
//     );
//   }
// }
