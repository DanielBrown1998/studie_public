
import 'package:app/core/components/app_bar.dart';
import 'package:app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('StudieAppBar should have correct properties', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: StudieAppBar.appBar,
        ),
      ),
    );

    final appBar = tester.widget<AppBar>(find.byType(AppBar));
    final title = tester.widget<Text>(find.text('Studie'));

    expect(appBar.centerTitle, isTrue);
    expect(appBar.backgroundColor, equals(StudieTheme.primaryColor));
    expect(title.style, equals(StudieTheme.textTheme.titleLarge));
  });
}
