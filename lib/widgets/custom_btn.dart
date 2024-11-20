import 'package:denomination/config/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? backgroundColor;
  final Color textColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.primarymaincolor,
    this.textColor = AppColors.whiteColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 16),
      ),
    );
  }
}

class CustomButtonIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData icon;
  final Color? backgroundColor;
  final Color textColor;
  final Color iconColor;

  const CustomButtonIcon({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.backgroundColor = AppColors.primarymaincolor,
    this.textColor = AppColors.whiteColor,
    this.iconColor = AppColors.whiteColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      icon: Icon(icon, color: iconColor),
      label: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 16),
      ),
    );
  }
}
