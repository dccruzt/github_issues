import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/app_routes.dart';
import '../controller/issues_controller.dart';
import '../widget/issues_row_list.dart';
import '../widget/theme_switch.dart';
import 'arguments/issue_arguments.dart';
import 'error_page.dart';
import 'loading_page.dart';

class IssuesPage extends StatelessWidget {
  const IssuesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [ThemeSwitch()],
      ),
      body: IssuesCubitProvider(
        child: BlocBuilder<IssuesCubit, IssuesState>(builder: (context, state) {
          if (state.error != null) {
            return const ErrorPage();
          }
          if (state.issues != null) {
            return IssuesRowList(
              issues: state.issues!,
              onTap: (int number) => Navigator.pushNamed(
                  context, AppRoutes.issueDetail,
                  arguments: IssueArguments(number: number)),
            );
          }
          return const LoadingPage();
        }),
      ),
    );
  }
}
