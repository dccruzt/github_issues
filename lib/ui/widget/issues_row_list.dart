import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../core/design_system/components/action_row.dart';
import '../../core/design_system/spacings.dart';
import '../../domain/entity/issue_entity.dart';
import '../controller/issues_controller.dart';
import 'sort_dropdown_button.dart';

class IssuesRowList extends StatelessWidget {
  const IssuesRowList({
    Key? key,
    required this.issues,
    required this.onTap,
  }) : super(key: key);

  final List<IssueEntity> issues;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: x4, bottom: x2),
          child: Text('Github issues', style: theme.textTheme.titleLarge),
        ),
        Padding(
          padding: const EdgeInsets.only(left: x4, bottom: x2),
          child: Row(
            children: [
              const Text('Sort by:'),
              const SizedBox(width: x2),
              SortDropdownButton(
                onTap: (value) =>
                    IssuesCubitProvider.of(context).sortIssues(value),
              ),
            ],
          ),
        ),
        ...issues.map(
          (issue) {
            final secondary =
                '#${issue.number} opened ${timeago.format(issue.createdAt)} ago by ${issue.author}';

            final textStyle = issue.visited
                ? theme.textTheme.bodyLarge
                : theme.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w800);

            final icon = issue.visited
                ? const Icon(Icons.circle_outlined)
                : const Icon(Icons.circle_notifications_sharp);

            return ActionRow(
              leading: icon,
              primary: Text(issue.title, style: textStyle, maxLines: 2),
              secondary: Text(
                secondary,
                style: theme.textTheme.bodyMedium,
              ),
              onTap: () => onTap.call(issue.number),
            );
          },
        ).toList(growable: false),
      ],
    );
  }
}
