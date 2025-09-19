import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart' as intl;

main() {
  test("3桁区切りのテスト", () {
    intl.NumberFormat formatter = intl.NumberFormat('#,###', 'en_US');
    expect(formatter.format(123), "123");
    expect(formatter.format(1234), "1,234");
    expect(formatter.format(123456789), "123,456,789");

  });

}