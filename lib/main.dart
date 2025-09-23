import 'package:app/firebase_options.dart';
import 'package:app/features/data/source/service/firebase/app_check.dart';
import 'package:app/features/data/source/service/firebase/crash_lytics.dart';
import 'package:app/features/presenter/home.dart';
import 'package:app/core/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  AppCheck().initialize();
  CrashLytics().initialize();
  runApp(StudieApp());
}

class StudieApp extends StatelessWidget {
  const StudieApp({super.key});
  @override
  Widget build(BuildContext context) {
    //start my controller
    return GetMaterialApp(
      title: 'Studie',
      theme: StudieTheme.theme,
      home: HomePage(),
      debugShowMaterialGrid: false,
      locale: Locale("pt", "BR"),
      defaultTransition: Transition.upToDown,
      onInit: () async {},
      transitionDuration: Duration(milliseconds: 650),
    );
  }
}
