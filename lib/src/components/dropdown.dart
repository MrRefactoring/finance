import 'package:flutter/material.dart';

class DropDown extends StatelessWidget {
  final String value;
  final Function(String) onChange;
  final String placeholder;
  final List<String> items;

  DropDown({
    @required this.value,
    @required this.onChange,
    @required this.placeholder,
    @required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      isExpanded: false,
      value: this.value,
      items: this
          .items
          .map((value) => DropdownMenuItem(
                child: Text(value),
                value: value,
              ))
          .toList(),
      onChanged: this.onChange,
      hint: Text(this.placeholder),
    );
  }
}
