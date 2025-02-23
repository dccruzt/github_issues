import 'package:flutter/material.dart';

enum FilterBy {
  clear,
  moreThan2Comments,
  lastHour,
  frameworkLabel,
}

class FilterDropdownButton extends StatefulWidget {
  const FilterDropdownButton({
    super.key,
    required this.filterBy,
    required this.onTap,
  });

  final FilterBy filterBy;
  final ValueChanged<FilterBy> onTap;

  @override
  State<FilterDropdownButton> createState() => _FilterDropdownButtonState();
}

class _FilterDropdownButtonState extends State<FilterDropdownButton> {
  late FilterBy _dropdownValue;

  @override
  void initState() {
    super.initState();

    _dropdownValue = widget.filterBy;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DropdownButton<FilterBy>(
      value: _dropdownValue,
      style: theme.textTheme.bodyLarge,
      underline: Container(height: 2),
      onChanged: (FilterBy? value) {
        setState(() {
          _dropdownValue = value!;
          widget.onTap.call(value);
        });
      },
      items: FilterBy.values.map<DropdownMenuItem<FilterBy>>((FilterBy value) {
        return DropdownMenuItem<FilterBy>(
          value: value,
          child: Text(_getFilterName(value)),
        );
      }).toList(),
    );
  }

  String _getFilterName(FilterBy filterBy) => switch (filterBy) {
        FilterBy.clear => 'clear',
        FilterBy.moreThan2Comments => '2 comments',
        FilterBy.lastHour => 'last hour',
        FilterBy.frameworkLabel => 'framework'
      };
}
