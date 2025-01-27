import 'dart:ui';

class DelayFunction{

  static void delayAfterTime(VoidCallback onTap){
    Future.delayed(const Duration(milliseconds: 500), () {
      onTap;
    });
  }
}