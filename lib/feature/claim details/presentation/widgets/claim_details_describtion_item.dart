import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/widgets/text_widget.dart';

class ClaimDetailsDescriptionItem extends StatelessWidget {

  String itemValue;
  ClaimDetailsDescriptionItem({super.key , required this.itemValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w , vertical: 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(text: 'description'.tr, fontSize: 16.fSize , fontWeight: FontWeight.w600, fontColor: const Color(0xFF2E435C),),
          SizedBox(height: 5.h,),
          Container(
            padding: EdgeInsets.all(8.adaptSize),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                  Radius.circular(5.0) //                 <--- border radius here
              ),
              border: Border.all(
                  color: const Color(0xFFEBEBEB),
                  width: 1.0
              ),
            ),
            child: TextWidget(text: itemValue, fontSize: 16.fSize , maxLine: 8 , fontWeight: FontWeight.w500, fontColor: const Color(0xFF8C8CA1),),
          )
        ],
      ),
    );
  }
}
