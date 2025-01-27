import 'package:flutter/cupertino.dart';

abstract class SplashLocalDataSource{

  Future<void> initializeSettings(BuildContext context);

  void moveToHomeScreen(BuildContext context);

  void moveToLoginScreen(BuildContext context);
}