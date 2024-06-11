import 'package:package_info_plus/package_info_plus.dart';

PackageInfo packageInfo = PackageInfo(
  appName: 'Unknown',
  packageName: 'Unknown',
  version: 'Unknown',
  buildNumber: 'Unknown',
  buildSignature: 'Unknown',
);

//Use this in splash screen
// Future<void> initPackageInfo() async {
//   final info = await PackageInfo.fromPlatform();
//     packageInfo = info;
// }