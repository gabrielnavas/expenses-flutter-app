import 'package:expenses_flutter_app/models/chart_recent_item.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final ChartRecentItem chartRecentItem;

  const ChartBar(this.chartRecentItem, {super.key});

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
    return Text(chartRecentItem.label);
  }

  Container _renderPercentage() {
    Widget? chield = chartRecentItem.percentage > 41.00
        ? Text(
            '${chartRecentItem.percentage.toStringAsFixed(2)}%',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11.5,
            ),
          )
        : null;
    return Container(
      height: chartRecentItem.percentage,
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
    return Container(
      height: chartRecentItem.restPercentage,
      width: 32,
      color: Colors.black12,
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: RotatedBox(
        quarterTurns: 3,
        child: Container(
          alignment: Alignment.center,
          child: chartRecentItem.restPercentage > 41.00
              ? Text(
                  '${chartRecentItem.restPercentage.toStringAsFixed(2)}%',
                  style: const TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                  ),
                )
              : null,
        ),
      ),
    );
  }

  Text _renderValue() {
    return Text(
      'R\$${chartRecentItem.value.toStringAsFixed(2).toString()}',
      style: const TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.bold,
        fontSize: 11.5,
      ),
    );
  }
}
