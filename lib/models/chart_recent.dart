import 'package:expenses_flutter_app/models/chart_recent_item.dart';
import 'package:expenses_flutter_app/models/transaction.dart';

class ChartRecent {
  List<ChartRecentItem> itemsWeek = [];

  ChartRecent(int lastRecentTransactions, List<Transaction> transactions) {
    _generateItemsWeek(lastRecentTransactions, transactions);
  }

  void _generateItemsWeek(
    int howManyRecentsItems,
    List<Transaction> transactions,
  ) {
    List<Transaction> recentTransaction = Transaction.recentTransactions(
      howManyRecentsItems,
      transactions,
    );
    itemsWeek = ChartRecentItem.generateRecentChartItems(
      howManyRecentsItems,
      recentTransaction,
    );
  }
}
