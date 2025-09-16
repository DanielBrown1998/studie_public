import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class CrashLytics {
  //initialize Firebase Crashlytics
  FirebaseCrashlytics get firebaseCrashlytics => FirebaseCrashlytics.instance;

  initialize() {
    FlutterError.onError = (errorDetails) async {
      await firebaseCrashlytics.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      firebaseCrashlytics.recordError(error, stack, fatal: true);
      return true;
    };
  }
}
