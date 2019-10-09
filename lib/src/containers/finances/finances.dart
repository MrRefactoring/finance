import 'package:finance/src/containers/finances/components/balance.dart';
import 'package:finance/src/containers/finances/components/transactionModal.dart';
import 'package:flutter/material.dart';

import 'package:finance/src/components/button.dart';
import 'package:finance/src/services/transactionService.dart';

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

  @override
  Widget build(BuildContext context) {
    final dialog = TransactionModal(
      context: context,
      categories: this.transactionService.categories,
      addTransaction: this.transactionService.addTransaction,
    );

    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Balance(this.transactionService.balance),
          ],
        ),
        Positioned(
          left: 120,
          right: 120,
          bottom: 20,
          child: Button(
            text: 'Add transaction',
            onClick: dialog.show,
          ),
        ),
      ],
    );
  }
}
