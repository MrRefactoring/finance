import 'package:finance/src/constants.dart';
import 'package:flutter/material.dart';

class FragmentView extends StatelessWidget {
  final String title;
  final Widget child;

  FragmentView({
    @required this.title,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width - 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: 20,
              bottom: 20,
            ),
            child: Text(
              this.title,
              style: Constants.fragmentViewTitleStyle,
            ),
          ),
          this.child,
        ],
      ),
    );
  }
}
