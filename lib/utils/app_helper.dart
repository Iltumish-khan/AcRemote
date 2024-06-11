import 'dart:developer' as developer;

import 'package:bot_toast/bot_toast.dart';
import 'package:demo_project/app.dart';
import 'package:demo_project/services/app_local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppHelper {
  static showLog(String message, String name) {
    developer.log(message, name: name);
  }

  static unFocusKeyBoard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    currentFocus.unfocus();
  }

  static clearAllDataSetRouteToLogin() async {
    await AppLocalStorage().deleteSharedPrefrence();
    // TODO:- Call logut function
    if (NavigationService.navigatorKey.currentContext != null) {
      //TODO:- Navigate to logout screen
    } else {}
  }

  static void showToastMessage(String message, Color color) {
    BotToast.showSimpleNotification(
      title: message,
      duration: const Duration(seconds: 3),
      backgroundColor: color,
      hideCloseButton: true,
      titleStyle: TextStyle(
        fontFamily: 'Raleway',
        fontWeight: FontWeight.w500,
        color: Colors.white,
        fontSize: 0.04.sw,
      ),
    );
  }
}
