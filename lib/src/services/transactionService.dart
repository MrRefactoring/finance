import 'dart:convert';

import 'package:finance/src/models/transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionService {
  SharedPreferences _preferences;
  List<Transaction> _transactions;

  TransactionService(this._preferences) {
    final transactions = this._preferences.getString('transactions');

    if (transactions == null) {
      this._transactions = [];
    } else {
      this._transactions = json.decode(transactions);
    }
  }

  double get currentBalance {
    if (this._transactions.length == 0) {
      return 0;
    }

    return this
        ._transactions
        .map((transaction) => double.parse(transaction.value))
        .reduce((acc, current) => acc + current);
  }

  void addTransaction(Transaction transaction) {
    this._transactions.add(transaction);
    this._updateStorage();
  }

  List<String> getAvailableCategories() {
    return [
      'Restaurants and Cafes',
      'Supermarkets',
      'Communal payments',
      'Transport',
      'Health and beauty',
      'Other',
    ];
  }

  void _updateStorage() {
    this._preferences.setString('transactions', json.encode(this._transactions));
  }
}
