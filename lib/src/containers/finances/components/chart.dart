import 'package:bezier_chart/bezier_chart.dart';
import 'package:finance/src/components/loader.dart';
import 'package:finance/src/models/transaction.dart';
import 'package:flutter/material.dart';

class Chart extends StatefulWidget {
  final Future<List<Transaction>> transactions;

  Chart(this.transactions);

  @override
  State<StatefulWidget> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<Transaction> transactions;

  @override
  void initState() {
    super.initState();

    this.widget.transactions.then((transactions) {
      this.setState(() {
        this.transactions = transactions;
      });
    });
  }

  @override
  void didUpdateWidget(Chart oldWidget) {
    super.didUpdateWidget(oldWidget);

    this.setState(() {
      this.transactions = null;
    });

    this.widget.transactions.then((transactions) {
      this.setState(() {
        this.transactions = transactions;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (this.transactions == null) {
      return Center(
        child: Loader(),
      );
    }

    final income = this
        .transactions
        .where((transaction) => double.parse(transaction.price) >= 0)
        .map((transaction) => DataPoint<DateTime>(
              value: double.parse(transaction.price),
              xAxis: transaction.date,
            ))
        .toList();

    final costs = this
        .transactions
        .where((transaction) => double.parse(transaction.price) < 0)
        .map((transaction) => DataPoint<DateTime>(
              value: -double.parse(transaction.price),
              xAxis: transaction.date,
            ))
        .toList();

    return BezierChart(
      bezierChartScale: BezierChartScale.WEEKLY,
      fromDate: DateTime.now().subtract(Duration(days: 30)),
      toDate: DateTime.now(),
      selectedDate: DateTime.now(),
      series: [
        BezierLine(
          lineColor: Colors.green[700],
          label: 'Income',
          onMissingValue: (dateTime) => 0,
          data: income,
        ),
        BezierLine(
          lineColor: Colors.red,
          label: 'Costs',
          data: costs,
        ),
      ],
      config: BezierChartConfig(
        xAxisTextStyle: TextStyle(color: Colors.black),
        yAxisTextStyle: TextStyle(color: Colors.black),
        verticalIndicatorStrokeWidth: 3.0,
        verticalIndicatorColor: Colors.black26,
        showVerticalIndicator: true,
        backgroundColor: Colors.transparent,
        xLinesColor: Colors.black,
        displayDataPointWhenNoValue: true,
        snap: false,
        footerHeight: 60,
      ),
    );
  }
}
