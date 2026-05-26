// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:project/main.dart';

void main() {
  testWidgets('Welcome page shows Soluna intro', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Soluna'), findsOneWidget);
    expect(find.text('Begin your\nquiet ritual'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
    expect(
      find.textContaining('Already have an account?', findRichText: true),
      findsOneWidget,
    );
  });
}
