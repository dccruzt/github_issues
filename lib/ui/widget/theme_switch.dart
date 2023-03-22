import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme_provider.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Switch(
      value: themeProvider.isDark,
      activeColor: Colors.red,
      onChanged: (bool value) {
        themeProvider.isDark = value;
      },
    );
  }
}
