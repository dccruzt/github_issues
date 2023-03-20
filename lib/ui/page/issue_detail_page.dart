import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/design_system/components/label_tag.dart';
import '../../core/design_system/spacings.dart';
import '../controller/issue_controller.dart';
import 'arguments/issue_arguments.dart';

class IssueDetailPage extends StatelessWidget {
  const IssueDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final args = ModalRoute.of(context)!.settings.arguments as IssueArguments;

    return Padding(
      padding: const EdgeInsets.all(x4),
      child: IssueCubitProvider(
        number: args.number,
        child: BlocBuilder<IssueCubit, IssueState>(
          builder: (context, state) {
            if (state.error != null) {
              return const Text('ERROR');
            }
            if (state.issue != null) {
              return Scaffold(
                appBar: AppBar(),
                body: ListView(
                  children: [
                    Text(
                      state.issue!.title,
                      style: theme.textTheme.titleLarge,
                    ),
                    if (state.issue!.body != null) ...[
                      const SizedBox(height: x2),
                      Text(state.issue!.body!),
                    ],
                    if (state.issue!.labels != null) ...[
                      const SizedBox(height: x4),
                      Row(
                        children: [
                          ...state.issue!.labels!
                              .map((e) => Padding(
                                    padding: const EdgeInsets.only(right: x2),
                                    child: LabelTag(label: e),
                                  ))
                              .toList(growable: false),
                        ],
                      ),
                    ]
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
