import 'package:finance/src/constants.dart';
import 'package:flutter/material.dart';

class Balance extends StatelessWidget {
  final double balance;

  Balance(this.balance);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Constants.gradientBeginColor, Constants.gradientEndColor],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Current Balance',
            style: Constants.balanceSubtitleStyles,
          ),
          Text(
            '\$ ${this.balance}',
            style: Constants.balanceStyle,
          ),
        ],
      ),
    );
  }
}
