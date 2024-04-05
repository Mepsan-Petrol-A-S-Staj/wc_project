import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:wc_project/pages/devicesave_page.dart';
import 'package:wc_project/pages/home_page.dart';
import 'package:wc_project/pages/login_page.dart';
import 'package:wc_project/pages/pattern_page.dart';
import 'package:wc_project/pages/task_page.dart';
import 'package:wc_project/shared/constant_shared.dart';
import 'package:wc_project/shared/theme_shared.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static bool isDarkModeTheme = false;
  void _themeProvider(Brightness? brightness) async {
    if (brightness == Brightness.dark) {
      isDarkModeTheme = true;
      debugPrint('Dark Mode');
    } else {
      isDarkModeTheme = false;
      debugPrint('Light Mode');
    }
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double height = mediaQuery.size.height, width = mediaQuery.size.width;
    final Brightness brightness = mediaQuery.platformBrightness;
    _themeProvider(brightness);
    SharedTheme(height: height, width: width, isDarkModeTheme: isDarkModeTheme);

    return MaterialApp(
      title: SharedConstants.appName,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: SharedTheme.lightTheme(isDarkModeTheme, width, height),
      darkTheme: SharedTheme.darkTheme(isDarkModeTheme, width, height),
      routes: {
        '/': (context) => PatternPage(height: height, width: width),
        '/homepage': (context) => const HomePage(),
        '/loginpage': (context) => LoginPage(height: height, width: width),
        '/taskpage': (context) => const TaskPage(),
        '/devicesavepage': (context) => const DeviceSavePage(),
      },
      initialRoute: '/',
    );
  }
}
