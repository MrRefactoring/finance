import 'package:flutter/material.dart';
import 'package:finance/src/components/appBar/appBar.dart' as appBar;
import 'package:charts_flutter/flutter.dart' as charts;

class Finances extends StatelessWidget {
  List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 100),
      new LinearSales(1, 75),
      new LinearSales(2, 25),
      new LinearSales(3, 5),
    ];

    return [
      new charts.Series<LinearSales, int>(
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
    final pieHeight = size.width * 0.8;

    return Column(
      children: <Widget>[
        appBar.AppBar('My Finances'),
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
        Container(
          height: pieHeight,
          child: charts.PieChart(
            this._createSampleData(),
            animate: true,
            defaultRenderer: charts.ArcRendererConfig(arcWidth: 60),
          ),
        ),
      ],
    );
  }
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
