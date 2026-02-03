import 'package:intl/intl.dart';
import 'package:technician/config/PrefHelper/prefs.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/app_consts.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:technician/core/utils/assets_manager.dart';


class Helper{

  static String getCurrentLocal(){
    String local = AppStrings.enCountryCode;
    final currentLocal = Get.locale;
    local = currentLocal!.countryCode!;
    if(local == 'US'){
      AppStrings.appLocal = 'en';
    } else {
      AppStrings.appLocal = 'ar';
    }
    return local;
  }

  static String convertDateTimeToDate(DateTime date){
    String formattedDate = DateFormat('dd-MM-yyyy').format(date);
    return formattedDate;
  }

  static setDefaultLang(String lang) async => Prefs.setString(AppStrings.local, lang);

  static getDefaultLanguage() async{
    if(Prefs.isContain(AppStrings.local)){
      if(Prefs.getString(AppStrings.local) == AppStrings.enCountryCode){
        var locale = const Locale('en', 'US');
        Get.updateLocale(locale);
        return;
      }
      var locale = const Locale('ar', 'AR');
      Get.updateLocale(locale);
    }
  }

  static setPermissionRoles(List<String> permissions) {
    //if (permissions.contains(AppStrings.createClaims)) AppConst.createClaims = true;
    if (permissions.contains(AppStrings.startEndClaimWork)) AppConst.startEndClaimWork = true;
    if (permissions.contains(AppStrings.deleteClaimRepliesAndUpdates)) AppConst.deleteClaimRepliesAndUpdates = true;
    if (permissions.contains(AppStrings.readClaims)) AppConst.readClaims = true;
    if (permissions.contains(AppStrings.addClaimSignature)) AppConst.addClaimSignature = true;
    if (permissions.contains(AppStrings.updateClaims)) AppConst.updateClaims = true;
    if (permissions.contains(AppStrings.viewUpdates)) AppConst.viewUpdates = true;
    if (permissions.contains(AppStrings.viewClaims)) AppConst.viewClaims = true;
    if (permissions.contains(AppStrings.addClaimUpdates)) AppConst.addClaimUpdates = true;
    if (permissions.contains(AppStrings.updateClaimPriority)) AppConst.updateClaimPriority = true;
    if (permissions.contains(AppStrings.submitButton)) AppConst.submitButton = true;
    if (permissions.contains(AppStrings.submitNewButton)) AppConst.submitNewButton = true;
    if (permissions.contains(AppStrings.submitAssignedButton)) AppConst.submitAssignedButton = true;
    if (permissions.contains(AppStrings.submitStartedButton)) AppConst.submitStartedButton = true;
    if (permissions.contains(AppStrings.submitDoneButton)) AppConst.submitDoneButton = true;
    if (permissions.contains(AppStrings.submitClosedButton)) AppConst.submitClosedButton = true;
    if (permissions.contains(AppStrings.submitCancelledButton)) AppConst.submitCancelledButton = true;
    if (permissions.contains(AppStrings.acceptClaims)) AppConst.acceptClaims = true;
    if (permissions.contains(AppStrings.updateClaimStatus)) AppConst.updateClaimStatus = true;
    if (permissions.contains(AppStrings.technician)) AppConst.technician = true;
    if (permissions.contains(AppStrings.assignClaims)) AppConst.assignClaims = true;
    if (permissions.contains(AppStrings.reassignClaims)) AppConst.reassignClaims = true;
    if (permissions.contains(AppStrings.acceptClaim)) AppConst.acceptClaim = true;
  }

  static String returnScreenAppBarName(int index){
    switch (index){
      case 0:
        return 'allClaims'.tr;
      case 1:
        return 'newClaims'.tr;
      case 2:
        return 'assignedClaims'.tr;
      case 3:
        return 'startedClaims'.tr;
      case 4:
        return 'completedClaims'.tr;
      case 5:
        return 'cancelledClaims'.tr;
      case 6:
        return 'closedClaims'.tr;
      default:
        return '';
    }
  }

  static String convertSecondsToDate(String selectedDate) {
    DateTime dateTime = DateTime.parse(selectedDate);
    String formattedDate = DateFormat('yyyy-MM-dd hh:mm a').format(dateTime);
    return formattedDate;
  }


  static String extractDate(String dateTime) {
    if(dateTime == ''){
      return '-';
    }
    return dateTime.split(' ')[0];
  }

  static String extractTime(String dateTime) {
    if(dateTime == ''){
      return '-';
    }
    String time = dateTime.split(' ')[1];
    return time.substring(0, 5);
  }

  static String calculateDuration(String startOn, String endOn) {
    if(startOn == '' || endOn == ''){
      return '${0}D ${0}H ${0}M';
    }
    DateTime start = DateTime.parse(startOn);
    DateTime end = DateTime.parse(endOn);

    Duration duration = end.difference(start);

    int days = duration.inDays;
    int hours = duration.inHours % 24;
    int minutes = duration.inMinutes % 60;

    // Formatting the result
    String result = '${days}d ${hours}h ${minutes}m';
    return result;
  }

  static String formatDateTime(String dateTimeString) {
    DateTime parsedDateTime = DateTime.parse(dateTimeString);
    String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDateTime);
    String formattedTime = DateFormat('h:mm a').format(parsedDateTime);
    return '$formattedDate - $formattedTime';
  }

  static String removeSeconds(String dateTimeString) {
    DateTime parsedDateTime = DateTime.parse(dateTimeString);
    String formattedDate = DateFormat('yyyy-MM-dd h:mm').format(parsedDateTime);
    return formattedDate;
  }

  static String assignFormatDateTime(String dateTimeString) {
    DateTime parsedDateTime = DateTime.parse(dateTimeString);
    String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDateTime);
    String formattedTime = DateFormat('hh:mm:ss a').format(parsedDateTime);
    return '$formattedDate $formattedTime';
  }

  static Color getLogColor(String status){
    switch (status){
      case 'New':
       return Colors.yellow;
      case 'Assigned':
        return Colors.blue;
      case 'Started':
        return Colors.cyan;
      case 'Completed':
        return Colors.green;
      case 'Closed':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      case 'جديد':
        return Colors.yellow;
      case 'تم اختيار فني':
        return Colors.blue;
      case 'بدأت':
        return Colors.cyan;
      case 'مكتمل':
        return Colors.green;
      case 'مغلق':
        return Colors.green;
      case 'ملغي':
        return Colors.red;
      default:
        return AppColors.primaryColor;
    }
  }

  static Color getPriorityColor(String status){
    switch (status){
      case 'Urgent':
        return const Color(0xFFC14432);
      case 'High':
        return const Color(0xFFDD8B04);
      case 'Medium':
        return const Color(0xFF0A562E);
      case 'Normal':
        return const Color(0xFF679C0D);
      case 'Low':
        return const Color(0xFF1295A8);
      case 'عاجل':
        return const Color(0xFFC14432);
      case 'مرتفع':
        return const Color(0xFFDD8B04);
      case 'متوسط':
        return const Color(0xFF0A562E);
      case 'عادي':
        return const Color(0xFF679C0D);
      case 'منخفض':
        return const Color(0xFF1295A8);
      default:
        return AppColors.primaryColor;
    }
  }

  static String getLogImage(String status){
    switch (status){
      case 'New':
        return AssetsManager.newClaims;
      case 'Assigned':
        return AssetsManager.assignedClaims;
      case 'Started':
        return AssetsManager.startedClaims;
      case 'Completed':
        return AssetsManager.completedClaims;
      case 'Closed':
        return AssetsManager.closedClaims;
      case 'Cancelled':
        return AssetsManager.canceledClaims;
      case 'جديد':
        return AssetsManager.newClaims;
      case 'تم اختيار فني':
        return AssetsManager.assignedClaims;
      case 'بدأت':
        return AssetsManager.startedClaims;
      case 'مكتمل':
        return AssetsManager.completedClaims;
      case 'مغلق':
        return AssetsManager.closedClaims;
      case 'ملغي':
        return AssetsManager.canceledClaims;
      default:
        return '';
    }
  }

  static void setStatusColors(String color , String status){
    switch (status){
      case 'new':
        AppConst.newClaimsColor = color;
      case 'assigned':
        AppConst.assignedClaimsColor = color;
      case 'started':
        AppConst.startedClaimsColor = color;
      case 'completed':
        AppConst.completedClaimsColor = color;
      case 'closed':
        AppConst.closedClaimsColor = color;
      case 'cancelled':
        AppConst.cancelledClaimsColor = color;
    }
  }

  static Color hexToColor(String hexString) {
    hexString = hexString.replaceAll('#', '');

    // Handle shorthand hex color (#ddd -> #dddddd)
    if (hexString.length == 3) {
      hexString = hexString.split('').map((char) => '$char$char').join().substring(0,6);
      hexString = 'FF$hexString';
      print(hexString);
    }
    if (hexString.length == 6) {
      hexString = 'FF$hexString';
    }

    return Color(int.parse(hexString, radix: 16));
  }


  static Color returnScreenStatusColor(String status){
    if(Helper.getCurrentLocal() == 'AR'){
      switch (status){
        case 'تم اختيار فني':
          return hexToColor(AppConst.assignedClaimsColor);
        case 'جديد':
          return hexToColor(AppConst.newClaimsColor);
        case 'ملغي':
          return hexToColor(AppConst.cancelledClaimsColor);
        case 'مكتمل':
          return hexToColor(AppConst.completedClaimsColor);
        case 'بدأت':
          return hexToColor(AppConst.startedClaimsColor);
        case 'مغلق':
          return hexToColor(AppConst.closedClaimsColor);
        default:
          return hexToColor('#ff44A4F2');
      }
    } else {
      switch (status){
        case 'Assigned':
          return hexToColor(AppConst.assignedClaimsColor);
        case 'New':
          return hexToColor(AppConst.newClaimsColor);
        case 'Cancelled':
          return hexToColor(AppConst.cancelledClaimsColor);
        case 'Completed':
          return hexToColor(AppConst.completedClaimsColor);
        case 'Started':
          return hexToColor(AppConst.startedClaimsColor);
        case 'Closed':
          return hexToColor(AppConst.closedClaimsColor);
        default:
          return hexToColor('#ff44A4F2');
      }
    }
  }

   static String getStatus(String status){
    switch (status) {
      case 'تم اختيار فني':
        return "assigned".tr;
      case 'جديد':
        return "new".tr;
      case 'ملغي':
        return "cancelled".tr;
      case 'مكتمل':
        return "complete".tr;
      case 'بدأت':
        return "started".tr;
      case 'مغلق':
        return "closed".tr;
      case 'New':
        return 'new'.tr;
      default:
        return '';
    }
  }

  static String getPriority(String priority){
    switch (priority) {
      case 'متوسط':
        return "medium".tr;
      default:
        return '';
    }
  }

  static String assignTo(String value){
    switch(value){
      case 'لم يتم التكليف':
        return '-';
      default:
        return value;
    }
  }

  static String getAvailableTime(String time){
    switch (time) {
      case 'أي وقت':
        return "anyTime".tr;
      default:
        return time;
    }
  }
}