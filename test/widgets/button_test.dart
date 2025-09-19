import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_udemy3/widgets/button.dart';

void main() {


  group("text", (){
    testWidgets("Button", (WidgetTester tester) async{

      /// 仮のウィジェットを作成する
      await tester.pumpWidget(
        MaterialApp(
          home: Button(
            "0",
            Colors.black,
            Colors.white,
            // null,
                (_) {}, // ✅ ダミーのコールバックを渡す
          ),
        ),
      );

      await tester.pump();

      expect(find.text("0"), findsOneWidget); // 0が一つだけ見つかるはず
      expect(find.text("1"), findsNothing);   // 1は無いはず
    });
  });


  group("押されたときの処理", () {

    testWidgets("1", (WidgetTester tester) async {
      String result = "";
      onPress(String text) {
        result = text;
      }

        await tester.pumpWidget(
          MaterialApp(
            home: Button(
              "1",
              Colors.black,
              Colors.white,
              onPress
            ),
          ),
        );

        await tester.pump();

        expect(result, "");
        Finder finder = find.text("1");
        await tester.tap(finder);
        expect(result, "1");
      });


    testWidgets("2", (WidgetTester tester) async {
      String result = "";
      onPress(String text) {
        result = text;
      }

      await tester.pumpWidget(
        MaterialApp(
          home: Button(
              "2",
              Colors.black,
              Colors.white,
              onPress
          ),
        ),
      );

      await tester.pump();

      expect(result, "");               // 最初はtextは空文字
      await tester.tap(find.text("2")); // 2をタップすると
      expect(result, "2");              // 2が表示されるかどうか
    });
  });


  group("色", (){
    testWidgets("1", (WidgetTester tester) async {

      await tester.pumpWidget(
        MaterialApp(home: Button("1", Colors.black, Colors.white, (_) {}),
        ),
      );
      await tester.pump();

      // Finder finder = find.byType(Material); // Materialというクラスを探すコード。Materialには色に関する情報が含まれてる
      // Material material = tester.widget(finder);
      // expect(material.color, Colors.black);
      // expect(material.textStyle?.color, Colors.white);

      final material = tester.widget<Material>(
        find.descendant(of: find.byType(ElevatedButton), matching: find.byType(Material)),
      );
      expect(material.color, Colors.white);

      final text = tester.widget<Text>(find.text('1'));
      expect(text.style?.color, Colors.black);
    });
  });

}