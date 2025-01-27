import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/widgets/text_widget.dart';

class AccessDeniedWidget extends StatelessWidget {
  const AccessDeniedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AssetsManager.accessDeniedIcon , width: 100.h,height: 100.h,),
          SizedBox(height: 10.h,),
          TextWidget(
            text: 'accessDenied'.tr,
            fontSize: 18.0.fSize,
            fontWeight: FontWeight.w600,
            fontColor: const Color(0xFF031D3C),
          ),
          SizedBox(height: 5.h,),
          TextWidget(
            text: 'youDontHavePermission'.tr,
            maxLine: 2,
            fontSize: 18.0.fSize,
            fontWeight: FontWeight.w500,
            fontColor: const Color(0xFFB0B0B0),
          ),

        ],
      ),
    );
  }
}
