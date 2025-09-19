import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart' as intl;
import 'package:tdd_udemy3/logic.dart';
import 'package:tdd_udemy3/logic.dart';

void main() {

  /// 現在の値
  late Logic logic;

  setUp(() {
    logic = Logic();
  });

  group("integer", () {
    test("1をそのまま出力", () {
      expect(logic.text, "0");
      logic.input("2");
      expect(logic.text, "2");
    });

    test("2をそのまま出力", () {
      expect(logic.text, "0");
      logic.input("2");
      expect(logic.text, "2");
    });

    test("3をそのまま出力", () {
      expect(logic.text, "0");
      logic.input("3");
      expect(logic.text, "3");
    });


    test("連続入力", () {
      expect(logic.text, "0");
      logic.input("1");
      expect(logic.text, "1");
      logic.input("2");
      expect(logic.text, "12");
      logic.input("3");
      expect(logic.text, "123");
      logic.input("4");
      expect(logic.text, "1,234");
      logic.input("5");
      expect(logic.text, "12,345");
      logic.input("6");
      expect(logic.text, "123,456");
      logic.input("7");
      expect(logic.text, "1,234,567");
      logic.input("8");
      expect(logic.text, "12,345,678");
      logic.input("9");
      expect(logic.text, "123,456,789");
    });


    test("3桁区切りのテスト", () {
      intl.NumberFormat formatter = intl.NumberFormat('#,###.########', 'en_US');

      expect(formatter.format(123), "123");
      expect(formatter.format(1234), "1,234");
      expect(formatter.format(1234567), "1,234,567");
      expect(formatter.format(123456789), "123,456,789");
    });
  });

  group('decimalPoint', () {
    test("小数点", () {
      intl.NumberFormat formatter = intl.NumberFormat('#,###.########', 'en_US');

      expect(formatter.format(123), "123");
      expect(formatter.format(1234), "1,234");
      expect(formatter.format(1234567), "1,234,567");
      expect(formatter.format(123456789), "123,456,789");

      expect(formatter.format(1.23), "1.23");
      expect(formatter.format(12.34), "12.34");
      expect(formatter.format(1234.567), "1,234.567");
      expect(formatter.format(1.23456789), "1.23456789");

      expect(formatter.format(0.000001), "0.000001");

      // 別で対応 このようには動かない
      // expect(formatter.format(0.0), "0.0");
      // expect(formatter.format(0.000000), "0.000000");
    });

    test("小数点の入力", () {
      expect(logic.text, "0");
      logic.input("1");
      expect(logic.text, "1");
      logic.input(".");
      expect(logic.text, "1.");
      logic.input("2");
      expect(logic.text, "1.2");
      logic.input("3");
      expect(logic.text, "1.23");
      logic.input("4");
      expect(logic.text, "1.234");
      logic.input("5");
      expect(logic.text, "1.2345");
      logic.input("6");
      expect(logic.text, "1.23456");
      logic.input("7");
      expect(logic.text, "1.234567");
      logic.input("8");
      expect(logic.text, "1.2345678");
      logic.input("9");
      expect(logic.text, "1.23456789");
    });

    test("0.00000000", () {
      expect(logic.text, "0");
      logic.input("0");
      logic.input(".");
      logic.input("0");
      logic.input("0");
      logic.input("0");
      logic.input("0");
      logic.input("0");
      logic.input("0");
      logic.input("0");
      logic.input("0");
      expect(logic.text, "0.00000000");
    });
  });

  group("getDisplayText", () {
    test("整数", () {
      expect(logic.getDisplayText(0), "0");
      expect(logic.getDisplayText(1), "1");
      expect(logic.getDisplayText(1234), "1,234");
      expect(logic.getDisplayText(56789), "56,789");
      expect(logic.getDisplayText(123456789), "123,456,789");
    });

    test("0の時", () {
      expect(logic.getDisplayText(0, numAfterPoint: 0), "0.");
      expect(logic.getDisplayText(0, numAfterPoint: 1), "0.0");
      expect(logic.getDisplayText(0, numAfterPoint: 8), "0.00000000");
    });


    test("小数点以下飲みの時", () {
      expect(logic.getDisplayText(0.1, numAfterPoint: 1), "0.1");
      expect(logic.getDisplayText(0.12345678, numAfterPoint: 1), "0.12345678");
    });

    test("1以上で小数点がある時", () {
      expect(logic.getDisplayText(1.1, numAfterPoint: 1), "1.1");
      expect(logic.getDisplayText(12345.678, numAfterPoint: 3), "12,345.678");
    });

    test("1以上で最後が0の時", () {
      expect(logic.getDisplayText(1.0, numAfterPoint: 0), "1.");
      expect(logic.getDisplayText(1234.0, numAfterPoint: 0), "1,234.");

      expect(logic.getDisplayText(1.0, numAfterPoint: 1), "1.0");
      expect(logic.getDisplayText(12345.000, numAfterPoint: 3), "12,345.000");
    });

    test("round",(){
      expect(logic.getDisplayText(10 / 3, numAfterPoint: 8), "3.33333333");
      expect(logic.getDisplayText(1 / 3, numAfterPoint: 8), "0.33333333");
      expect(logic.getDisplayText(100 / 3, numAfterPoint: 7), "33.3333333");

      expect(logic.getDisplayText(20000 / 3, numAfterPoint: 5), "6,666.66667");
      expect(logic.getDisplayText(2000 / 3, numAfterPoint: 6), "666.666667");
      expect(logic.getDisplayText(20 / 3, numAfterPoint: 8), "6.66666667");
      expect(logic.getDisplayText(2 / 3, numAfterPoint: 8), "0.66666667");
    });
  });

  group("getDigit", () {
    test("同値クラステスト", () {
      expect(logic.getDigit(0), 1);
      expect(logic.getDigit(1), 1);
      expect(logic.getDigit(12), 2);
      expect(logic.getDigit(123), 3);
      expect(logic.getDigit(1234), 4);
      expect(logic.getDigit(12345), 5);
      expect(logic.getDigit(123456), 6);
      expect(logic.getDigit(1234567), 7);
      expect(logic.getDigit(12345678), 8);
      expect(logic.getDigit(123456789), 9);
    });

    test("境界値テスト", () {
      expect(logic.getDigit(0), 1);
      expect(logic.getDigit(1), 1);
      expect(logic.getDigit(9), 1);
      expect(logic.getDigit(10), 2);
      expect(logic.getDigit(11), 2);
      expect(logic.getDigit(99), 2);
      expect(logic.getDigit(100), 3);
      expect(logic.getDigit(101), 3);

      expect(logic.getDigit(99999999), 8);
      expect(logic.getDigit(100000000), 9);
      expect(logic.getDigit(100000001), 9);
      expect(logic.getDigit(999999999), 9);
    });

  });

  group("Ignore9orMoreDigits", () {
    test("整数", () {
      logic.input("1");
      logic.input("2");
      logic.input("3");
      logic.input("4");
      logic.input("5");
      logic.input("6");
      logic.input("7");
      logic.input("8");
      logic.input("9");
      expect(logic.text, "123,456,789");
      logic.input("0");
      expect(logic.text, "123,456,789");
    });

    test("少数あり", () {
      logic.input("1");
      logic.input("2");
      logic.input("3");
      logic.input(".");
      logic.input("4");
      logic.input("5");
      logic.input("6");
      logic.input("7");
      logic.input("8");
      logic.input("9");
      expect(logic.text, "123.456789");
      logic.input("9");
      expect(logic.text, "123.456789");
    });

    test("少数あり2", () {
      logic.input("0");
      logic.input(".");
      logic.input("1");
      logic.input("2");
      logic.input("3");
      logic.input(".");
      logic.input("4");
      logic.input("5");
      logic.input("6");
      logic.input("7");
      logic.input("8");
      logic.input("9");
      expect(logic.text, "0.12345678");
    });

  });

// 掛け算
  group("multiplication",(){
    test("2x3=6",(){
      logic.input("2");
      expect(logic.text, "2");
      expect(logic.currentValue, 2);
      expect(logic.previousValue, 0);
      expect(logic.memorialValue, 0);

      logic.input("x");
      expect(logic.previousOperation, "x");
      expect(logic.currentValue, 0);
      expect(logic.previousValue, 2);
      expect(logic.memorialValue, 0);
      expect(logic.text, "2");

      logic.input("3");
      expect(logic.text, "3");
      expect(logic.currentValue, 3);
      expect(logic.previousValue, 2);
      expect(logic.memorialValue, 0);

      logic.input("=");
      expect(logic.text, "6");
      expect(logic.currentValue, 0);
      expect(logic.previousValue, 0);
      expect(logic.memorialValue, 0);
    });

    test("2x3x4x5=120",(){
      logic.input("2");
      logic.input("x");
      logic.input("3");
      logic.input("x");
      logic.input("4");
      logic.input("x");
      logic.input("5");
      logic.input("=");
      expect(logic.text, "120");
    });
  });

// 割り算
  group("division",(){
    test("10/2=5",(){
      logic.input("1");
      logic.input("0");
      expect(logic.text, "10");
      expect(logic.currentValue, 10);
      expect(logic.previousValue, 0);
      expect(logic.memorialValue, 0);

      logic.input("/");
      expect(logic.previousOperation, "/");
      expect(logic.currentValue, 0);
      expect(logic.previousValue, 10);
      expect(logic.memorialValue, 0);
      expect(logic.text, "10");

      logic.input("2");
      expect(logic.text, "2");
      expect(logic.currentValue, 2);
      expect(logic.previousValue, 10);
      expect(logic.memorialValue, 0);

      logic.input("=");
      expect(logic.text, "5");
      expect(logic.currentValue, 0);
      expect(logic.previousValue, 0);
      expect(logic.memorialValue, 0);
    });

    test("120/3/4=10",(){
      logic.input("1");
      logic.input("2");
      logic.input("0");
      logic.input("/");
      logic.input("3");
      logic.input("/");
      logic.input("4");
      logic.input("=");
      expect(logic.text, "10");
    });

    test("2/3=0.66666667",(){
      logic.input("2");
      logic.input("/");
      logic.input("3");
      logic.input("=");
      expect(logic.text, "0.66666667");
    });
  });

  // 足し算
  group("addition",(){
    test("2+3=5",(){
      logic.input("2");
      expect(logic.text, "2");
      expect(logic.currentValue, 2);
      expect(logic.previousValue, 0);
      expect(logic.memorialValue, 0);

      logic.input("+");
      expect(logic.previousOperation, "");
      expect(logic.memorialOperation, "+");
      expect(logic.currentValue, 0);
      expect(logic.previousValue, 0);
      expect(logic.memorialValue, 2);
      expect(logic.text, "2");

      logic.input("3");
      expect(logic.text, "3");
      expect(logic.currentValue, 3);
      expect(logic.previousValue, 0);
      expect(logic.memorialValue, 2);

      logic.input("=");
      expect(logic.text, "5");
      expect(logic.currentValue, 0);
      expect(logic.previousValue, 0);
      expect(logic.memorialValue, 0);
    });


    test("2+3+4+5=14",(){
      logic.input("2");
      logic.input("+");
      logic.input("3");
      logic.input("+");
      logic.input("4");
      logic.input("+");
      logic.input("5");
      logic.input("=");
      expect(logic.text, "14");
    });
  });

  // 引き算
  group("subtraction",(){
    test("5-3=2",(){
      logic.input("5");
      expect(logic.text, "5");
      expect(logic.currentValue, 5);
      expect(logic.previousValue, 0);
      expect(logic.memorialValue, 0);

      logic.input("-");
      expect(logic.previousOperation, "");
      expect(logic.memorialOperation, "-");
      expect(logic.currentValue, 0);
      expect(logic.previousValue, 0);
      expect(logic.memorialValue, 5);
      expect(logic.text, "5");

      logic.input("3");
      expect(logic.text, "3");
      expect(logic.currentValue, 3);
      expect(logic.previousValue, 0);
      expect(logic.memorialValue, 5);

      logic.input("=");
      expect(logic.text, "2");
      expect(logic.currentValue, 0);
      expect(logic.previousValue, 0);
      expect(logic.memorialValue, 0);
    });

    test("20-1-2-3=14",(){
      logic.input("2");
      logic.input("0");
      logic.input("-");
      logic.input("1");
      logic.input("-");
      logic.input("2");
      logic.input("-");
      logic.input("3");
      logic.input("=");
      expect(logic.text, "14");
    });
  });

  // 四則演算混在
  group("Mixed Four arithmetic operations", (){
    test("足し算引き算",(){
      logic.input("3");
      logic.input("+");
      logic.input("4");
      logic.input("-");
      logic.input("5");
      logic.input("=");
      expect(logic.text, "2");
    });
    test("掛け算割り算",(){
      logic.input("3");
      logic.input("x");
      logic.input("4");
      logic.input("/");
      logic.input("6");
      logic.input("=");
      expect(logic.text, "2");
    });
    test("3x4+5x4=32",(){
      logic.input("3");
      logic.input("x");
      logic.input("4");
      logic.input("+");
      expect(logic.memorialValue, 12);
      expect(logic.text, "12");
      expect(logic.currentValue, 0);
      expect(logic.previousValue, 0);
      expect(logic.previousOperation, "");
      expect(logic.memorialOperation, "+");

      logic.input("5");
      logic.input("x");
      logic.input("4");
      logic.input("=");
      expect(logic.text, "32");
    });

    test("3x4+5x4x3=72",(){
      logic.input("3");
      logic.input("x");
      logic.input("4");
      logic.input("+");
      logic.input("5");
      logic.input("x");
      logic.input("4");
      logic.input("x");
      logic.input("3");
      logic.input("=");
      expect(logic.text, "72");
    });

    test("5x4+5x4/2=30",(){
      logic.input("5");
      logic.input("x");
      logic.input("4");
      logic.input("+");
      logic.input("5");
      logic.input("x");
      logic.input("4");
      logic.input("/");
      logic.input("2");
      logic.input("=");
      expect(logic.text, "30");
    });

    test("5x4-5x4/2=10",(){
      logic.input("5");
      logic.input("x");
      logic.input("4");
      logic.input("-");
      logic.input("5");
      logic.input("x");
      logic.input("4");
      logic.input("/");
      logic.input("2");
      logic.input("=");
      expect(logic.text, "10");
    });

    test("5x4-5x4x2=-20",(){
      logic.input("5");
      logic.input("x");
      logic.input("4");
      logic.input("-");
      logic.input("5");
      logic.input("x");
      logic.input("4");
      logic.input("x");
      logic.input("2");
      logic.input("=");
      expect(logic.text, "-20");
    });
  });

  group("round", (){
    test("小数点以下0桁", (){
      expect(logic.round(1.1, 0), 1);

      // 2の分け目
      expect(logic.round(1.499, 0), 1);
      expect(logic.round(1.500, 0), 2);
      expect(logic.round(2.49, 0), 2);
      expect(logic.round(2.5, 0), 3);

      // 最大値
      expect(logic.round(99999998.4, 0), 99999998);
      expect(logic.round(99999998.5, 0), 99999999);
      expect(logic.round(99999999.499, 0), 99999999);
    });

    test("小数点以下1桁", (){
      expect(logic.round(1.04, 0), 1);
      expect(logic.round(1.1, 1), 1.1);
      expect(logic.round(1.14, 1), 1.1);
      expect(logic.round(1.15, 1), 1.2);
    });

    test("小数点以下4桁", (){
      expect(logic.round(1.00004, 4), 1.0000);
      expect(logic.round(1.00005, 4), 1.0001);
      expect(logic.round(1.0001, 4), 1.0001);
      expect(logic.round(1.00014, 4), 1.0001);
      expect(logic.round(1.00015, 4), 1.0002);

      expect(logic.round(1234.00004, 4), 1234.0000);
      expect(logic.round(1234.00005, 4), 1234.0001);
      expect(logic.round(1234.0001, 4), 1234.0001);
      expect(logic.round(1234.00014, 4), 1234.0001);
      expect(logic.round(1234.00015, 4), 1234.0002);
    });

    test("小数点以下7桁", (){
      expect(logic.round(1.00000004, 7), 1.0000000);
      expect(logic.round(1.00000005, 7), 1.0000001);
      expect(logic.round(1.0000001, 7), 1.0000001);
      expect(logic.round(1.00000014, 7), 1.0000001);
      expect(logic.round(1.00000015, 7), 1.0000002);
    });
  });


}