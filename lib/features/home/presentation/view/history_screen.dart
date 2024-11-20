import 'package:denomination/config/colors.dart';
import 'package:denomination/config/utility.dart';
import 'package:denomination/core/textTheme/text_theme.dart';
import 'package:denomination/widgets/empty_data.dart';
import 'package:denomination/widgets/loading_widget.dart';
import '../controller/history_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late HistoryController historyController;

  @override
  void initState() {
    super.initState();
    historyController = Get.find<HistoryController>();
    historyController.loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History',
          style: customTextStyle(
            fontSize: 18,
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: GetBuilder<HistoryController>(
        builder: (controller) {
          return controller.isLoading
              ? const LoadingWidget()
              : controller.history.isEmpty
                  ? const EmptyDataWidget()
                  : ListView.builder(
                      itemCount: controller.history.length,
                      itemBuilder: (context, index) {
                        final entry = controller.history[index];
                        return Dismissible(
                          key: ValueKey(entry.date.toString()),
                          background: Container(
                            color: AppColors.redColor,
                            alignment: Alignment.centerLeft,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: const Icon(Icons.delete,
                                color: AppColors.whiteColor),
                          ),
                          secondaryBackground: Container(
                            color: AppColors.greenColor,
                            alignment: Alignment.centerRight,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: const Icon(Icons.edit,
                                color: AppColors.whiteColor),
                          ),
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.endToStart) {
                              // Share the item instead of dismissing
                              historyController.shareHistory(entry);
                              return false; // Do not dismiss
                            } else if (direction ==
                                DismissDirection.startToEnd) {
                              bool shouldDelete =
                                  await Utility.showCustomConfirmationDialog(
                                      context,
                                      message:
                                          'Are you sure you want to delete this entry?');
                              return shouldDelete;
                            }
                            return false;
                          },
                          onDismissed: (direction) {
                            if (direction == DismissDirection.startToEnd) {
                              controller.deleteHistory(
                                  index: index, id: entry.id);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: Card(
                              color: AppColors.primarymaincolor,
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                title: Text(
                                  '₹ ${NumberFormat('#,##0', 'en_IN').format(entry.amount)}',
                                  style: customTextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      entry.category,
                                      style: customTextStyle(
                                        color: AppColors.whiteColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      entry.remark,
                                      style: customTextStyle(
                                        color: AppColors.whiteColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      DateFormat('MMM dd, yyyy hh:mm a')
                                          .format(entry.date),
                                      style: customTextStyle(
                                        color: AppColors.whiteColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: PopupMenuButton(
                                  icon: const Icon(Icons.more_vert,
                                      color: AppColors.whiteColor),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: 'edit',
                                      child: ListTile(
                                        leading: const Icon(Icons.edit),
                                        title: Text(
                                          'Edit',
                                          style: customTextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 'share',
                                      child: ListTile(
                                        leading: const Icon(Icons.share),
                                        title: Text(
                                          'Share',
                                          style: customTextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          historyController.shareHistory(entry);
                                        },
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 'delete',
                                      child: ListTile(
                                        leading: const Icon(Icons.delete),
                                        title: Text(
                                          'Delete',
                                          style: customTextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        onTap: () {
                                          controller.deleteHistory(
                                              index: index, id: entry.id);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
        },
      ),
    );
  }
}
