import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:flutter_rating_stars/flutter_rating_stars.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wc_project/pages/devicesave_page.dart';
import 'package:wc_project/pages/home_page.dart';
import 'package:wc_project/pages/login_page.dart';
import 'package:wc_project/pages/pattern_page.dart';
import 'package:wc_project/pages/task_page.dart';

import 'package:wc_project/shared/constants_shared.dart';
import 'package:wc_project/shared/theme_shared.dart';

import 'services/all_provider.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Flutter uygulaması başlamadan önce Flutter motorunu başlatır
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isDeviceSaved = prefs.getBool("isDeviceSaved") ?? false;
  // isDeviceSaved ? print("Cihaz kaydedilmiş") : print("Cihaz kaydedilmemiş");
  runApp(
    ProviderScope(
      child: MyApp(isDeviceSaved: isDeviceSaved),
    ),
  );
}

class MyApp extends ConsumerWidget {
  final bool isDeviceSaved;

  const MyApp({Key? key, required this.isDeviceSaved}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double height = mediaQuery.size.height, width = mediaQuery.size.width;
    SharedTheme.screenHeight = height;
    SharedTheme.screenWidth = width;
    isDeviceSaved ? null : ref.read(pageIndexProvider.notifier).state = 3;
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
