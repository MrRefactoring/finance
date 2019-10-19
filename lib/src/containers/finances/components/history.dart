import 'package:flutter/material.dart';

import 'package:finance/src/components/loader.dart';
import 'package:finance/src/containers/finances/components/transactionWidget.dart';
import 'package:finance/src/models/transaction.dart';

class History extends StatefulWidget {
  final Future<List<Transaction>> transactions;

  History(this.transactions);

  @override
  State<StatefulWidget> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Transaction> transactions;

  @override
  void initState() {
    super.initState();

    this.widget.transactions.then((transactions) {
      this.setState(() {
        this.transactions = transactions;
      });
    });
  }

  @override
  void didUpdateWidget(History oldWidget) {
    super.didUpdateWidget(oldWidget);

    this.setState(() {
      this.transactions = null;
    });

    this.widget.transactions.then((transactions) {
      this.setState(() {
        this.transactions = transactions;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (this.transactions == null) {
      return Loader();
    }

    this.transactions.sort((fTransaction, sTransaction) =>
        -fTransaction.date.compareTo(sTransaction.date));

    final transactions = this
        .transactions
        .map((transaction) => TransactionWidget(transaction))
        .toList();

    final List<Widget> render = [
      Text(
        'Last 30 days transactions',
        style: TextStyle(
          color: Colors.grey[800],
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    ];

    render.addAll(transactions);
    render.add(SizedBox(
      height: 100,
    ));

    return Container(
      child: Column(
        children: render,
      ),
    );
  }
}
