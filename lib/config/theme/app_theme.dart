import 'package:flutter/material.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/core/utils/size_utils.dart';

import '../../core/utils/app_colors.dart';

ThemeData appTheme(){
  return ThemeData(
    // main color in app
      primaryColor: AppColors.primaryColor,
      hintColor: AppColors.grey,
      fontFamily: AppStrings.fontName,
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 16.fSize , fontWeight: FontWeight.bold),
          backgroundColor: AppColors.primaryColor,
          iconTheme: const IconThemeData(
          color: AppColors.whiteColor, // Change back arrow color here for second page
        ),
      ),
      scaffoldBackgroundColor: AppColors.whiteColor,
      textTheme: TextTheme(
          bodyMedium: TextStyle(height: 1.3 , fontSize: 22.fSize , color: AppColors.black , fontWeight: FontWeight.bold),
          labelLarge: TextStyle(
              fontSize: 16.fSize,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w500
          )
      )
  );
}