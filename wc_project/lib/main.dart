import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wc_project/pages/devicesave_page.dart';
import 'package:wc_project/pages/home_page.dart';
import 'package:wc_project/pages/login_page.dart';
import 'package:wc_project/pages/pattern_page.dart';
import 'package:wc_project/pages/task_page.dart';
import 'package:wc_project/shared/constants_shared.dart';
import 'package:wc_project/shared/theme_shared.dart';

import 'services/providers/pageindex_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PageIndexProvider()),
        // ChangeNotifierProvider(create: (context) => PageIndexProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double height = mediaQuery.size.height, width = mediaQuery.size.width;
    SharedTheme.screenHeight = height;
    SharedTheme.screenWidth = width;
    return MaterialApp(
      title: SharedConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: SharedTheme.themeGet,
      routes: {
        '/': (context) => PatternPage(
              height: height,
              width: width,
            ),
        '/homepage': (context) => HomePage(
              height: height,
              width: width,
            ),
        '/loginpage': (context) => LoginPage(
              height: height,
              width: width,
            ),
        '/taskpage': (context) => TaskPage(
              height: height,
              width: width,
            ),
        '/devicesavepage': (context) => DeviceSavePage(
              height: height,
              width: width,
            ),
      },
      initialRoute: '/',
    );
  }
}
