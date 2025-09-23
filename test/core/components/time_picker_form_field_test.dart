
import 'package:app/core/components/time_picker_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

class MockValidator extends Mock {
  String? call(TimeOfDay? time);
}

void main() {
  late MockValidator mockValidator;
  late TextEditingController textEditingController;

  setUp(() {
    mockValidator = MockValidator();
    textEditingController = TextEditingController();
  });

  testWidgets('TimePickerFormfield should display label and icon', (WidgetTester tester) async {
    const label = 'Time';

    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(
          body: Form(
            child: TimePickerFormfield(
              label: label,
              validator: mockValidator.call,
              timeController: textEditingController,
            ),
          ),
        ),
      ),
    );

    expect(find.text(label.tr), findsOneWidget);
    expect(find.byIcon(Icons.access_time), findsOneWidget);
  });

  testWidgets('TimePickerFormfield should show time picker on tap', (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(
          body: Form(
            child: TimePickerFormfield(
              label: 'Time',
              validator: mockValidator.call,
              timeController: textEditingController,
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(TimePickerFormfield));
    await tester.pumpAndSettle();

    expect(find.byType(TimePickerDialog), findsOneWidget);
  });

  testWidgets('TimePickerFormfield should call validator', (WidgetTester tester) async {
    final formKey = GlobalKey<FormState>();
    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(
          body: Form(
            key: formKey,
            child: TimePickerFormfield(
              label: 'Time',
              validator: mockValidator.call,
              timeController: textEditingController,
            ),
          ),
        ),
      ),
    );

    formKey.currentState!.validate();
    await tester.pump();

    verify(mockValidator(any)).called(1);
  });
}
