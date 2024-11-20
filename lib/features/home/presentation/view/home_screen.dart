import 'package:denomination/core/textTheme/text_theme.dart';
import 'package:denomination/widgets/custom_textfield.dart';
import 'package:denomination/config/app_constants.dart';
import 'package:denomination/config/app_images.dart';
import 'package:denomination/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) {
        debugPrint('build');

        return Scaffold(
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (homeController.showExtendedButtons) ...[
                const SizedBox(height: 10),
                FloatingActionButton.extended(
                  onPressed: () {
                    homeController.showSaveDialog(context);
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('Save'),
                ),
                const SizedBox(height: 10),
                FloatingActionButton.extended(
                  onPressed: () {
                    homeController.clearAllFields();
                  },
                  icon: const Icon(Icons.refresh),
                  label: Text(
                    'Clear',
                    style: customTextStyle(
                        fontSize: 14, color: AppColors.whiteColor),
                  ),
                ),
                const SizedBox(height: 10),
              ],
              FloatingActionButton(
                onPressed: () {
                  homeController.toggleExtendedButtons();
                },
                child: const Icon(Icons.flash_on),
              ),
            ],
          ),
          body: Column(
            children: [
              Container(
                height: 170,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.currencyBannerImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.all(homeController.totalAmount == 0 ? 16 : 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          PopupMenuButton<String>(
                            onSelected: (String value) {
                              if (value == 'History') {
                                 homeController.disableExtendedButtons();
                              }
                            },
                            icon: const Icon(
                              Icons.more_vert,
                              color: AppColors.whiteColor,
                            ),
                            itemBuilder: (BuildContext context) => [
                              PopupMenuItem<String>(
                                value: 'History',
                                child: ListTile(
                                  leading: const Icon(Icons.history),
                                  title: Text(
                                    'History',
                                    style: customTextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            homeController.totalAmount == 0
                                ? AppConstants.appName
                                : 'Total Amount',
                            style: TextStyle(
                              fontSize:
                                  homeController.totalAmount == 0 ? 30 : 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          if (homeController.totalAmount != 0) ...[
                            SizedBox(
                              height: 35,
                              width: double.maxFinite,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Text(
                                      'INR ${homeController.formatNumber(homeController.totalAmount)}',
                                      style: customTextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                              width: double.maxFinite,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Text(
                                      homeController.formatInWords(
                                          homeController.totalAmount),
                                      style: customTextStyle(
                                        fontSize: 18,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: homeController.denominations.length,
                  itemBuilder: (context, index) {
                    final noteValue = homeController.denominations[index].value;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              'INR $noteValue',
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
                                    controller: homeController
                                        .denominations[index].controller,
                                    keyboardType: TextInputType.number,
                                    onChanged: (_) {
                                      homeController.updateTotalAmount();
                                    },
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      suffixIcon: homeController
                                              .denominations[index]
                                              .controller
                                              .text
                                              .isNotEmpty
                                          ? IconButton(
                                              icon: const Icon(Icons.clear),
                                              onPressed: () {
                                                homeController
                                                    .denominations[index]
                                                    .controller
                                                    .clear();
                                                homeController
                                                    .updateTotalAmount();
                                              },
                                            )
                                          : null,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    '= INR ${homeController.formatNumber(noteValue * (int.tryParse(homeController.denominations[index].controller.text) ?? 0))}',
                                    style: customTextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
