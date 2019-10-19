import 'package:finance/src/models/transaction.dart';

class Transactions {
  static List<Transaction> fromJson(List<dynamic> list) {
    return list
        .map((transaction) => Transaction.fromJson(transaction))
        .toList();
  }
}
