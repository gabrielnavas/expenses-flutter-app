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
}
