import 'dart:convert';

import 'package:finance/src/constants.dart';
import 'package:finance/src/models/transaction.dart';
import 'package:finance/src/models/transactions.dart';
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

    this._currentBalance = await this.balance + double.parse(transaction.price);
    this._updateStorage();
  }

  Future<void> addTransactionCategory(String category) async {
    final categories = await this.categories;

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

    this._transactions = transactions != null ? Transactions.fromJson(jsonDecode(transactions)) : [];

    return this._transactions;
  }

  Future<List<String>> get categories async {
    if (this._categories != null) {
      return this._categories;
    }

    final preferences = await this._preferences;
    final categories = preferences.getString(Constants.storages.categories);

    // this._categories = categories != null
    //     ? jsonDecode(categories)
    //     : [
    //         'Restaurants and Cafes',
    //         'Supermarkets',
    //         'Communal payments',
    //         'Transport',
    //         'Health and beauty',
    //         'Other',
    //       ];

    this._categories = [
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

    if (this.transactions != null) {
      preferencies.setString(
        Constants.storages.transactions,
        jsonEncode(this._transactions),
      );
    }

    if (this._categories != null) {
      preferencies.setString(
        Constants.storages.categories,
        jsonEncode(this._categories),
      );
    }
  }
}
