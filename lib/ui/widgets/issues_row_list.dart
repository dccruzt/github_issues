import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../core/design_system/components/action_row.dart';
import '../../domain/entities/issue.dart';
import '../controller/issues/issues_state.dart';
import 'sort_and_filter_row.dart';

class IssuesRowList extends StatelessWidget {
  const IssuesRowList({
    super.key,
    required this.issuesState,
    required this.onTap,
  });

  final IssuesState issuesState;
  final ValueChanged<String> onTap;

  List<Issue> get issues => issuesState.issues ?? [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      children: [
        SortAndFilterRow(
          sortBy: issuesState.sortBy,
          filterBy: issuesState.filterBy,
        ),
        if (issues.isEmpty) _EmptyState(),
        ...issues.map(
          (issue) {
            final secondary = '#${issue.number} '
                'created ${timeago.format(issue.createdAt)} ago '
                'by ${issue.author}';

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
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 400,
      child: Center(
        child: Text(
          'No flutter issue found',
          style: theme.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
