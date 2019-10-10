import 'package:finance/src/helpers.dart';
import 'package:finance/src/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionWidget extends StatelessWidget {
  final Transaction transaction;

  TransactionWidget(this.transaction);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final price = double.parse(this.transaction.price);

    final icon = price >= 0 ? Icons.arrow_upward : Icons.arrow_downward;
    final color = price >= 0 ? Colors.green : Colors.red;

    return Container(
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
          Center(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(this.transaction.title),
                    Text(buildDateText(this.transaction.date)),
                  ],
                ),
                Text(this.transaction.description ?? 'No description')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
