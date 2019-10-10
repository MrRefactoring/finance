import 'package:bezier_chart/bezier_chart.dart';
import 'package:finance/src/constants.dart';
import 'package:finance/src/containers/finances/components/chart.dart';
import 'package:finance/src/containers/finances/components/history.dart';
import 'package:flutter/material.dart';

import 'package:finance/src/components/button.dart';
import 'package:finance/src/services/transactionModal.dart';
import 'package:finance/src/services/transactionService.dart';
import 'package:finance/src/containers/finances/components/balance.dart';

class Finances extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FinancesState();
}

class FinancesState extends State<Finances> {
  bool modalOpened = false;
  TransactionService transactionService;

  @override
  void initState() {
    super.initState();

    this.setState(() {
      this.transactionService = TransactionService();
    });
  }

  toggleModal() {
    this.setState(() {
      this.modalOpened = !this.modalOpened;
    });
  }

  showDialog() async {
    final dialog = TransactionModal(
      context: context,
      categories: this.transactionService.categories,
      addTransaction: this.transactionService.addTransaction,
    );

    await dialog.show();

    this.setState(() {
      this.transactionService = transactionService;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Balance(this.transactionService.balance),
                    Container(
                      transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [BoxShadow()],
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                      ),
                      height: width * 0.6,
                      width: width * 0.9,
                      child: Chart(this.transactionService.last()),
                    ),
                    Container(
                      width: width * 0.9,
                      child: History(this.transactionService.transactions),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        Positioned(
          left: 120,
          right: 120,
          bottom: 20,
          child: Button(
            text: 'Add transaction',
            onClick: showDialog,
          ),
        ),
      ],
    );
  }
}
