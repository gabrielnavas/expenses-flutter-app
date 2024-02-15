import 'package:expenses_flutter_app/models/chart_recent.dart';
import 'package:expenses_flutter_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final ChartRecent chartRecent;

  const Chart(this.chartRecent, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> childrenWeeks = chartRecent.itemsWeek
        .map((chartRecentItem) => ChartBar(chartRecentItem))
        .toList();

    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Row(
        children: childrenWeeks,
      ),
    );
  }
}
