import 'package:finance/src/components/inputField.dart';
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
    @required this.closeModal,
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

  onChangeTitle(String title) {
    this.setState(() {
      this.transaction.title = title;
    });
  }

  onChangeTransactionCategory(String category) {
    this.setState(() {
      this.transaction.category = category;
    });
  }

  onDescriptionChanged(String description) {
    this.setState(() {
      this.transaction.description = description;
    });
  }

  onPriceChanged(String price) {
    this.setState(() {
      this.transaction.value = price;
    });
  }

  selectDate() async {
    final date = await showDatePicker(
      context: this.context,
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
      firstDate: DateTime(2016),
    );

    this.setState(() {
      this.transaction.date = date;
    });
  }

  addTransaction() {
    this.setState(() {
      this.widget.transactionService.addTransaction(this.transaction);
      this.widget.closeModal();
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
                child: InputField(
                  value: this.transaction.title,
                  autofocus: true,
                  decoration: InputDecoration(hintText: 'Title'),
                  onChange: this.onChangeTitle,
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
                  onTap: this.selectDate,
                  controller: TextEditingController(), // TODO put date here
                ),
              ),
              SimpleDialogOption(
                child: InputField(
                  value: this.transaction.value,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'Price'),
                  onChange: this.onPriceChanged,
                ),
              ),
              SimpleDialogOption(
                child: InputField(
                  value: this.transaction.description,
                  onChange: this.onDescriptionChanged,
                  decoration: InputDecoration(
                    hintText: 'Description',
                  ),
                ),
              ),
              SimpleDialogOption(
                child: RaisedButton(
                  onPressed: this.addTransaction,
                  child: Text('Add'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
