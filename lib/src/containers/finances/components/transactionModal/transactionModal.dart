import 'package:finance/src/containers/finances/components/transactionModal/dropdown.dart';
import 'package:finance/src/models/transaction.dart';
import 'package:finance/src/services/transactionService.dart';
import 'package:flutter/material.dart';
import 'package:finance/src/constants.dart';

class TransactionModal extends StatefulWidget {
  final bool isOpen;
  final Function closeModal;
  final TransactionService transactionService;

  TransactionModal({
    this.isOpen = false,
    this.closeModal,
    @required this.transactionService,
  });

  @override
  State<StatefulWidget> createState() => TransactionModalState();
}

class TransactionModalState extends State<TransactionModal> {
  Transaction transaction;

  TransactionModalState() {
    this.transaction = Transaction();
  }

  onChangeTransactionCategory(String category) {
    this.setState(() {
      this.transaction.category = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!this.widget.isOpen) {
      this.transaction = Transaction();
      return Container();
    }

    final availableCategories =
        this.widget.transactionService.getAvailableCategories();

    return GestureDetector(
      onTap: this.widget.closeModal,
      child: Container(
        color: Constants.dimmerColor,
        child: GestureDetector(
          onTap: null,
          child: SimpleDialog(
            title: Text('Add transaction'),
            children: <Widget>[
              SimpleDialogOption(
                child: TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Title'
                  ),
                ),
              ),
              SimpleDialogOption(
                child: DropDown(
                  value: this.transaction.category,
                  items: availableCategories,
                  onChange: this.onChangeTransactionCategory,
                  placeholder: 'Category',
                ),
              ),
              SimpleDialogOption(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Description'
                  ),
                ),
              ),
               SimpleDialogOption(
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Coast'
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
