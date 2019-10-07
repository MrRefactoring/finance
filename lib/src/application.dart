import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:finance/src/constants.dart';
import 'package:finance/src/containers/finances/finances.dart';

class Application extends StatelessWidget {
  Application() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Constants.background,
        body: Finances(),
      ),
    );
  }
}
