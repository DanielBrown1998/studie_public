
import 'package:app/core/components/getsnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('GetSnackBarStudie should have correct properties', (WidgetTester tester) async {
    const message = 'This is a test snackbar.';
    const icon = Icons.info;

    final snackbar = GetSnackBarStudie(icon: icon, message: message).snackbarStudie;

    expect(snackbar.messageText, isA<Text>());
    final messageText = snackbar.messageText as Text;
    expect(messageText.data, equals(message));

    expect(snackbar.icon, isA<Icon>());
    final iconWidget = snackbar.icon as Icon;
    expect(iconWidget.icon, equals(icon));
  });
}
