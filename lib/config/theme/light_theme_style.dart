import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:technician/core/utils/size_utils.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_strings.dart';
import '../../res/colors.dart';
import '../../res/setting.dart';

class LightStyles {
  static ThemeData lightTheme(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

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
}
