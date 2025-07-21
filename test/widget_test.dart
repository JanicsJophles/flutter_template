import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_template/app.dart';

void main() {
  testWidgets('Flutter Template smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
