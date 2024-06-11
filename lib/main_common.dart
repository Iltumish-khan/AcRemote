import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'services/exports/utils.dart';

String? baseURL;
String? clientId;
String? clientSecret;

Future<void> mainCommon(String env) async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  AppHelper.showLog(DateTime.now().toString(), "Time when the app launched");
  await ConfigReader.initialize();
  switch (env) {
    case devEnv:
      baseURL = ConfigReader.getDevURL();
      break;
    case prodEnv:
      baseURL = ConfigReader.getProdURL();
      break;
  }
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const App());
  });
}
