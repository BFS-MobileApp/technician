import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/widgets/app_headline_widget.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      child: Card(
        elevation: 0,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.h),
          child: AppHeadline(title: 'addNewClaim'.tr,),
        ),
      ),
    );
  }
}
