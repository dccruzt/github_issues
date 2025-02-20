import 'package:flutter/material.dart';

enum FilterBy {
  clear,
  moreThan2Comments,
  lastHour,
  frameworkLabel,
}

class FilterDropdownButton extends StatefulWidget {
  const FilterDropdownButton({Key? key, required this.onTap}) : super(key: key);

  final ValueChanged<FilterBy> onTap;

  @override
  State<FilterDropdownButton> createState() => _FilterDropdownButtonState();
}

class _FilterDropdownButtonState extends State<FilterDropdownButton> {
  FilterBy dropdownValue = FilterBy.clear;

  String getFilterName(FilterBy filterBy) {
    switch (filterBy) {
      case FilterBy.clear:
        return 'clear';
      case FilterBy.moreThan2Comments:
        return '2 comments';
      case FilterBy.lastHour:
        return 'last hour';
      case FilterBy.frameworkLabel:
        return 'framework';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DropdownButton<FilterBy>(
      value: dropdownValue,
      style: theme.textTheme.bodyLarge,
      underline: Container(
        height: 2,
      ),
      onChanged: (FilterBy? value) {
        setState(() {
          dropdownValue = value!;
          widget.onTap.call(value);
        });
      },
      items: FilterBy.values.map<DropdownMenuItem<FilterBy>>((FilterBy value) {
        return DropdownMenuItem<FilterBy>(
          value: value,
          child: Text(getFilterName(value)),
        );
      }).toList(),
    );
  }
}
