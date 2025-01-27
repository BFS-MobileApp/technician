import 'package:flutter/material.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:get/get.dart';
import 'package:technician/widgets/aligment_widget.dart';
import 'package:technician/widgets/app_bar_widget.dart';

import '../core/utils/app_colors.dart';

class EmptyDataWidget extends StatelessWidget {

  AlignmentWidget alignmentWidget = AlignmentWidget();
  EmptyDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 20.h , horizontal: 10.w),
          alignment: alignmentWidget.returnAlignment(),
          child: ClaimizerAppBar(title: ''),
        ),
        const Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetsManager.noDataImage, width: 80.w, height: 80.h),
            Text(
              'noData'.tr,
              style: TextStyle(
                fontSize: 20.fSize,
                color: AppColors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const Spacer(),
      ],
    );

  }
}
