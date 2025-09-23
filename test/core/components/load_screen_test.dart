
import 'package:app/core/components/load_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  testWidgets('LoadScreen should display the loading animation', (WidgetTester tester) async {
    await tester.pumpWidget(
      const GetMaterialApp(
        home: Scaffold(
          body: LoadScreen(),
        ),
      ),
    );

    expect(find.byKey(const Key('lottie_loading')), findsOneWidget);
  });
}
