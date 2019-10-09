import 'package:flutter/material.dart';

class Constants {
  static final storages = _Storages();
  static final styles = _Styles();
  static final texts = _Texts();

  static final blue = Color.fromARGB(255, 65, 133, 244);
  static final white = Colors.white;

  static final gradientBeginColor = Color.fromARGB(255, 153, 163, 254);
  static final gradientEndColor = Color.fromARGB(255, 105, 117, 230);

  static final background = Color.fromARGB(255, 252, 252, 252);

  static final buttonTextStyle = TextStyle(color: Constants.white);

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
