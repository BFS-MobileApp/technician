import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      alignment: Alignment.center,
      child: Lottie.asset(AssetsManager.loadingImage, width: 30.w),
    );
  }
}
