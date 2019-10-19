import 'package:flutter/material.dart';

import 'package:finance/src/components/button.dart';
import 'package:finance/src/components/inputField.dart';
import 'package:finance/src/services/transactionModal.dart';
import 'package:finance/src/services/transactionService.dart';
import 'package:finance/src/containers/finances/components/chart.dart';
import 'package:finance/src/containers/finances/components/history.dart';
import 'package:finance/src/containers/finances/components/balance.dart';

class Finances extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FinancesState();
}

class FinancesState extends State<Finances> {
  bool modalOpened = false;
  TransactionService transactionService;

  String category;

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

  showTransactionModal() async {
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

  setCategory(String category) {
    this.setState(() {
      this.category = category;
    });
  }

  showSettings(context) async {
    this.category = '';

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add category'),
          content: InputField(
            autofocus: true,
            value: this.category,
            onChange: this.setCategory,
            decoration: InputDecoration(labelText: 'Category'),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('CANCEL'),
            ),
            FlatButton(
              onPressed: () async {
                await this.transactionService.addTransactionCategory(this.category);
                Navigator.of(context).pop();
              },
              child: Text('ADD'),
            ),
          ],
        );
      }
    );
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
          right: 10,
          top: 10,
          child: IconButton(
            color: Colors.white,
            iconSize: 28,
            onPressed: () => this.showSettings(context),
            icon: Icon(Icons.settings),
          ),
        ),
        Positioned(
          left: 120,
          right: 120,
          bottom: 20,
          child: Button(
            text: 'Add transaction',
            onClick: showTransactionModal,
          ),
        ),
      ],
    );
  }
}
