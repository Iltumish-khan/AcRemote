import 'dart:async';
import 'package:demo_project/app.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class ProgressLoader {
  static void showLoadingDialog([String? message]) {
    showDialog(
      context: NavigationService.navigatorKey.currentContext!,
      builder: (ctx) => AbsorbPointer(
        child: Container(
          color: Colors.transparent,
          child: const Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(homeBackgroundBlueColor),
            ),
          ),
        ),
      ),
    );
  }

  static void hideLoadingDialog() {
    NavigationService.navigatorKey.currentState?.pop();
  }

  static void showTooManyAttemptsDialog(
      String title, String description, context) {
    Timer timer = Timer(const Duration(seconds: 60), () {
      hideLoadingDialog();
      hideLoadingDialog();
    });
    showDialog(
      context: context,
      builder: (ctx) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            title,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          content: Text(description,
              style: const TextStyle(color: Colors.black, fontSize: 16.0)),
        ),
      ),
      barrierDismissible: false,
    ).then((value) => timer.cancel());
  }
}
