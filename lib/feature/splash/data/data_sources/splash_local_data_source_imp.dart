
import 'package:flutter/cupertino.dart';
import 'package:technician/config/PrefHelper/prefs.dart';
import 'package:technician/config/routes/app_routes.dart';
import 'package:technician/core/utils/app_strings.dart';

import 'splash_local_data_source.dart';

class SplashLocalDataSourceImplementation extends SplashLocalDataSource{

  @override
  Future<void> initializeSettings(BuildContext context) async{
    print('here');
    if(Prefs.getBool(AppStrings.login)){
      print('true');
    } else {
      print('true');
    }
    Prefs.getBool(AppStrings.login) ? moveToHomeScreen(context) : moveToLoginScreen(context);
  }

  @override
  void moveToHomeScreen(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.login, (Route<dynamic> route) => false);
    });
  }

  @override
  void moveToLoginScreen(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.login, (Route<dynamic> route) => false);
    });
  }
}