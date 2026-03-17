import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_chat/main.dart';

void main() {
  testWidgets('App renders NavigationBar', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    expect(find.byType(NavigationBar), findsOneWidget);
  });
}
