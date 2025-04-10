import 'package:flutter/material.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/widgets/text_widget.dart';

class ClaimDetailsIdWidget extends StatelessWidget {

  String id;
  ClaimDetailsIdWidget({super.key , required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w , vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsetsDirectional.only(start: 3.w , bottom: 5.h),
            width: 3.5.w,
            height: 16.h,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: AppColors.mainColor),
          ),
          SizedBox(width: 5.w,),
          TextWidget(text: id, fontSize: 16.fSize , fontWeight: FontWeight.w600, fontColor: Theme.of(context).textTheme.bodySmall!.color,),
        ],
      ),
    );
  }
}
