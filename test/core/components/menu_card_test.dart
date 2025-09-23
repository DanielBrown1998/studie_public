import 'package:app/core/components/menu_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:mockito/mockito.dart';

class MockFunction extends Mock {
  void call();
}

void main() {
  late MockFunction mockFunction;

  setUp(() {
    mockFunction = MockFunction();
  });

  testWidgets('MenuCard should display icon and description', (WidgetTester tester) async {
    const description = 'Test Description';
    const icon = Icons.add;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MenuCard(
            description: description,
            icon: icon,
            duration: 1,
            function: mockFunction.call,
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text(description), findsOneWidget);
    expect(find.byIcon(icon), findsOneWidget);
  });

  testWidgets('MenuCard should display Lottie and description', (WidgetTester tester) async {
    const description = 'Test Description';
    const lottieURL = 'assets/lotties/ai_thinking.json';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MenuCard(
            description: description,
            lottieURL: lottieURL,
            duration: 1,
            function: mockFunction.call,
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text(description), findsOneWidget);
    expect(find.byType(Lottie), findsOneWidget);
  });

  testWidgets('MenuCard should call function on tap', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MenuCard(
            description: 'Test',
            icon: Icons.add,
            duration: 1,
            function: mockFunction.call,
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    await tester.tap(find.byType(MenuCard));
    await tester.pumpAndSettle();

    verify(mockFunction()).called(1);
  });

  testWidgets('MenuCard should throw exception when both icon and lottieURL are null', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MenuCard(
            description: 'Test',
            duration: 1,
            function: mockFunction.call,
          ),
        ),
      ),
    );
    final exception = tester.takeException();
    expect(exception, isA<Exception>());
  });
}

