import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:technician/core/utils/size_utils.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_strings.dart';

class DarkStyle {
  static ThemeData darkTheme(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryColor,
      hintColor: AppColors.grey,
      fontFamily: AppStrings.fontName,
      scaffoldBackgroundColor: AppColors.black, // True dark mode background

      // 🔹 AppBar Theme
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.grey[900], // Dark grey for contrast
        elevation: 0,
        titleTextStyle: GoogleFonts.montserrat(
          fontSize: screenWidth * 0.045,
          fontWeight: FontWeight.bold,
          color: AppColors.whiteColor,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.whiteColor, // White icons for visibility
        ),
      ),

      // 🔹 Text Theme
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.montserrat(
          fontSize: screenWidth * 0.06,
          fontWeight: FontWeight.bold,
          color: AppColors.whiteColor, // High contrast text
        ),
        bodyMedium: GoogleFonts.montserrat(
          fontSize: screenWidth * 0.045,
          fontWeight: FontWeight.normal,
          color: Colors.grey.shade300, // Soft white for readability
        ),
        bodySmall: GoogleFonts.montserrat(
          fontSize: screenWidth * 0.035,
          color: Colors.grey.shade500, // Lighter grey for subtitles
        ),
        labelLarge: GoogleFonts.montserrat(
          fontSize: screenWidth * 0.04,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryColor, // Accent color for buttons
        ),
        titleLarge: GoogleFonts.montserrat(
          fontSize: screenWidth * 0.05,
          fontWeight: FontWeight.bold,
          color: AppColors.whiteColor,
        ),
      ),

      // 🔹 Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.whiteColor,
          textStyle: GoogleFonts.montserrat(
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // 🔹 Bottom Navigation Bar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey[900],
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.grey.shade600,
      ),

      // 🔹 Card Theme (Dark Background for Cards)
      cardTheme: CardThemeData(
        color: Colors.grey[850], // Dark grey for a clean look
        shadowColor: Colors.black26,
        elevation: 2,
      ),

      // 🔹 Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.grey[850], // Dark background for popups
        titleTextStyle: GoogleFonts.montserrat(
          fontSize: screenWidth * 0.05,
          fontWeight: FontWeight.bold,
          color: AppColors.whiteColor,
        ),
        contentTextStyle: GoogleFonts.montserrat(
          fontSize: screenWidth * 0.04,
          color: Colors.grey.shade300,
        ),
      ),

      // 🔹 Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(AppColors.primaryColor),
        checkColor: MaterialStateProperty.all(AppColors.whiteColor),
      ),

      // 🔹 Icon Theme
      iconTheme: const IconThemeData(
        color: AppColors.whiteColor,
      ),
    );
  }
}
