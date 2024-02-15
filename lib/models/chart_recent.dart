import 'package:expenses_flutter_app/models/chart_recent_item.dart';
import 'package:expenses_flutter_app/models/transaction.dart';
import 'package:intl/intl.dart';

class ChartRecent {
  double totalTransactions = 0.00;
  List<ChartRecentItem> itemsWeek = [];
  int lastRecentTransactions = 0;

  ChartRecent(this.lastRecentTransactions, List<Transaction> transactions) {
    List<Transaction> recentTransaction = _recentTransactions(transactions);
    itemsWeek = _generateChartItems(recentTransaction);
  }

  List<ChartRecentItem> _generateChartItems(List<Transaction> transactions) {
    // generate a list with the last week days
    List<ChartRecentItem> chartItems =
        List.generate(lastRecentTransactions, (index) {
      // get today date or before util
      // $weekDays= today, today-1 days, today-2 days, today-3 days and etc
      final DateTime today = DateTime.now();
      final weekDaySubtracted = today.subtract(Duration(days: index));

      // get total value of week day ndex
      double totalValueToday = 0.00;
      for (int i = 0; i < transactions.length; i++) {
        bool sameDay = transactions[i].date.day == weekDaySubtracted.day;
        bool sameMonth = transactions[i].date.month == weekDaySubtracted.month;
        bool sameYear = transactions[i].date.year == weekDaySubtracted.year;
        if (sameDay && sameMonth && sameYear) {
          totalValueToday += transactions[i].value;
        }
      }

      return ChartRecentItem.withoutPercentage(
        value: totalValueToday,

        // get acronym of the week day = S M T W T F S
        label: DateFormat.E().format(weekDaySubtracted)[0],
      );
    });

    // get sum value transaction
    for (int i = 0; i < transactions.length; i++) {
      totalTransactions += transactions[i].value;
    }

    // set porcetagem and rest
    if (totalTransactions <= 0.00) {
      throw Exception('total transaction is zero');
    }
    for (int i = 0; i < chartItems.length; i++) {
      chartItems[i].percentage =
          (chartItems[i].value / totalTransactions) * 100;
      chartItems[i].restPercentage = 100.00 - chartItems[i].percentage;
    }

    // S F T W T M S -> S M T W T F S
    chartItems = chartItems.reversed.toList();

    return chartItems;
  }

  List<Transaction> _recentTransactions(List<Transaction> transactions) {
    final DateTime today = DateTime.now();
    final DateTime weekDayInitial =
        today.subtract(Duration(days: lastRecentTransactions));
    return transactions
        .where((transaction) => transaction.date.isAfter(weekDayInitial))
        .toList();
  }
}
