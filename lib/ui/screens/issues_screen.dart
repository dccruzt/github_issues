import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/app_routes.dart';
import '../controller/issues_controller.dart';
import '../widgets/issues_row_list.dart';
import '../widgets/theme_switch.dart';
import 'arguments/issue_arguments.dart';
import 'error_screen.dart';
import 'loading_screen.dart';

class IssuesScreen extends StatelessWidget {
  const IssuesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [ThemeSwitch()],
      ),
      body: IssuesCubitProvider(
        child: const IssuesList(),
      ),
    );
  }
}

class IssuesList extends StatelessWidget {
  const IssuesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssuesCubit, IssuesState>(
      builder: (context, state) {
        if (state.error != null) {
          return const ErrorScreen();
        }
        if (state.issues != null) {
          return IssuesRowList(
            issues: state.issues!,
            onTap: (number) => _onTap(context, number),
          );
        }
        return const LoadingScreen();
      },
    );
  }

  void _onTap(BuildContext context, String number) {
    IssuesCubitProvider.of(context).setVisitedIssue(number);

    Navigator.pushNamed(
      context,
      AppRoutes.issueDetail,
      arguments: IssueArguments(number: number),
    );
  }
}
