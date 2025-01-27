import 'dart:ui';


class HexToColor extends Color {
  static int _convertHexToColor(String hexColor) {
    return int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000;
  }

  HexToColor(final String hexColor) : super(_convertHexToColor(hexColor));
}