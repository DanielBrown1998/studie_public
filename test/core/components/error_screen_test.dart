
import 'package:app/core/components/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  testWidgets('ErrorScreen should display the provided error message', (WidgetTester tester) async {
    const errorMessage = 'This is a test error.';

    await tester.pumpWidget(
      const GetMaterialApp(
        home: Scaffold(
          body: ErrorScreen(error: errorMessage),
        ),
      ),
    );

    expect(find.text(errorMessage), findsOneWidget);
  });

  testWidgets('ErrorScreen should display the default error message when error is null', (WidgetTester tester) async {
    await tester.pumpWidget(
      const GetMaterialApp(
        home: Scaffold(
          body: ErrorScreen(error: null),
        ),
      ),
    );

    expect(find.text('Houve um error'.tr), findsOneWidget);
  });
}
