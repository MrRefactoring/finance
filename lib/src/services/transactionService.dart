import 'dart:convert';

import 'package:finance/src/constants.dart';
import 'package:finance/src/models/transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionService {
  double _currentBalance;
  List<String> _categories;
  List<Transaction> _transactions;
  Future<SharedPreferences> _preferences;

  TransactionService() {
    this._preferences = SharedPreferences.getInstance();
  }

  Future<void> addTransaction(Transaction transaction) async {
    final transactions = await this.transactions;

    transactions.add(transaction);

    this._currentBalance += double.parse(transaction.price);
    this._updateStorage();
  }

  Future<void> addTransactionCategory(String category) async {
    final categories = await this.transactionCategories;

    categories.add(category);

    this._categories = categories;
    this._updateStorage();
  }

  Future<double> get balance async {
    if (this._currentBalance != null) {
      return this._currentBalance;
    }

    final transactions = await this.transactions;

    final balanceHistory =
        transactions.map((transaction) => double.parse(transaction.price));

    if (balanceHistory.length != 0) {
      this._currentBalance = balanceHistory
          .reduce((accumulator, current) => accumulator + current);
    }

    return this._currentBalance ?? 0;
  }

  Future<List<Transaction>> get transactions async {
    if (this._transactions != null) {
      return this._transactions;
    }

    final preferences = await this._preferences;
    final transactions = preferences.getString(Constants.storages.transactions);

    this._transactions = transactions != null ? json.decode(transactions) : [];

    return this._transactions;
  }

  Future<List<String>> get transactionCategories async {
    if (this._categories != null) {
      return this._categories;
    }

    final preferences = await this._preferences;
    final categories = preferences.getString(Constants.storages.categories);

    this._categories = categories != null
        ? json.decode(categories)
        : [
            'Restaurants and Cafes',
            'Supermarkets',
            'Communal payments',
            'Transport',
            'Health and beauty',
            'Other',
          ];

    return this._categories;
  }

  Future<void> _updateStorage() async {
    final preferencies = await this._preferences;

    preferencies.setString(
      Constants.storages.transactions,
      json.encode(this._transactions),
    );

    preferencies.setString(
      Constants.storages.categories,
      json.encode(this._categories),
    );
  }
}
