import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Map<String, IconData> mapIcon = <String, IconData>{
  "+/-": CupertinoIcons.plus_slash_minus,
  "%":   CupertinoIcons.percent,
  "/":   CupertinoIcons.divide,
  "x":   CupertinoIcons.multiply,
  "-":   CupertinoIcons.minus,
  "+":   CupertinoIcons.plus,
  "=":   CupertinoIcons.equal,
};


// 色の定義
const Color colorMain = Colors.black;   // 機能キーの文字の色
const Color colorText = Colors.white;   // 機能キー以外の数字の色

const Color colorNum = Colors.white10;  // 数字キーの背景の色
const Color colorFunc = Colors.white54; // 機能キー背景の色
const Color colorCalc = Colors.orange;  // 演算子キー背景の色