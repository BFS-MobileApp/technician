import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/app_consts.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/claim%20details/presentation/cubit/claim_details_cubit.dart';
import 'package:technician/widgets/message_widget.dart';
import 'package:technician/widgets/svg_image_widget.dart';
import 'package:technician/widgets/text_widget.dart';

class PriorityButton extends StatefulWidget {
  String claimId;
  String referenceId;
  BuildContext ctx;
  PriorityButton({super.key , required this.claimId , required this.referenceId , required this.ctx});

  @override
  State<PriorityButton> createState() => _PriorityButtonState();
}

class _PriorityButtonState extends State<PriorityButton> {

  int _selectedLanguageRadioIndex = 0;

  List<Map<String, dynamic>> options = [
    {"icon": AssetsManager.lowPriority, "name": "low".tr, "value": 1},
    {"icon": AssetsManager.highPriority, "name": "high".tr, "value": 2},
    {"icon": AssetsManager.normalPriority, "name": "normal".tr, "value": 3},
    {"icon": AssetsManager.mediumPriority, "name": "medium".tr, "value": 4},
    {"icon": AssetsManager.urgentPriority, "name": "urgent".tr, "value": 5},
  ];

  String priorityCase(){
    switch(_selectedLanguageRadioIndex){
      case 1:
        return 'low';
      case 2:
        return 'high';
      case 3:
        return 'normal';
      case 4:
        return 'medium';
      case 5:
        return 'urgent';
      default:
        return '';
    }
  }

  void _changePriorityMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context ) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setBottomSheetState) {
            return Container(
              padding: EdgeInsets.all(16.0.adaptSize),
              decoration: const BoxDecoration(
                color: Color(0xFFF6F6F6),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(26.0),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10.h),
                    alignment: Alignment.center,
                    child: TextWidget(
                      text: 'changePriority'.tr,
                      fontSize: 22.fSize,
                      fontWeight: FontWeight.w600,
                      fontColor: const Color(0xFF031D3C),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildRadioButton(options[0], _selectedLanguageRadioIndex ,
                                setBottomSheetState),
                            Container(
                              margin: EdgeInsets.only(right: 33.w),
                              child: buildRadioButton(options[1], _selectedLanguageRadioIndex ,
                                  setBottomSheetState),
                            )
                          ],
                        ),
                        SizedBox(height: 10.0.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildRadioButton(options[2], _selectedLanguageRadioIndex ,
                                setBottomSheetState),
                            buildRadioButton(options[3], _selectedLanguageRadioIndex ,
                                setBottomSheetState),
                          ],
                        ),
                        SizedBox(height: 10.0.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            buildRadioButton(options[4], _selectedLanguageRadioIndex ,
                                setBottomSheetState),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: AppColors.errorColor),
                            borderRadius: BorderRadius.circular(20), // <-- Radius
                          ),
                          minimumSize: Size(150.w, 40.h),
                          backgroundColor: AppColors.whiteColor,
                          textStyle: const TextStyle(color: AppColors.whiteColor),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'close'.tr,
                          style: TextStyle(
                              fontSize: 16.0.fSize,
                              fontWeight: FontWeight.bold,
                              color: AppColors.errorColor),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Color(0xFF679C0D)),
                            borderRadius: BorderRadius.circular(20), // <-- Radius
                          ),
                          minimumSize: Size(150.w, 40.h),
                          backgroundColor: AppColors.whiteColor,
                          textStyle: const TextStyle(color: AppColors.whiteColor),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          if(_selectedLanguageRadioIndex ==0){
                            MessageWidget.showSnackBar('pleaseChooseThePriority'.tr, AppColors.errorColor);
                            return;
                          }
                          BlocProvider.of<ClaimDetailsCubit>(context).changePriority(int.parse(widget.claimId) , priorityCase()).then((value){
                            if(value){
                              Navigator.pop(widget.ctx , true);
                              //BlocProvider.of<ClaimDetailsCubit>(widget.ctx).getClaimDetails(widget.referenceId);
                            }
                          });
                        },
                        child: Text(
                          'confirm'.tr,
                          style: TextStyle(
                              fontSize: 16.0.fSize,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF679C0D)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget buildRadioButton(Map<String, dynamic> option, int selectedValue, StateSetter myState) {
    return Row(
      children: [
        Radio(
          value: option['value'],
          groupValue: _selectedLanguageRadioIndex ,
          onChanged: (val) {
            myState(() {
              _selectedLanguageRadioIndex  = val as int;
            });
          },
        ),
        SVGImageWidget(
          image: option['icon'],
          height: 20.h,
          width: 20.w,
        ),
        SizedBox(width: 8.0.w),
        Text(option['name']),
      ],
    );
  }

  Widget priorityWidget(){
    if(AppConst.updateClaimPriority){
      return InkWell(
        onTap: (){
          _changePriorityMenu(context);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Container(
            width: 327.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius:const  BorderRadius.all(
                  Radius.circular(25.0)
              ),
              border: Border.all(
                  color: AppColors.mainColor
              ),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SVGImageWidget(image: AssetsManager.priorityButtonIcon, width: 18.w, height: 18.h),
                  SizedBox(width: 12.w,),
                  Container(
                    margin: EdgeInsets.only(top: 5.h),
                    child: Text(
                      'changePriority'.tr,
                      style: TextStyle(color: AppColors.whiteColor , fontSize: 18.fSize , fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
    return const SizedBox();
  }


  @override
  Widget build(BuildContext context) {
    return priorityWidget();
  }
}
