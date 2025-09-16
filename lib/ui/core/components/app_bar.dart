import 'package:app/ui/core/theme/theme.dart';
import 'package:flutter/material.dart';

class StudieAppBar {
  static AppBar appBar = AppBar(
    centerTitle: true,
    backgroundColor: StudieTheme.primaryColor,
    title: Text("Studie", style: StudieTheme.textTheme.titleLarge),
  );
}
