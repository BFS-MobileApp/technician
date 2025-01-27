import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:technician/config/arguments/routes_arguments.dart';
import 'package:technician/config/routes/app_routes.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/claims/data/models/claims_model.dart';
import 'package:technician/widgets/app_headline_widget.dart';
import 'package:technician/widgets/svg_image_widget.dart';
import 'package:technician/widgets/text_widget.dart';

class NotificationHomeItem extends StatelessWidget {

  final List<Datum> model;
  const NotificationHomeItem({super.key , required this.model});

  String checkPriorityImage(String itemValue){
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppHeadline(
          title: 'rememberThat'.tr,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
        ),
        SizedBox(height: 5.h,),
        SizedBox(
          height: 125.h,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: model.length<10 ? model.length : 10,
              itemBuilder: (ctx, index) {
                return GestureDetector(
                  onTap: (){
                    final claimDetailsArgs = ClaimDetailsArguments(
                      claimId: model[index].id.toString(),
                      referenceId: model[index].referenceId,
                    );
                    Navigator.pushNamed(
                      context,
                      Routes.assignedClaims,
                      arguments: claimDetailsArgs,
                    );
                  },
                  child: Card(
                    elevation: 1,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(5.adaptSize),
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SVGImageWidget(image: AssetsManager.notificationHomeIcon1, width: 28.w, height: 28.h),
                                  SizedBox(width: 15.w,),
                                  TextWidget(fontSize: 15.fSize,text: 'startAClaim'.tr ,fontWeight: FontWeight.w600,fontColor: AppColors.notificationHomeTittleColor,)
                                ],
                              ),
                              SizedBox(width: 80.w,),
                              SVGImageWidget(image: checkPriorityImage(model[index].priority), width: 20.w, height: 20.h),
                            ],
                          ),
                          SizedBox(height: 10.h,),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            width: 200.w,
                            child: TextWidget(fontColor: const Color(0xFF777A95), maxLine: 2 , text: 'claim'.tr+'#'+model[index].referenceId+'\n'+model[index].unit.building+' , '+model[index].unit.name, fontSize: 13.fSize , fontWeight: FontWeight.w500,),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
