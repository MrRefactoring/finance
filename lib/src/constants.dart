import 'package:flutter/material.dart';

class Constants {
  static final storages = _Storages();
  static final styles = _Styles();
  static final texts = _Texts();

  static final months = {
    1: 'January',
    2: 'February',
    3: 'March',
    4: 'April',
    5: 'May',
    6: 'June',
    7: 'Jule',
    8: 'August',
    9: 'September',
    10: 'October',
    11: 'November',
    12: 'December',
  };

  static final blue = Color.fromARGB(255, 73, 147, 236);
  static final white = Colors.white;

  static final gradientBeginColor = Color.fromARGB(255, 94, 163, 238);
  static final gradientEndColor = Color.fromARGB(255, 49, 99, 186);

  static final background = Color.fromARGB(255, 252, 252, 252);

  static final buttonTextStyle =
      TextStyle(color: Constants.white, fontWeight: FontWeight.normal);

  static final balanceSubtitleStyles = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.white70,
  );

  static final dimmerColor = Color.fromARGB(127, 0, 0, 0);
}

class _Storages {
  final transactions = 'transactions';
  final categories = 'categories';
}

class _Styles {
  final texts = _TextStyles();

  final modalTextField = (String label) => InputDecoration(
        labelText: label,
        contentPadding: EdgeInsets.only(bottom: 8),
      );
}

class _TextStyles {
  final balance = TextStyle(
    fontSize: 48,
    color: Colors.white,
  );
}

class _Texts {
  final addTransaction = 'Add transaction';
}
