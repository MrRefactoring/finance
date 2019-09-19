import 'package:finance/src/components/button/button.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:finance/src/components/appBar/appBar.dart' as appBar;
import 'package:finance/src/components/picker/picker.dart';
import 'package:finance/src/containers/finances/components/pieChart.dart';
import 'package:finance/src/constants.dart' as Constants;

class Finances extends StatelessWidget {
  List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      LinearSales(0, 100),
      LinearSales(1, 75),
      LinearSales(2, 25),
      LinearSales(3, 5),
    ];

    return [
      charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pieSize = size.width * 0.65;

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            appBar.AppBar('Анализ финансов'),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                '23 456,00 ₽',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            PieChart(
              size: pieSize,
              data: this._createSampleData(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Picker([
                  'Расходы',
                  'Зачисления',
                ])
              ],
            ),
          ],
        ),
        Positioned(
          bottom: 15,
          left: 20,
          right: 20,
          child: Center(
            child: Button('Add transaction'),
          ),
        )
      ],
    );
  }
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
