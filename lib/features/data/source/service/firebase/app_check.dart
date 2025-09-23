import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';

class AppCheck {
  Future<void> initialize() async {
    bool debug = foundation.kDebugMode;
    await FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(true);
    if (debug) {
      FirebaseAppCheck.instance.onTokenChange.listen((token) {
        if (token != null) {
          debugPrint('App Check Token: $token');
        } else {
          debugPrint('App Check Token: (null)');
        }
      });
    }
    await FirebaseAppCheck.instance.activate(
      webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
      androidProvider:
          debug ? AndroidProvider.debug : AndroidProvider.playIntegrity,
    );
  }
}
