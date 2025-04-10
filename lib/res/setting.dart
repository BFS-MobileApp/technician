import 'package:flutter/cupertino.dart';

class Setting {
  String appName = "Woosh";
  double? defaultTax;
  String? defaultCurrency;
  bool currencyRight = false;
  bool payPalEnabled = true;
  bool stripeEnabled = true;
  String? mainColor;
  String? mainDarkColor;
  String? secondColor;
  String? secondDarkColor;
  String? accentColor;
  String? accentDarkColor;
  String? scaffoldDarkColor;
  String? scaffoldColor;
  String? googleMapsKey;
  static ValueNotifier<Locale> mobileLanguage =
      new ValueNotifier(Locale('en', 'ar'));
  String? appVersion;
  bool enableVersion = true;

  Setting();
}
