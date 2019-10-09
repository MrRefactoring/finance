import 'package:flutter/material.dart';

import 'package:finance/src/constants.dart';
import 'package:finance/src/models/transaction.dart';
import 'package:finance/src/containers/finances/components/modalContent.dart';

class TransactionModal {
  final BuildContext context;
  final Future<List<String>> categories;
  final Function(Transaction) addTransaction;

  Transaction transaction;

  TransactionModal({
    @required this.context,
    @required this.categories,
    @required this.addTransaction,
  });

  validateTransaction() {
    if (
      this.transaction.title == null ||
      this.transaction.date == null ||
      this.transaction.category == null ||
      this.transaction.price == null
    ) {
      return 'Some error';
    }

    return false;
  }

  show() async {
    this.transaction = Transaction();

    final categories = await this.categories;

    await showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Constants.texts.addTransaction),
          content: ModalContent(
            categories: categories,
            transaction: transaction,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('ADD'),
              onPressed: () async {
                final error = this.validateTransaction();

                if (error != false) {
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Some error'),
                        content: Text(error),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: Navigator.of(context).pop,
                            child: Text('OK'),
                          )
                        ],
                      );
                    }
                  );

                  return;
                }

                await this.addTransaction(this.transaction);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
