import 'package:finance/src/components/dropdown.dart';
import 'package:finance/src/components/inputField.dart';
import 'package:finance/src/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:finance/src/constants.dart';

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

  show() async {
    this.transaction = Transaction();

    final categories = await this.categories;

    await showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Constants.texts.addTransaction),
          content: _DialogBody(
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

class _DialogBody extends StatefulWidget {
  final Transaction transaction;
  final List<String> categories;

  _DialogBody({
    @required this.transaction,
    @required this.categories,
  });

  @override
  State<StatefulWidget> createState() => _DialogBodyState();
}

class _DialogBodyState extends State<_DialogBody> {
  changeTitle(String title) {
    this.widget.transaction.title = title;
  }

  changeDescription(String description) {
    this.widget.transaction.description = description;
  }

  changeCategory(String category) {
    this.widget.transaction.category = category;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        InputField(
          autofocus: true,
          decoration: InputDecoration(hintText: 'Title'),
          value: this.widget.transaction.title,
          onChange: this.changeTitle,
        ),
        InputField(
          value: this.widget.transaction.description,
          decoration: InputDecoration(hintText: 'Description'),
          onChange: this.changeDescription,
        ),
        DropDown(
          placeholder: 'Category',
          items: this.widget.categories,
          value: this.widget.transaction.category,
          onChange: this.changeCategory,
        )
      ],
    );;
  }
}
