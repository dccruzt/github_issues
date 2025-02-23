import 'package:flutter/material.dart';

enum SortBy {
  newest,
  oldest,
  alphabet,
}

class SortDropdownButton extends StatefulWidget {
  const SortDropdownButton({
    super.key,
    required this.sortBy,
    required this.onTap,
  });

  final SortBy sortBy;
  final ValueChanged<SortBy> onTap;

  @override
  State<SortDropdownButton> createState() => _SortDropdownButtonState();
}

class _SortDropdownButtonState extends State<SortDropdownButton> {
  late SortBy _dropdownValue;

  @override
  void initState() {
    super.initState();

    _dropdownValue = widget.sortBy;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DropdownButton<SortBy>(
      value: _dropdownValue,
      style: theme.textTheme.bodyLarge,
      underline: Container(
        height: 2,
      ),
      onChanged: (SortBy? value) {
        setState(() {
          _dropdownValue = value!;
          widget.onTap.call(value);
        });
      },
      items: SortBy.values.map<DropdownMenuItem<SortBy>>((SortBy value) {
        return DropdownMenuItem<SortBy>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
    );
  }
}
