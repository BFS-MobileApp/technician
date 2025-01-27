import 'package:flutter/material.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/widgets/text_widget.dart';

class ClaimSummaryWidget extends StatelessWidget {

  String name;
  String value;
  ClaimSummaryWidget({super.key , required this.name , required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w , vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(text: name, fontSize: 16.fSize , fontWeight: FontWeight.w600,fontColor: const Color(0xFF2E435C),),
          SizedBox(height: 10.h,),
          TextWidget(text: value, fontSize: 14.fSize , fontWeight: FontWeight.w400,fontColor: AppColors.black,maxLine: 3,),
        ],
      ),
    );
  }
}
