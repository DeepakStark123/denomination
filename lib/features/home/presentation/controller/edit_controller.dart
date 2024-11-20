import 'package:denomination/database/database_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/history_model.dart';
import '../model/denomination_model.dart';

class EditController extends GetxController {
  final DatabaseService databaseService = Get.find<DatabaseService>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final HistoryModel editingEntry;

  String category;
  String remark;
  int totalAmount;
  int editingEntryId;
  List<DenominationModel> denominations;

  EditController(this.editingEntry)
      : category = editingEntry.category,
        remark = editingEntry.remark,
        totalAmount = editingEntry.amount,
        editingEntryId = editingEntry.id,
        denominations = [
          DenominationModel(
              value: 2000,
              controller: TextEditingController(
                  text: editingEntry.currencyCount['2000']?.toString() ?? '')),
          DenominationModel(
              value: 500,
              controller: TextEditingController(
                  text: editingEntry.currencyCount['500']?.toString() ?? '')),
          DenominationModel(
              value: 200,
              controller: TextEditingController(
                  text: editingEntry.currencyCount['200']?.toString() ?? '')),
          DenominationModel(
              value: 100,
              controller: TextEditingController(
                  text: editingEntry.currencyCount['100']?.toString() ?? '')),
          DenominationModel(
              value: 50,
              controller: TextEditingController(
                  text: editingEntry.currencyCount['50']?.toString() ?? '')),
          DenominationModel(
              value: 20,
              controller: TextEditingController(
                  text: editingEntry.currencyCount['20']?.toString() ?? '')),
          DenominationModel(
              value: 10,
              controller: TextEditingController(
                  text: editingEntry.currencyCount['10']?.toString() ?? '')),
          DenominationModel(
              value: 5,
              controller: TextEditingController(
                  text: editingEntry.currencyCount['5']?.toString() ?? '')),
          DenominationModel(
              value: 2,
              controller: TextEditingController(
                  text: editingEntry.currencyCount['2']?.toString() ?? '')),
          DenominationModel(
              value: 1,
              controller: TextEditingController(
                  text: editingEntry.currencyCount['1']?.toString() ?? '')),
        ];

  // Updates the category value
  void updateCategory(String newCategory) {
    category = newCategory;
    update();
  }

  // Updates the remark value
  void updateRemark(String newRemark) {
    remark = newRemark;
    update();
  }

// Calculates and updates the total amount
  void updateTotalAmount() {
    totalAmount = denominations
        .map(
            (denom) => denom.value * (int.tryParse(denom.controller.text) ?? 0))
        .reduce((value, element) => value + element);
    update();
  }

 // Formats number 
  String formatNumber(int number) {
    final formatter = NumberFormat('#,##0', 'en_IN');
    return formatter.format(number);
  }

 /// Saves the edited entry by updating the database.
  Future<void> saveEditedEntry() async {
    Map<String, int> currencyCount = {};
    for (var denomination in denominations) {
      int quantity = int.tryParse(denomination.controller.text) ?? 0;
      if (quantity > 0) {
        currencyCount[denomination.value.toString()] = quantity;
      }
    }

    await databaseService.updateDenomination(
      editingEntryId,
      totalAmount,
      remark,
      category,
      DateTime.now(),
      currencyCount,
    );
    update();
  }
}
