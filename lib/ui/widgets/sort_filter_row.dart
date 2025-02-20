import 'package:flutter/material.dart';

import '../../core/design_system/spacings.dart';
import '../controller/issues_controller.dart';
import 'filter_dropdown_button.dart';
import 'sort_dropdown_button.dart';

class SortFilterRow extends StatelessWidget {
  const SortFilterRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            const Text('sort by:'),
            const SizedBox(width: x1),
            SortDropdownButton(
              onTap: (value) =>
                  IssuesCubitProvider.of(context).sortIssues(value),
            ),
          ],
        ),
        const SizedBox(width: x2),
        Row(
          children: [
            const Text('filter by:'),
            const SizedBox(width: x1),
            FilterDropdownButton(
              onTap: (value) =>
                  IssuesCubitProvider.of(context).filterIssues(value),
            ),
          ],
        ),
      ],
    );
  }
}
