class Transaction {
  final String id;
  final String title;
  final double value;
  final DateTime date;

  Transaction({
    required this.id,
    required this.title,
    required this.value,
    required this.date,
  });

  bool valid() {
    if (title.isEmpty) {
      return false;
    }
    if (value <= 0) {
      return false;
    }
    return true;
  }

  static List<Transaction> recentTransactions(
      int howManyRecent, List<Transaction> transactions) {
    DateTime weekDayInitial = _getWeekDayInitial(howManyRecent);
    return transactions
        .where((transaction) => transaction.date.isAfter(weekDayInitial))
        .toList();
  }

  static DateTime _getWeekDayInitial(int manyLastRecentTransactions) {
    final DateTime today = DateTime.now();
    final DateTime weekDayInitial =
        today.subtract(Duration(days: manyLastRecentTransactions));
    return weekDayInitial;
  }
}
