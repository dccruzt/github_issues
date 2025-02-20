import 'package:flutter/material.dart';

import '../spacings.dart';

class LabelTag extends StatelessWidget {
  const LabelTag({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(x2),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blueAccent,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(x5)),
      ),
      child: Text(label, style: theme.textTheme.labelSmall),
    );
  }
}
