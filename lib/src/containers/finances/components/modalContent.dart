import 'package:flutter/material.dart';

import 'package:finance/src/helpers.dart';
import 'package:finance/src/constants.dart';
import 'package:finance/src/models/transaction.dart';
import 'package:finance/src/components/dropdown.dart';
import 'package:finance/src/components/inputField.dart';

class ModalContent extends StatefulWidget {
  final Transaction transaction;
  final List<String> categories;

  ModalContent({
    @required this.transaction,
    @required this.categories,
  });

  @override
  State<StatefulWidget> createState() => _ModalContentState();
}

class _ModalContentState extends State<ModalContent> {
  changeTitle(String title) {
    this.setState(() {
      this.widget.transaction.title = title;
    });
  }

  changeDescription(String description) {
    this.setState(() {
      this.widget.transaction.description = description;
    });
  }

  changeCategory(String category) {
    this.setState(() {
      this.widget.transaction.category = category;
    });
  }

  changeDate(DateTime date) {
    this.setState(() {
      this.widget.transaction.date = date;
    });
  }

  changePrice(String price) {
    this.setState(() {
      this.widget.transaction.price = price;
    });
  }

  showPicker(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
      firstDate: DateTime(2000),
    );

    this.changeDate(date);
  }

  @override
  Widget build(BuildContext context) {    
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Flexible(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              InputField(
                autofocus: true,
                decoration: Constants.styles.modalTextField('Title'),
                value: this.widget.transaction.title,
                onChange: this.changeTitle,
              ),
              InputField(
                value: this.widget.transaction.description,
                decoration: Constants.styles.modalTextField('Description'),
                onChange: this.changeDescription,
              ),
              TextField(
                controller: TextEditingController(text: buildDateText(this.widget.transaction.date)),
                decoration: Constants.styles.modalTextField('Date'),
                onTap: () => this.showPicker(context),
              ),
              DropDown(
                placeholder: 'Category',
                items: this.widget.categories,
                value: this.widget.transaction.category,
                onChange: this.changeCategory,
              ),
              InputField(
                value: this.widget.transaction.price,
                keyboardType: TextInputType.number,
                decoration: Constants.styles.modalTextField('Price'),
                onChange: this.changePrice,
              ),
            ],
          ),
        ),
      )
    ]);
  }
}
