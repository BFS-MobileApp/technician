import 'package:flutter/material.dart';
import 'package:technician/config/PrefHelper/helper.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/widgets/svg_image_widget.dart';
import 'package:technician/widgets/text_widget.dart';

class ClaimDetailsStatusWidget extends StatelessWidget {

  String itemName;
  String itemValue;
  bool isStatus;

  ClaimDetailsStatusWidget({super.key , required this.itemName , required this.isStatus , required this.itemValue});

  String checkStatusImage(){
    switch (itemValue){
      case 'تم اختيار فني':
        return AssetsManager.assignedStatusIcon;
      case 'جديد':
        return AssetsManager.newStatusIcon;
      case 'ملغي':
        return AssetsManager.cancelledStatusIcon;
      case 'مكتمل':
        return AssetsManager.completedStatusIcon;
      case 'بدأت':
        return AssetsManager.startedStatusIcon;
      case 'مغلق':
        return AssetsManager.closedStatusIcon;
      case 'New':
        return AssetsManager.newStatusIcon;
      case 'Completed':
        return AssetsManager.completedStatusIcon;
      case 'Assigned':
        return AssetsManager.assignedStatusIcon;
      case 'Closed':
        return AssetsManager.closedStatusIcon;
      case 'Started':
        return AssetsManager.startedStatusIcon;
      case 'Cancelled':
        return AssetsManager.cancelledStatusIcon;
      default:
        return '';
    }
  }

  String checkPriorityImage(){
    switch (itemValue){
      case 'Low':
        return AssetsManager.lowPriority;
      case 'High':
        return AssetsManager.highPriority;
      case 'Normal':
        return AssetsManager.normalPriority;
      case 'Urgent':
        return AssetsManager.urgentPriority;
      case 'Medium':
        return AssetsManager.mediumPriority;
      case 'منخفض':
        return AssetsManager.lowPriority;
      case 'مرتفع':
        return AssetsManager.highPriority;
      case 'عادي':
        return AssetsManager.normalPriority;
      case 'عاجل':
        return AssetsManager.urgentPriority;
      case 'متوسط':
        return AssetsManager.mediumPriority;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w , vertical: 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(text: itemName, fontSize: 16.fSize , fontWeight: FontWeight.w600, fontColor: const Color(0xFF2E435C),),
          SizedBox(height: 5.h,),
          Row(
            children: [
              isStatus ? SVGImageWidget(image: checkStatusImage(), width: 20.w, height: 20.h) : SVGImageWidget(image: checkPriorityImage(), width: 20.w, height: 20.h) ,
              SizedBox(width: 5.w,),
              isStatus ? TextWidget(text: itemValue, fontSize: 14.fSize , fontWeight: FontWeight.w400, fontColor: AppColors.black,) : TextWidget(text: itemValue, fontSize: 14.fSize , fontWeight: FontWeight.w400, fontColor: Helper.getPriorityColor(itemValue),) ,
            ],
          )
        ],
      ),
    );
  }
}
