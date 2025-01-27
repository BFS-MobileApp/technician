import 'package:flutter/material.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/size_utils.dart';

class ButtonItem extends StatelessWidget {

  final String title;

  final VoidCallback onTap;

  final Color buttonColor;
  const ButtonItem({super.key , required this.title , required this.onTap , required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      onPressed: onTap,
      child: Padding(
        padding: EdgeInsets.only(top: 2.h),
        child: Text(title , style: const TextStyle(color: AppColors.whiteColor),),
      ),
    );
  }
}
