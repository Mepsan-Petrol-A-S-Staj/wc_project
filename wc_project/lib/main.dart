import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:wc_project/pages/devicesave_page.dart';
import 'package:wc_project/pages/home_page.dart';
import 'package:wc_project/pages/login_page.dart';
import 'package:wc_project/pages/pattern_page.dart';
import 'package:wc_project/pages/task_page.dart';

import 'package:wc_project/shared/constants_shared.dart';
import 'package:wc_project/shared/theme_shared.dart';

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); // Flutter uygulaması başlamadan önce Flutter motorunu başlatır
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ],
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double height = mediaQuery.size.height, width = mediaQuery.size.width;
    SharedTheme.screenHeight = height;
    SharedTheme.screenWidth = width;

    return MaterialApp(
      title: SharedConstants.appName,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorSchemeSeed: const Color.fromARGB(255, 61, 219, 153),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: const Color.fromARGB(255, 61, 219, 153),
        brightness: Brightness.dark,
      ),
      routes: {
        '/': (context) => PatternPage(height: height, width: width),
        '/homepage': (context) => HomePage(height: height, width: width),
        '/loginpage': (context) => LoginPage(height: height, width: width),
        '/taskpage': (context) => TaskPage(height: height, width: width),
        '/devicesavepage': (context) =>
            DeviceSavePage(height: height, width: width),
      },
      initialRoute: '/',
    );
  }
}
