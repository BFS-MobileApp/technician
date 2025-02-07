import 'dart:ui';

import 'package:get/get.dart';
import 'package:technician/config/PrefHelper/helper.dart';
import 'package:technician/config/PrefHelper/prefs.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/feature/settings/data/data_sources/settings_local_data_source.dart';
import 'package:technician/feature/settings/domain/entities/settings_user_info.dart';

class SettingsLocalDataSourceImpl extends SettingsLocalDataSource{


  @override
  Future<SettingsUserInfo> getUserInfo() {
    String name = Prefs.getString(AppStrings.userName);
    String email = Prefs.getString(AppStrings.email);
    String image = Prefs.getString(AppStrings.image);
    SettingsUserInfo userInfo = SettingsUserInfo(name: name, email: email, image: image);
    return Future.value(userInfo);
  }

  @override
  Future<void> changeLanguage() async{

    final currentLocal = Get.locale;
    if (currentLocal!.countryCode == 'AR') {
      var locale = const Locale('en', 'US');
      Get.updateLocale(locale);
      Helper.setDefaultLang(AppStrings.enCountryCode);
      Prefs.setString(AppStrings.local, AppStrings.enCountryCode);
    } else {
      var locale = const Locale('ar', 'AR');
      Get.updateLocale(locale);
      Helper.setDefaultLang(AppStrings.arCountryCode);
      Prefs.setString(AppStrings.local, AppStrings.arCountryCode);

    }
  }
}