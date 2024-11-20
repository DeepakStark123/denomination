import 'package:denomination/config/colors.dart';
import 'package:denomination/core/textTheme/text_theme.dart';
import 'package:flutter/material.dart';

class EmptyDataWidget extends StatelessWidget {
  final String message;
  const EmptyDataWidget({super.key, this.message = 'No Records Found'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: customTextStyle(
          fontSize: 14,
          color: AppColors.blackColor,
        ),
      ),
    );
  }
}
