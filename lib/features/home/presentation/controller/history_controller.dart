import 'package:denomination/database/database_constant.dart';
import 'package:denomination/features/home/presentation/model/history_model.dart';
import 'package:denomination/database/database_service.dart';
import 'package:denomination/features/home/services/home_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:number_to_indian_words/number_to_indian_words.dart';
import 'package:share_plus/share_plus.dart';

class HistoryController extends GetxController {
  final DatabaseService databaseService;
  final HomeService homeService;
  HistoryController({required this.databaseService, required this.homeService});

  var history = <HistoryModel>[];
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  // Sets the loading state and updates the UI.
  void setLoading(bool val) {
    isLoading = val;
    update();
  }

  // Loads the history data from the database.
  void loadHistory() async {
    setLoading(true);
    final historyData = await databaseService.getDenominations();

    // Convert the fetched data to HistoryModel
    history = historyData
        .map((entry) => HistoryModel(
              id: entry[DatabaseConstants.columnId],
              amount: entry[DatabaseConstants.columnTotal],
              remark: entry[DatabaseConstants.columnRemark],
              date: DateTime.parse(entry[DatabaseConstants.columnDate]),
              category: entry[DatabaseConstants.columnCategory],
              currencyCount: Map<String, int>.from(_convertStringToMap(
                  entry[DatabaseConstants.columnCurrencyCount])),
            ))
        .toList();

    setLoading(false);
    update();
  }

  // Converts a currency count string to Map<String, int>.
  Map<String, int> _convertStringToMap(String currencyCountStr) {
    if (currencyCountStr.isEmpty) {
      return {};
    }

    String trimmedStr =
        currencyCountStr.substring(1, currencyCountStr.length - 1);
    List<String> keyValuePairs = trimmedStr.split(', ');

    Map<String, int> result = {};
    for (String pair in keyValuePairs) {
      List<String> keyValue = pair.split(': ');
      if (keyValue.length == 2) {
        result[keyValue[0]] = int.tryParse(keyValue[1]) ?? 0;
      }
    }
    return result;
  }

  // Deletes a history entry by its index and ID.
  void deleteHistory({required int index, required int id}) async {
    await databaseService.deleteDenominationById(id);
    history.removeAt(index);
    update();
  }

  // Shares the details of a given history entry using the Share plugin.
  void shareHistory(HistoryModel entry) {
    StringBuffer summaryBuffer = StringBuffer();
    summaryBuffer.writeln("Denomination");
    summaryBuffer.writeln("Category: ${entry.category}");
    summaryBuffer.writeln("Remark: ${entry.remark}");
    summaryBuffer.writeln(
        "Date: ${DateFormat('dd-MMM-yyyy hh:mm a').format(entry.date)}");
    summaryBuffer.writeln("-------------------------------------");
    summaryBuffer.writeln("Rupee x Counts = Total");

    for (var currency in entry.currencyCount.entries) {
      summaryBuffer.writeln(
          "₹ ${currency.key} x ${currency.value} = ₹ ${int.parse(currency.key) * currency.value}");
    }
    summaryBuffer.writeln("-------------------------------------");
    summaryBuffer.writeln(
        "Total Counts: ${entry.currencyCount.values.fold(0, (sum, count) => sum + count)}");
    summaryBuffer.writeln(
        "Grand Total Amount: ₹ ${NumberFormat('#,##0', 'en_IN').format(entry.amount)}");
    summaryBuffer.writeln(
        "${NumToWords.convertNumberToIndianWords(entry.amount)} only/-");
    // Shares the complete summary as a string.
    Share.share(summaryBuffer.toString());
  }
}
