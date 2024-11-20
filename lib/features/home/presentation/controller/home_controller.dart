import 'package:denomination/config/utility.dart';
import 'package:denomination/core/routes/app_routes.dart';
import 'package:denomination/database/database_service.dart';
import 'package:denomination/features/home/services/home_service.dart';
import 'package:denomination/widgets/custom_btn.dart';
import 'package:number_to_indian_words/number_to_indian_words.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../model/denomination_model.dart';

class HomeController extends GetxController {
  final HomeService homeService;
  final DatabaseService databaseService;

  HomeController({
    required this.homeService,
    required this.databaseService,
  });

  var totalAmount = 0;
  var showExtendedButtons = false;
  final List<DenominationModel> denominations = [
    DenominationModel(value: 2000, controller: TextEditingController()),
    DenominationModel(value: 500, controller: TextEditingController()),
    DenominationModel(value: 200, controller: TextEditingController()),
    DenominationModel(value: 100, controller: TextEditingController()),
    DenominationModel(value: 50, controller: TextEditingController()),
    DenominationModel(value: 20, controller: TextEditingController()),
    DenominationModel(value: 10, controller: TextEditingController()),
    DenominationModel(value: 5, controller: TextEditingController()),
    DenominationModel(value: 2, controller: TextEditingController()),
    DenominationModel(value: 1, controller: TextEditingController()),
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String remark = "";
  String category = "General";
  bool isEditMode = false;
  int? editingEntryId;

  //--Update-Total-Amount---
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

  // Formats number in words
  String formatInWords(int number) {
    if (number == 0) return '';
    return '${NumToWords.convertNumberToIndianWords(number)} only/-';
  }

  // Toggle Floating action button
  void toggleExtendedButtons() {
    showExtendedButtons = !showExtendedButtons;
    update();
  }

  // Toggle False to Floating action button
  void disableExtendedButtons() {
    showExtendedButtons = false;
    update();
    Get.toNamed(AppRoutes.history);
  }

  // Clear all fields data
  void clearAllFields() {
    for (var denomination in denominations) {
      denomination.controller.clear();
    }
    updateTotalAmount();
  }

 // Show dialod for save data 
  void showSaveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Category',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  DropdownButtonFormField<String>(
                    value: category,
                    items: const [
                      DropdownMenuItem(
                        value: 'General',
                        child: Text('General'),
                      ),
                    ],
                    onChanged: (String? value) {
                      category = value ?? "General";
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: 'Enter your remark',
                      labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a remark';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      remark = value ?? "";
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.maxFinite,
                    child: CustomButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          bool confirmed =
                              await Utility.showCustomConfirmationDialog(
                                  context);
                          if (confirmed) {
                            debugPrint("Saving denominations...");
                            await saveDenominations();
                            Get.back();
                            debugPrint("Save completed");
                          }
                        }
                      },
                      text: 'Save',
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Saves the data entry in database.
  Future<void> saveDenominations() async {
    debugPrint('saveDenominations called');
    Map<String, int> currencyCount = {};
    for (var denomination in denominations) {
      int quantity = int.tryParse(denomination.controller.text) ?? 0;
      if (quantity > 0) {
        currencyCount[denomination.value.toString()] = quantity;
      }
    }

    if (currencyCount.isNotEmpty) {
      await databaseService.insertDenomination(
        totalAmount,
        remark,
        category,
        DateTime.now(),
        currencyCount,
      );
    }
    clearAllFields();
  }
}
