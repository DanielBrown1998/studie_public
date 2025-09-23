import 'package:app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetSnackBarStudie {
  final IconData icon;
  final String message;
  final int duration;
  GetSnackBarStudie({
    required this.icon,
    required this.message,
    this.duration = 2,
  });

  GetSnackBar get snackbarStudie {
    return GetSnackBar(
      snackPosition: SnackPosition.BOTTOM,
      animationDuration: Duration(seconds: 1),
      snackStyle: SnackStyle.FLOATING,
      borderRadius: 12,
      duration: Duration(seconds: duration),
      padding: EdgeInsets.all(16),
      backgroundGradient: LinearGradient(
        colors: [
          StudieTheme.terciaryColor,
          StudieTheme.secondaryColor,
          StudieTheme.primaryColor,
        ],
        begin: AlignmentGeometry.bottomLeft,
        end: AlignmentGeometry.topRight,
        // transform: GradientRotation(90),
      ),
      borderColor: StudieTheme.primaryColor,
      icon: Icon(icon, color: StudieTheme.primaryColor),
      messageText: Text(message, style: StudieTheme.textTheme.titleSmall),
    );
  }
}
