import 'package:flutter/material.dart';

import '../../core/design_system/spacings.dart';
import '../controller/issues/issues_controller.dart';
import 'filter_dropdown_button.dart';
import 'sort_dropdown_button.dart';

class SortAndFilterRow extends StatelessWidget {
  const SortAndFilterRow({
    super.key,
    required this.sortBy,
    required this.filterBy,
  });

  final SortBy sortBy;
  final FilterBy filterBy;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: x4),
      child: Row(
        children: [
          Row(
            children: [
              const Text('sort by:'),
              const SizedBox(width: x1),
              SortDropdownButton(
                sortBy: sortBy,
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
                filterBy: filterBy,
                onTap: (value) =>
                    IssuesCubitProvider.of(context).filterIssues(value),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
