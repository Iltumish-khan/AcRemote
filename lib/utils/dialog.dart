import 'package:demo_project/utils/app_colors.dart';
import 'package:demo_project/utils/text_styles.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static final DialogUtils _instance = DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static void showCustomDialog(BuildContext context,
      {required String title,
      required String message,
      required String okBtnText,
      required String cancelBtnText,
      required VoidCallback okBtnFunction,
      required VoidCallback cancelBtnFunction}) {
    showDialog(
        context: context,
        barrierDismissible: true, // <-- Set this to false.
        builder: (_) {
          return WillPopScope(
            onWillPop: () async => true,
            child: AlertDialog(
              title: Text(
                title,
                style: subHeadingTextStyle,
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              contentPadding: const EdgeInsets.fromLTRB(10, 8, 10, 15),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Divider(
                    thickness: 0.5,
                    color: unSelectedLabelColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13),
                    child: Text(
                      message,
                      softWrap: true,
                      style: subHeadingTextStyle,
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                MaterialButton(
                  color: unSelectedLabelColor,
                  onPressed: cancelBtnFunction,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: Text(
                    cancelBtnText,
                    style: dialogTextStyle,
                  ),
                ),
                MaterialButton(
                  color: homeBackgroundBlueColor,
                  onPressed: okBtnFunction,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: Text(
                    okBtnText,
                    style: dialogTextStyle,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
