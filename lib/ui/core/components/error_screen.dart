import 'package:app/ui/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorScreen extends StatelessWidget {
  final String? error;
  const ErrorScreen({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        (error != null) ? error! : "Houve um error".tr,
        style: StudieTheme.textTheme.bodyLarge,
      ),
    );
  }
}
