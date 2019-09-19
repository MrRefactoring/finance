import 'package:flutter/material.dart';
import 'package:finance/src/constants.dart' as Constants;

class AppBar extends StatelessWidget {
  final String _title;

  AppBar(this._title);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: Constants.appBar.height,
          color: Constants.appBar.color,
          child: Center(
            child: Text(
              this._title,
              style: TextStyle(
                fontSize: 20,
                color: Constants.appBar.textColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
