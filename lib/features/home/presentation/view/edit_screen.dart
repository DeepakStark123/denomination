// ignore_for_file: unused_local_variable
import 'package:denomination/config/colors.dart';
import 'package:denomination/config/utility.dart';
import 'package:denomination/core/textTheme/text_theme.dart';
import 'package:denomination/widgets/custom_btn.dart';
import 'package:denomination/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import '../controller/edit_controller.dart';
import '../model/history_model.dart';
import 'package:get/get.dart';

class EditScreen extends StatelessWidget {
  final HistoryModel editingEntry;
  const EditScreen({required this.editingEntry, super.key});

  @override
  Widget build(BuildContext context) {
    final editController = Get.put(EditController(editingEntry));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Entry',
          style: customTextStyle(fontSize: 18, color: AppColors.whiteColor),
        ),
      ),
      body: GetBuilder<EditController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                        Text(
                          'Total Amount: ₹ ${controller.formatNumber(controller.totalAmount)}',
                          style: customTextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                     const SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      children: [
                        const SizedBox(height: 16),
                        ...controller.denominations.map((denomination) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    '₹ ${denomination.value}',
                                    style: customTextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: CustomTextField(
                                          controller: denomination.controller,
                                          keyboardType: TextInputType.number,
                                          onChanged: (_) {
                                            controller.updateTotalAmount();
                                          },
                                          decoration: InputDecoration(
                                            border: const OutlineInputBorder(),
                                            suffixIcon: denomination
                                                    .controller.text.isNotEmpty
                                                ? IconButton(
                                                    icon: const Icon(Icons.clear),
                                                    onPressed: () {
                                                      denomination.controller.clear();
                                                      controller.updateTotalAmount();
                                                    },
                                                  )
                                                : null,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          '= ₹ ${controller.formatNumber(denomination.value * (int.tryParse(denomination.controller.text) ?? 0))}',
                                          style: customTextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                     
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
                            controller.updateRemark(value ?? "");
                          },
                          initialValue: controller.remark,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.maxFinite,
                          child: CustomButton(
                            onPressed: () async {
                              if (controller.formKey.currentState!.validate()) {
                                controller.formKey.currentState!.save();
                                bool confirmed =
                                    await Utility.showCustomConfirmationDialog(
                                        context);
                                if (confirmed) {
                                  debugPrint("Saving edited entry...");
                                  await controller.saveEditedEntry();
                                  Get.back(result: true);
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
