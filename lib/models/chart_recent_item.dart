import 'package:expenses_flutter_app/models/transaction.dart';
import 'package:intl/intl.dart';

class ChartRecentItem {
  String label;
  double value;
  double percentage = 0.00;
  double restPercentage = 0.00;

  ChartRecentItem.withoutPercentage({
    required this.label,
    required this.value,
  });

  static List<ChartRecentItem> generateRecentChartItems(
    int howManyRecent,
    List<Transaction> transactions,
  ) {
    List<ChartRecentItem> chartItems = List.generate(howManyRecent, (index) {
      DateTime weekDaySubtracted = _getDateUntilLimitIndex(index);

      // get total value of week day ndex
      double totalValueToday =
          _getTotalValueOfWeekDay(transactions, weekDaySubtracted);

      return ChartRecentItem.withoutPercentage(
        value: totalValueToday,

        // get acronym of the week day = S M T W T F S
        label: DateFormat.E().format(weekDaySubtracted)[0],
      );
    });

    _setPorcentageAndRestEachItem(chartItems);

    // reverse charItems S F T W T M S -> S M T W T F S
    chartItems = chartItems.reversed.toList();

    return chartItems;
  }

  static DateTime _getDateUntilLimitIndex(int index) {
    // get today date or before util
    // $weekDays= today, today-1 days, today-2 days, today-3 days and etc
    final DateTime today = DateTime.now();
    final weekDaySubtracted = today.subtract(Duration(days: index));
    return weekDaySubtracted;
  }

  static void _setPorcentageAndRestEachItem(List<ChartRecentItem> chartItems) {
    final double totalTransactions = chartItems.fold(
        0.00, (previousValue, chartItem) => chartItem.value + previousValue);
    for (var chartItem in chartItems) {
      chartItem.percentage = (chartItem.value / totalTransactions) * 100;
      chartItem.restPercentage = 100.00 - chartItem.percentage;
    }
  }

  static double _getTotalValueOfWeekDay(
      List<Transaction> transactions, DateTime weekDayTarget) {
    return transactions.fold(0.00, (previousValue, transaction) {
      bool sameDay = transaction.date.day == weekDayTarget.day;
      bool sameMonth = transaction.date.month == weekDayTarget.month;
      bool sameYear = transaction.date.year == weekDayTarget.year;
      if (sameDay && sameMonth && sameYear) {
        return previousValue + transaction.value;
      }
      return previousValue;
    });
  }
}
