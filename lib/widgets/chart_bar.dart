import 'package:expenses_flutter_app/models/chart_recent_item.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final ChartRecentItem chartItem;

  const ChartBar(this.chartItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraint) {
        return Column(
          children: [
            _renderValue(constraint.maxHeight * 0.15),
            _renderRestPercentage(constraint.maxHeight * 0.70),
            _renderPercentage(constraint.maxHeight * 0.70),
            _renderLabel(constraint.maxHeight * 0.15),
          ],
        );
      },
    );
  }

  SizedBox _renderLabel(double height) {
    return SizedBox(
      height: height,
      child: Text(
        chartItem.label,
        style: const TextStyle(
          color: Colors.purple,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Container _renderPercentage(double hight) {
    Text text = Text(
      '${chartItem.percentage.toStringAsFixed(2)}%',
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 11.5,
      ),
    );
    Widget? chield = chartItem.percentage > 45.00 ? text : null;
    return Container(
      height: (chartItem.percentage / 100) * hight,
      width: 32,
      color: Colors.purple,
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: RotatedBox(
        quarterTurns: 3,
        child: Container(
          alignment: Alignment.center,
          child: chield,
        ),
      ),
    );
  }

  Container _renderRestPercentage(double hight) {
    Text text = Text(
      '${chartItem.restPercentage.toStringAsFixed(2)}%',
      style: const TextStyle(
        color: Colors.black45,
        fontWeight: FontWeight.bold,
        fontSize: 11.5,
      ),
    );
    Widget? child = chartItem.restPercentage > 45.00 ? text : null;
    return Container(
      height: (chartItem.restPercentage / 100) * hight,
      width: 32,
      color: Colors.black12,
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: RotatedBox(
        quarterTurns: 3,
        child: Container(
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }

  Container _renderValue(double height) {
    return Container(
      height: height,
      alignment: Alignment.center,
      child: Text(
        'R\$${chartItem.value.toStringAsFixed(2).toString()}',
        style: const TextStyle(
          color: Colors.purple,
          fontWeight: FontWeight.bold,
          fontSize: 10.7,
        ),
      ),
    );
  }
}
