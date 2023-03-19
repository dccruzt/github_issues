import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../core/design_system/components/action_row.dart';
import '../../domain/entity/issue_entity.dart';

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
        ...issues.map(
          (issue) {
            final secondary =
                '#${issue.number} opened ${timeago.format(issue.createdAt)} ago by ${issue.author}';
            return ActionRow(
              primary: Text(
                issue.title,
                style: theme.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
                maxLines: 2,
              ),
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
