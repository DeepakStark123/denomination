import 'package:denomination/config/colors.dart';
import 'package:denomination/core/textTheme/text_theme.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final int maxLines;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final InputDecoration? decoration;

  const CustomTextField({
    super.key,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    required this.controller,
    this.validator,
    this.suffixIcon,
    this.onChanged,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      onChanged: onChanged,
      decoration: decoration?? InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.greyColor),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primarymaincolor),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.redColor),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.redColor),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class CustomTextFieldWithMaxHeight extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const CustomTextFieldWithMaxHeight({
    super.key,
    required this.label,
    this.hintText,
    this.keyboardType = TextInputType.text,
    required this.controller,
    this.validator,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: customTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: null,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.greyColor),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primarymaincolor),
              borderRadius: BorderRadius.circular(8),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.redColor),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.redColor),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
