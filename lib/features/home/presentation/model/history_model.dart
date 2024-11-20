class HistoryModel {
  final int id;
  final int amount;
  final String remark;
  final DateTime date;
  final String category;
  final Map<String, int> currencyCount;

  HistoryModel({
    required this.id,
    required this.amount,
    required this.remark,
    required this.date,
    required this.category,
    required this.currencyCount,
  });
}