import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:finance/src/containers/finances/finances.dart';
import 'package:finance/src/constants.dart' as Constants;

class Application extends StatelessWidget {
  Application() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Fedra',
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Constants.background,
        body: Finances(),
      ),
    );
  }
}
