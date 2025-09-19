import 'package:intl/intl.dart' as intl;
import 'dart:math' as math;

class Logic {
  String _text = "0";  /// 最後の桁の値ではなくて全体の値を指すString変数
  // 「textという変数でこのファイルの_text変数を取得できる」というコード
  String get text => _text;

  /// 表示する値
  double _displayValue = 0;

  /// 最大桁数
  static const MAX_DIGIT = 9;

  /// 現在の値
  double _currentValue = 0;
  get currentValue => _currentValue; // 現在の値（読み込み専用）

  /// 足す、引く用の値
  double _memorialValue = 0;
  get memorialValue => _memorialValue; // 読み込み専用


  /// 掛ける、割る用の値
  double _previousValue = 0;
  get previousValue => _previousValue; // 読み込み専用


  /// 掛け算か割り算か記憶しておく
  String _previousOperation = "";
  get previousOperation => _previousOperation; // 読み込み専用


  /// 足し算か引き算か記憶しておく
  String _memorialOperation = "";
  get memorialOperation => _memorialOperation; // 読み込み専用

  /// 小数点の有無
  bool _hasPoint = false;

  /// 小数点以下の桁数
  int _numAfterPoint = 0;


  intl.NumberFormat formatter = intl.NumberFormat('#,###.########', 'en_US');


  /// 「入力された文字を現在の値 _currentValue に反映し、表示用の文字列 _text を更新する」処理
  void input(String text){
    // 入力が小数点かどうか判定
    if (text == ".") {
      _hasPoint = true; // _hasPoint = 小数点の有無

    } else if (text == "=") {
      if (_previousOperation == "x" || _previousOperation == "/") {
        double result = _previousOperation == "x"
            ? _previousValue * _currentValue
            : _previousValue / _currentValue;

        _displayValue = _memorialOperation == "-"
            ?  _memorialValue - result
            :  _memorialValue + result;

        // _displayValue = _memorialValue + (_memorialOperation == "-" ? -1:1) * result; // 短くはなるけど読みにくい

      } else if (_memorialOperation == "+"){
        _displayValue = _memorialValue + _currentValue;
      } else if (_memorialOperation == "-"){
        _displayValue = _memorialValue - _currentValue;
      }

      _clear();

    } else if (text == "x" || text == "/") {
      if (_previousOperation == "") {
        _previousValue = _currentValue;
      } else if (_previousOperation == "x") {
        _previousValue = _previousValue * _currentValue;
      } else if (_previousOperation == "/") {
        _previousValue = _previousValue / _currentValue;
      }
      _displayValue = _previousValue;
      _currentValue = 0;
      _previousOperation = text;

    } else if (text=="+" || text == "-") {
      if (_previousOperation == "x") {
        _memorialValue = _previousValue * _currentValue;
        _previousValue = 0;
        _previousOperation = "";

      } else if (_previousOperation == "/") {
        _memorialValue = _previousValue / _currentValue;
        _previousValue = 0;
        _previousOperation = "";

      } else if (_memorialOperation == "") {
        _memorialValue = _currentValue;

      } else if (_memorialOperation == "+") {
        _memorialValue = _memorialValue + _currentValue;

      } else if (_memorialOperation == "-") {
        _memorialValue = _memorialValue - _currentValue;
      }

      _displayValue = _memorialValue;
      _currentValue = 0;
      _memorialOperation = text;
    } else {
      // 数値の入力

      int digit = getDigit(_currentValue);

      if (digit + _numAfterPoint == MAX_DIGIT) {
        // 最大桁数のため、入力させない

      } else if (_hasPoint) { // _hasPoint = 小数点の有無
        // すでに小数点モードなら、小数点以下の桁をカウントアップ
        _numAfterPoint++;

        // 小数点以下の該当桁に数字を加える
        // math.pow(0.1, _numAfterPoint) で 10^-n を求める → 0.1, 0.01, 0.001...
        // 例: _currentValue=1.2, text="3", _numAfterPoint=2 → 1.2 + 3 * 0.01 = 1.23
        _currentValue = _currentValue + int.parse(text) * math.pow(0.1, _numAfterPoint);

      } else if (_currentValue == 0) {
        // 現在の値が 0（初期状態）なら、入力された数字で置き換える
        _text = text;
        _currentValue = double.parse(text);

      } else {
        // それ以外（整数入力中）
        // 既存の値に 10 を掛けて桁を一つ上げ、入力値を足す
        // 例: _currentValue=12, text="3" → 12*10+3 = 123
        _currentValue = _currentValue * 10 + double.parse(text);
      }
      _displayValue = _currentValue;
    }

    // 表示用の文字列を更新
    if (_hasPoint) {
      // 小数点モードなら、小数点以下の桁数を指定して文字列を生成
      _text = getDisplayText(_displayValue, numAfterPoint: _numAfterPoint);
    } else {
      // 整数モードなら普通にフォーマット
      _text = getDisplayText(_displayValue);
    }
  }


  void _clear() {
    _currentValue = 0;
    _previousValue = 0;
    _memorialValue = 0;
    _previousOperation = "";
    _memorialOperation = "";
  }


  /// 数値を文字列にフォーマット（整形）して表示用のテキストを作るためのメソッド
  String getDisplayText(double value, {int numAfterPoint = -1}) {
    if (numAfterPoint != -1) {
      // 小数点以下あり
      int intPart = value.toInt();

      if (numAfterPoint == 0) {
        // 最後が「.」になる場合 例:1.
        // 小数点だけ入力された状態（例: "1."）を表示するため末尾にドットを付けて返す
        return formatter.format(value) + ".";
      } else if (intPart == value) {
        // 値の整数部分と、全ての値が一致する場合 例:1.0

        // 整数部分と小数部分を手動で連結
        // → "12.00" のように入力した桁数分の0を保持する
        return formatter.format(intPart) + (value - intPart)
            .toStringAsFixed(numAfterPoint) // ".00" のような文字列にする
            .substring(1); // 先頭の "0" を削除して整数部分とつなげる
      }

      int digit = getDigit(value); // 整数部分の桁数
      int decimalPart = MAX_DIGIT - digit; // 使うことができる少数部分の桁数
      double roundedValue = round(value, decimalPart); // 四捨五入した値
      return formatter.format(roundedValue);
    }
    // 通常の小数 → フォーマッタに任せてフォーマット
    return formatter.format(value);
  }

  /// 整数部分の桁数を取得するメソッド
  int getDigit(double value) {
    // i は「10で何回割れたか」を数えている
    int i = 0;
    for (;10 <= value; i++){
      value = value/10;
    }
    return i + 1; // 10未満の数は1桁（割る必要なし）なので i=0。でも桁数は 1 なので +1 が必要。
  }


  double round(double value, int digit){
    num key = math.pow(10, digit);
    return (value * key).roundToDouble() / key;
  }
}