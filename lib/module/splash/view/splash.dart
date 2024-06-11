import 'package:demo_project/routes/route_strings.dart';
import 'package:demo_project/services/exports/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushNamed(DASHBOARD_ROUTE);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBackgroundBlueColor.withOpacity(0.3),
      body: Center(
        child: SizedBox(
          height: 0.6.sh,
          width: 0.6.sw,
          child: const Image(
            image: AssetImage(AssetsPath.logoSplash),
          ),
        ),
      ),
    );
  }
}
