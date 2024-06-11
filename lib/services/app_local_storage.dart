import 'package:demo_project/services/exports/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocalStorage {
  saveAccessToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppStrings.accessToken, "Bearer $token");
  }

  Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppStrings.accessToken) ?? "";
  }

  saveLoginState(bool boolValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppStrings.isUserLoggedIn, boolValue);
  }

  Future<bool?> getLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(AppStrings.isUserLoggedIn) != null) {
      return prefs.getBool(AppStrings.isUserLoggedIn);
    } else {
      return false;
    }
  }

  deleteSharedPrefrence() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
