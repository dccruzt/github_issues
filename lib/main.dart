import 'package:flutter/material.dart';

import 'core/app_routes.dart';
import 'core/design_system/app_themes.dart';
import 'di/dependency_injection.dart';
import 'ui/screens/issue_details_screen.dart';
import 'ui/screens/issues_screen.dart';

void main() {
  _setupDependencies();
  runApp(const MyApp());
}

Future<void> _setupDependencies() async {
  await initDependencies();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My github issues',
      theme: lightAppThemeData,
      darkTheme: darkAppThemeData,
      themeMode: _themeMode,
      home: IssuesScreen(
        onThemeChanged: (isDark) {
          setState(
            () => _themeMode = isDark ? ThemeMode.dark : ThemeMode.light,
          );
        },
      ),
      routes: {
        AppRoutes.issueDetail: (context) => const IssueDetailsScreen(),
      },
    );
  }
}
