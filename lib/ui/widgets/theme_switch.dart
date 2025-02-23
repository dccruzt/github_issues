import 'package:flutter/material.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({
    super.key,
    required this.onThemeChanged,
  });

  final ValueChanged<bool> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Switch(
      value: brightness == Brightness.dark,
      activeColor: Colors.red,
      onChanged: onThemeChanged,
    );
  }
}
