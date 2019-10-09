import 'package:finance/src/components/loader.dart';
import 'package:finance/src/constants.dart';
import 'package:flutter/material.dart';

class Balance extends StatefulWidget {
  final Future<double> balance;

  Balance(this.balance);

  @override
  State<StatefulWidget> createState() => BalanceState();
}

class BalanceState extends State<Balance> {
  double balance;

  @override
  initState() {
    super.initState();

    this.widget.balance.then((balance) {
      this.setState(() {
        this.balance = balance;
      });
    });
  }

  renderBalance() {
    return [
      Text(
        'Current Balance',
        style: Constants.balanceSubtitleStyles,
      ),
      Text(
        '\$ ${this.balance}',
        style: Constants.balanceStyle,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final content = this.balance == null ? [Loader()] : this.renderBalance();

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
        children: content,
      ),
    );
  }
}
