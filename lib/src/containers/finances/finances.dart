import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:finance/src/components/button.dart';
import 'package:finance/src/components/fragmentView.dart';
import 'package:finance/src/components/loader.dart';
import 'package:finance/src/containers/finances/components/balance.dart';
import 'package:finance/src/containers/finances/components/transactionModal/transactionModal.dart';
import 'package:finance/src/services/transactionService.dart';

class Finances extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FinancesState();
}

class FinancesState extends State<Finances> {
  bool transactionModalIsOpen = false;
  TransactionService transactionService;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      this.setState(() {
        this.transactionService = TransactionService(prefs);
      });
    });
  }

  toggleTransactionModal() {
    this.setState(() {
      this.transactionModalIsOpen = !this.transactionModalIsOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (this.transactionService == null) {
      return Loader();
    }

    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Balance(this.transactionService.currentBalance),
            FragmentView(
              title: 'Transaction chart',
              child: Text('data'),
            ),
            FragmentView(
              title: 'Overview',
              child: Text('this is transaction history'),
            ),
          ],
        ),
        Positioned(
          left: 120,
          right: 120,
          bottom: 20,
          child: Button(
            text: 'Add transaction',
            onClick: this.toggleTransactionModal,
          ),
        ),
        TransactionModal(
          isOpen: this.transactionModalIsOpen,
          closeModal: () => this.toggleTransactionModal(),
          transactionService: this.transactionService
        ),
      ],
    );
  }
}
