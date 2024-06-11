import 'package:demo_project/module/dashboard/cubit/dashboard_cubit.dart';
import 'package:demo_project/module/dashboard/view/dashboard.dart';
import 'package:demo_project/module/splash/view/splash.dart';
import 'package:demo_project/routes/route_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  AppRouter();

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH_ROUTE:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case DASHBOARD_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => DashboardCubit(),
                  child: DashboardScreen(),
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
