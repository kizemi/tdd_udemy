/// 一番最初のカウンター画面におけるテストコード

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_udemy3/main.dart';

void main() {} // 👈 空のmainで何も実行されない

// void main(){
//
//   group('スモークテスト（全部スキップ）', () {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     await tester.pumpWidget(const MyApp());
//
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);
//
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();
//
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//
//     expect(find.text('1'), findsOneWidget);
//     expect(find.byIcon(Icons.add), findsOneWidget);
//     expect(find.byIcon(Icons.settings), findsNothing);
//
//     // ValueKeyのテスト
//     expect(find.byKey(ValueKey('counter')), findsOneWidget);
//
//     // ウィジェットの種類とその中のテキストBのテスト
//     expect(find.widgetWithText(TextButton, 'add'), findsOneWidget);
//
//     expect(find.byType(TextButton), findsOneWidget);
//
//     // ウィジェットの種類とその中のアイコンのテスト
//     expect(find.widgetWithIcon(FloatingActionButton, Icons.add), findsOneWidget);
//     });
//   }, skip: true); // 👈 グループごとスキップ);
// }