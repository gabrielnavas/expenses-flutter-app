import 'package:expenses_flutter_app/models/chart_recent_item.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final ChartRecentItem chartItem;

  const ChartBar(this.chartItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _renderValue(),
        _renderRestPercentage(),
        _renderPercentage(),
        _renderLabel(),
      ],
    );
  }

  Text _renderLabel() {
    return Text(
      chartItem.label,
      style: const TextStyle(
        color: Colors.purple,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Container _renderPercentage() {
    Text text = Text(
      '${chartItem.percentage.toStringAsFixed(2)}%',
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 11.5,
      ),
    );
    Widget? chield = chartItem.percentage > 41.00 ? text : null;
    return Container(
      height: chartItem.percentage,
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

  Container _renderRestPercentage() {
    Text text = Text(
      '${chartItem.restPercentage.toStringAsFixed(2)}%',
      style: const TextStyle(
        color: Colors.black45,
        fontWeight: FontWeight.bold,
        fontSize: 11.5,
      ),
    );
    Widget? child = chartItem.restPercentage > 41.00 ? text : null;
    return Container(
      height: chartItem.restPercentage,
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

  Text _renderValue() {
    return Text(
      'R\$${chartItem.value.toStringAsFixed(2).toString()}',
      style: const TextStyle(
        color: Colors.purple,
        fontWeight: FontWeight.bold,
        fontSize: 10.7,
      ),
    );
  }
}
