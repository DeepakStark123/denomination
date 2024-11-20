import 'package:denomination/config/colors.dart';
import 'package:denomination/core/textTheme/text_theme.dart';
import 'package:flutter/material.dart';

class Utility {
  static bool addMoreSwitch = false;

//----Display-Custom-Confirmation-Dialog------
  static Future<bool> showCustomConfirmationDialog(BuildContext context,
      {String message = "Are you sure?"}) async {
    return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title:  Text(
                'Confirmation',
                style:
                    customTextStyle(fontWeight: FontWeight.bold, color: AppColors.primarymaincolor,fontSize: 14),
              ),
              content: Text(message),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child:  Text(
                    'NO',
                    style: customTextStyle(color: AppColors.primarymaincolor,fontSize: 14),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child:  Text(
                    'Yes',
                    style: customTextStyle(color: AppColors.primarymaincolor,fontSize: 14),
                  ),
                ),
              ],
            );
          },
        ) ??
        false;
  }
}
