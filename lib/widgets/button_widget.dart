import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/size_utils.dart';

class ButtonWidget extends StatelessWidget {
  final double width;
  final double height;
  final VoidCallback onTap;
  final String name;

  final Color btColor;

  final int fontSize;

  final fontColor;

  final FontWeight fontWeight;

  const ButtonWidget({
    super.key,
    required this.width,
    required this.height,
    required this.onTap,
    required this.name,
    this.fontSize = 16,
    this.fontColor = AppColors.whiteColor,
    this.fontWeight = FontWeight.bold,
    this.btColor = AppColors.primaryColor
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // <-- Radius
        ),
        minimumSize: Size(width.w, height.h),
        backgroundColor: btColor,
        textStyle: const TextStyle(color: AppColors.whiteColor,
        ),
      ),
      onPressed: onTap,
      child: Text(
        name,
        style: TextStyle(color: fontColor , fontSize: fontSize.fSize , fontWeight: fontWeight),
      ),
    );
  }
}