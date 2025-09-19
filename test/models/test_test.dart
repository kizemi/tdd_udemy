import 'package:flutter_test/flutter_test.dart';

void main(){

  int getValue(){
    return 1;
  }

  int? getNullable(){
    return 1;
  }

  int? getNull(){
    return null;
  }

  test('expectとは第一引数と第二引数が等しいかを比べる関数', () async {
    int i = 1;
    expect(i, 1);
    expect(getValue(), 1);
    expect(getNullable(), 1);
    expect(getNull(), null);

    expect(getValue(), equals(1));
    expect(getValue(), 1);

    expect(true,true);
    expect(1.1, 1.1);

    expect(1, 2, skip: true);
  });


  test('数値用のマッチャー', () async {
    expect(getValue(), equals(1));

    expect(getValue(), isPositive);
    expect(-getValue(), isNegative);
    expect(getValue(), isNonNegative);
    expect(-getValue(), isNonPositive);

    expect(0, isNonPositive);
    expect(0, isNonNegative);

    expect(0, isZero);
    expect(getValue(), isNonZero);

    expect(1.1, equals(1.1));
  });

  test('数値の範囲のマッチャー', () async {
    expect(5, greaterThan(4));          //  >
    expect(5, greaterThanOrEqualTo(5)); //  >=

    expect(4, lessThan(5));             //  <
    expect(4, lessThanOrEqualTo(4));    //  <=

    expect(5, inInclusiveRange(4, 5));  // 4 =< i => 5（4でも5でもOK）
    expect(5, inExclusiveRange(4, 6));  // 4と6は入らない。その間の値ならOK

    expect(5, inClosedOpenRange(5, 6)); // 5 <= i > 6（第一引数以上、第二引数未満）
    expect(6, inOpenClosedRange(5, 6)); // 5 < i >= 6（第一引数超、第二引数以下）5.1とかでも通る

    // 数値が近いかどうかを表すマッチャー
    expect(2, closeTo(3,1)); // 3から±1を許容（2,3,4を許容）
    expect(3, closeTo(3,1));
    expect(4, closeTo(3,1));
    expect(5, closeTo(3,1), skip: true); // 5は3から±1ではないのでfail

    expect(1/3, 0.3333333333333333);
    // 0.333から0.0001くらいの誤差であればOKというふうに、closeToは小数点における誤差の許容などで使える。
    expect(1/3, closeTo(0.3333, 0.0001));
  });

  test('文字列のマッチャー', () async {
    String abcd = 'abcd';
    expect(abcd, 'abcd');
    expect(abcd, contains('bc'));              // bとcが含まれているかどうか
    expect(abcd, startsWith('a'));             // 最初がaかどうか
    expect(abcd, endsWith('d'));               // 最後がdかどうか

    expect('abcD', equalsIgnoringCase('abcd')); // 大文字小文字無視
    expect(' abcd ', equalsIgnoringWhitespace('abcd'));   // 最初と最後のスペース無視
    expect('abcd', stringContainsInOrder(['a', 'c', 'd'])); // 順番通りかどうか

    expect(abcd, hasLength(4));              // 文字列の長さ
    expect(abcd.length, 4);                  // 文字列の長さ
  });

  test('nullのマッチャー', () async {
    int ? nullableValue = getNullable();
    expect(nullableValue, 1);
    expect(nullableValue, isNotNull); // nullでないことを確認

    int? nullValue = getNull();
    expect(nullValue, null);        // nullであることを確認
    expect(nullValue, isNull);      // nullであることを確認
  });

  test('exception', () async {
    Exception ex = Exception();
    expect(ex, isException);

    expect(() {
      throw Exception();
    },
      throwsA(isInstanceOf <Exception>()),
    );

    expect(() {
      throw "string";
    },
      throwsA(isInstanceOf <String>()),
    );

    try {
      throw FormatException("exception text");
      fail("No exception");
    } on FormatException catch(e) {
      expect(e.message, "exception text"); // この例外メッセージが来るのを予測しているというコード
    } catch(e) {
      fail("Different exception");  // failは、到達したらテストが失敗になる関数
    }

  });

  test("Listのマッチャー", () async {
    List list = [1, 2, 3, 4, 5];
    expect(list, hasLength(5));            // リストの長さ
    expect(list.length, greaterThan(4));   // リストの長さが4超かどうか（ < )

    expect(list, contains(1));             // リストの中に1が含まれているかどうか
    expect(list, containsAll([1,3]));      // リストの中に複数のもの含まれているかどうか（今回は1と3）
    expect(list, containsAllInOrder([1, 3, 5]));     // 順番通りかどうか
    expect(list, orderedEquals([1, 2, 3, 4, 5]));    // 順番通りかつ要素が全てあるかどうか
    expect(list, unorderedEquals([1, 5, 4, 3, 2]));  // 要素が全てあるかどうか。順番は問わない
  });



}
