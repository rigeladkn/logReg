import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loginregister/pages/myApp.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (kDebugMode) {
    //autoriser l'envoi des données à Crashlytics si on est debugMode
    FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(true); //disable false
  } else {
    //autoriser l'envoi des données à Crashlytics si on est production
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }

  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  //runZonedGuarded(runApp(MyApp()), onCrash));

  // ...handle the exception.
  //
  //FlutterError.onError =  (FlutterErrorDetails details){
  //Zone.current.handleUncaughtError(details.exception, details.stack);
  //};

  runApp(MyApp());
}
