import 'package:finance/src/helpers.dart';
import 'package:finance/src/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionWidget extends StatelessWidget {
  final Transaction transaction;

  TransactionWidget(this.transaction);

  showTransactionInfo(context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(this.transaction.title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(this.transaction.description ?? 'No description'),
              Text(this.transaction.category),
              Text(buildDateText(this.transaction.date)),
              Text('\$ ${this.transaction.price}'),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final price = double.parse(this.transaction.price);

    final icon = price >= 0 ? Icons.arrow_upward : Icons.arrow_downward;
    final color = price >= 0 ? Colors.green : Colors.red;

    return GestureDetector(
      onTap: () => this.showTransactionInfo(context),
      child: Container(
        width: size.width,
        margin: EdgeInsets.only(top: 15),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow()],
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: color,
              size: 30.0,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              '\$ ${price.abs()}',
              style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
            SizedBox(
              width: 15,
            ),
            Text(this.transaction.title),
            SizedBox(
              width: 15,
            ),
            Text(buildDateText(this.transaction.date)),
          ],
        ),
      ),
    );
  }
}
