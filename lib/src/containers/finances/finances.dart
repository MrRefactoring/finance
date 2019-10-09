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
            onClick: showDialog,
          ),
        ),
      ],
    );
  }
}
