import 'package:finance/src/validators/priceValidator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  final dynamic value;
  final bool autofocus;
  final Function(String) onChange;
  final InputDecoration decoration;
  final TextInputType keyboardType;
  final TextEditingController controller = TextEditingController();

  InputField({
    @required this.value,
    @required this.onChange,
    this.decoration,
    this.keyboardType,
    this.autofocus = false,
  }) {
    this.controller.text = (this.value ?? '').toString();

    this.controller.selection = TextSelection.collapsed(
      offset: this.controller.text.length,
    );

    this.controller.addListener(() => this.onChange(this.controller.text));
  }

  @override
  Widget build(BuildContext context) {
    final formatters = this.keyboardType?.index == 2 ? [PriceValidator()] : null;

    return TextField(
      autofocus: this.autofocus,
      keyboardType: this.keyboardType,
      decoration: this.decoration,
      controller: this.controller,
      inputFormatters: formatters,
    );
  }
}
