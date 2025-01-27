
import 'package:flutter/material.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';

class LogoItem extends StatelessWidget {
  const LogoItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.asset(
          AssetsManager.logo,
          width: 150.w,
          height: 150.h,
        ));
  }
}
