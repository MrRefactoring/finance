import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_common/common.dart' as common;
import 'package:finance/src/constants.dart' as Constants;

class PieChart extends StatelessWidget {
  final double size;
  final List<common.Series> data;

  PieChart({
    @required this.data,
    @required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.size,
      child: charts.PieChart(
        this.data,
        animate: true,
        animationDuration: Duration(milliseconds: 400),
        defaultRenderer: charts.ArcRendererConfig(arcWidth: Constants.chart.ringSize),
      ),
    );
  }
}
