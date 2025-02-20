import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/app_routes.dart';
import 'core/design_system/app_themes.dart';
import 'core/theme_provider.dart';
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
  ThemeProvider themeProvider = ThemeProvider();

  @override
  void initState() {
    super.initState();
    getThemeFromPrefs();
  }

  void getThemeFromPrefs() async {
    themeProvider.isDark = await themeProvider.localDataSource.isDarkTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => themeProvider,
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) => MaterialApp(
          title: 'My App',
          theme: themeProvider.isDark ? darkAppThemeData : lightAppThemeData,
          home: const IssuesScreen(),
          routes: {
            AppRoutes.issueDetail: (context) => const IssueDetailsScreen(),
          },
        ),
      ),
    );
  }
}
