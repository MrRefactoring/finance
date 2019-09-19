import 'package:flutter/material.dart';
import 'package:finance/src/constants.dart' as Constants;

class Button extends StatelessWidget {
  final String text;
  final Function onClick;

  Button(this.text, {this.onClick});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Text(this.text),
        color: Constants.green,
        disabledColor: Constants.green,
        textColor: Colors.white,
        disabledTextColor: Colors.white,
        onPressed: this.onClick,
      ),
    );
  }
}
