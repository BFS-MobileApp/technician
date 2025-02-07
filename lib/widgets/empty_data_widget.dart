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
          margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
          alignment: alignmentWidget.returnAlignment(),
          child: ClaimizerAppBar(title: ''),
        ),
        const Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Icon(
                Icons.warning_amber_rounded,
                size: 150.adaptSize,
                color: AppColors.mainColor,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 12.w),
              child: Text(
                'noData'.tr,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.fSize),
              ),
            ),
          ],
        ),
        const Spacer(),
      ],
    );
  }
}
