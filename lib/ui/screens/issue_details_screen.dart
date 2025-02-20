import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../core/design_system/components/label_tag.dart';
import '../../core/design_system/spacings.dart';
import '../controller/issue_controller.dart';
import 'arguments/issue_arguments.dart';
import 'error_screen.dart';
import 'loading_screen.dart';

class IssueDetailsScreen extends StatelessWidget {
  const IssueDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final args = ModalRoute.of(context)!.settings.arguments as IssueArguments;

    return IssueCubitProvider(
      number: args.number,
      child: BlocBuilder<IssueCubit, IssueState>(
        builder: (context, state) {
          if (state.error != null) {
            return const ErrorScreen();
          }
          if (state.issue != null) {
            final description = '#${state.issue!.number} '
                'created ${timeago.format(state.issue!.createdAt)} ago '
                'by ${state.issue!.author}';

            return Scaffold(
              appBar: AppBar(),
              body: ListView(
                padding: const EdgeInsets.all(x4),
                children: [
                  Text(
                    state.issue!.title,
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: x4),
                  Text(
                    description,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.green),
                  ),
                  if (state.issue!.body != null) ...[
                    const SizedBox(height: x4),
                    Text(state.issue!.body!),
                  ],
                  if (state.issue!.labels != null) ...[
                    const SizedBox(height: x4),
                    Wrap(
                      children: [
                        ...state.issue!.labels!.map(
                          (e) => Padding(
                            padding: const EdgeInsets.all(x1),
                            child: LabelTag(label: e),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            );
          }
          return const LoadingScreen();
        },
      ),
    );
  }
}
