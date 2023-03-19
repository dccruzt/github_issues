import 'package:flutter/material.dart';

import 'core/app_routes.dart';
import 'core/design_system/dark_app_theme.dart';
import 'di/dependency_injection.dart';
import 'ui/page/issue_detail_page.dart';
import 'ui/page/issues_page.dart';

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: appThemeData,
      home: const IssuesPage(),
      routes: {
        AppRoutes.issueDetail: (context) => const IssueDetailPage(),
      },
    );
  }
}
