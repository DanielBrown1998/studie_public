
import 'package:app/core/components/default_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  testWidgets('DefaultDialog should show a dialog with correct content', (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () {
                DefaultDialog.dialog(
                  confirmText: 'Confirm',
                  cancelText: 'Cancel',
                  middleText: 'This is a test dialog.',
                  titleText: 'Test Dialog',
                );
              },
              child: const Text('Show Dialog'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Show Dialog'));
    await tester.pumpAndSettle();

    expect(find.text('Test Dialog'), findsOneWidget);
    expect(find.text('This is a test dialog.'), findsOneWidget);
    expect(find.text('Confirm'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('DefaultDialog should return true on confirm', (WidgetTester tester) async {
    bool? result;

    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () async {
                result = await DefaultDialog.dialog(
                  confirmText: 'Confirm',
                  cancelText: 'Cancel',
                  middleText: 'This is a test dialog.',
                  titleText: 'Test Dialog',
                );
              },
              child: const Text('Show Dialog'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Show Dialog'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();

    expect(result, isTrue);
  });
}
