import 'package:flutter/material.dart';
import 'package:finance/src/constants.dart';

class Button extends StatelessWidget {
  final String text;
  final Function onClick;

  Button({
    @required this.text,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Constants.blue,
      disabledColor: Constants.blue,
      onPressed: this.onClick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.add,
            size: 16,
            color: Constants.white,
          ),
          Container(
            width: 16,
          ),
          Text(
            this.text,
            style: Constants.buttonTextStyle,
          ),
        ],
      ),
    );
  }
}
