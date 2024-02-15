class ChartRecentItem {
  String label;
  double value;
  double percentage = 0.00;
  double restPercentage = 0.00;

  ChartRecentItem.withoutPercentage({
    required this.label,
    required this.value,
  });
}
