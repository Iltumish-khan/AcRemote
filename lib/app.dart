import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:demo_project/routes/app_router.dart';
import 'package:demo_project/routes/route_strings.dart';
import 'package:demo_project/services/connectivity_services/connectivity_bloc.dart';
import 'package:demo_project/services/exports/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppView();
  }
}

class AppView extends StatelessWidget {
  AppView({Key? key}) : super(key: key);

// ignore: unused_field
  final _navigatorKey = GlobalKey<NavigatorState>();

  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ConnectivityBloc()..add(NetworkObserve()),
        ),
      ],
      child: ScreenUtilInit(
        builder: (context, _) => MaterialApp(
          theme: ThemeData(
              primaryColor: homeBackgroundBlueColor,
              buttonTheme:
                  const ButtonThemeData(buttonColor: homeBackgroundBlueColor)),
          onGenerateRoute: _router.onGenerateRoute,
          initialRoute: SPLASH_ROUTE,
          debugShowCheckedModeBanner: false,
          navigatorObservers: [BotToastNavigatorObserver()],
          builder: (BuildContext context, Widget? child) {
            final MediaQueryData data = MediaQuery.of(context);
            child = BotToastInit()(context, child);
            return MediaQuery(
              data: data.copyWith(
                textScaleFactor: 1,
              ),
              child: child,
            );
          },
        ),
      ),
    );
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<ScaffoldMessengerState> scaffoldMessangerKey =
      GlobalKey<ScaffoldMessengerState>();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
