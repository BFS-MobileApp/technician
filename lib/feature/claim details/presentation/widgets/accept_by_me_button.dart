import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:technician/config/PrefHelper/helper.dart';
import 'package:technician/config/PrefHelper/prefs.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/app_consts.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/claim%20details/presentation/cubit/claim_details_cubit.dart';
import 'package:technician/widgets/message_widget.dart';
import 'package:technician/widgets/svg_image_widget.dart';
import 'package:technician/widgets/text_widget.dart';

class AcceptByMeButton extends StatefulWidget {
  String claimId;
  BuildContext ctx;
  AcceptByMeButton({super.key , required this.ctx , required this.claimId});

  @override
  State<AcceptByMeButton> createState() => _AcceptByMeButtonState();
}

class _AcceptByMeButtonState extends State<AcceptByMeButton> {

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  bool chooseStartDate = false , chooseEndDate = false;
  int userId = 0;

  setUserId(){
    setState(() {
      userId = Prefs.getInt(AppStrings.userId);
    });
  }


  @override
  void initState() {
    super.initState();
    setUserId();
  }

  void _acceptClaimByMeMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context ) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setBottomSheetState) {
            return FractionallySizedBox(
              heightFactor: 0.6,
              child: Padding(
                  padding: EdgeInsets.all(16.0.adaptSize),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(text: 'startDate'.tr, fontSize: 16.fSize , fontColor: AppColors.black, fontWeight: FontWeight.w500,),
                      SizedBox(height: 3.h,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: AppColors.mainColor),
                            borderRadius: BorderRadius.circular(20), // <-- Radius
                          ),
                          minimumSize: Size(230.w, 40.h),
                          backgroundColor: AppColors.whiteColor,
                          textStyle: const TextStyle(color: AppColors.whiteColor,
                          ),
                        ),
                        onPressed: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2022),
                            lastDate: DateTime(2030),
                          );
                          if (pickedDate != null) {
                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(startDate),
                            );
                            if (pickedTime != null) {
                              setBottomSheetState(() {
                                chooseStartDate = true;
                                startDate = DateTime(
                                  pickedDate.year,
                                  pickedDate.month,
                                  pickedDate.day,
                                  pickedTime.hour,
                                  pickedTime.minute,
                                );
                              });
                            }
                          }
                        },
                        child: Text(
                          chooseStartDate
                              ? DateFormat('yyyy-MM-dd HH:mm').format(startDate)
                              : DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
                          style: TextStyle(
                              fontSize: 16.0.fSize,
                              fontWeight: FontWeight.bold,
                              color: AppColors.mainColor
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h,),
                      TextWidget(text: 'endDate'.tr, fontSize: 16.fSize , fontColor: AppColors.black, fontWeight: FontWeight.w500,),
                      SizedBox(height: 3.h,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: AppColors.mainColor),
                            borderRadius: BorderRadius.circular(20), // <-- Radius
                          ),
                          minimumSize: Size(230.w, 40.h),
                          backgroundColor: AppColors.whiteColor,
                          textStyle: const TextStyle(color: AppColors.whiteColor,
                          ),
                        ),
                        onPressed: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2022),
                            lastDate: DateTime(2030),
                          );
                          if (pickedDate != null) {
                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(endDate),
                            );
                            if (pickedTime != null) {
                              setBottomSheetState(() {
                                chooseEndDate = true;
                                endDate = DateTime(
                                  pickedDate.year,
                                  pickedDate.month,
                                  pickedDate.day,
                                  pickedTime.hour,
                                  pickedTime.minute,
                                );
                              });
                            }
                          }
                        },
                        child: Text(
                          chooseEndDate
                              ? DateFormat('yyyy-MM-dd HH:mm').format(endDate)
                              : DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
                          style: TextStyle(
                              fontSize: 16.0.fSize,
                              fontWeight: FontWeight.bold,
                              color: AppColors.mainColor
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h,),
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
                              textStyle: const TextStyle(color: AppColors.whiteColor,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'close'.tr,
                              style: TextStyle(
                                  fontSize: 16.0.fSize,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.errorColor
                              ),
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
                              textStyle: const TextStyle(color: AppColors.whiteColor,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              if(startDate.isAfter(endDate)){
                                MessageWidget.showSnackBar('startDateMustBeBeforeEndDate'.tr, AppColors.errorColor);
                                return;
                              }
                              BlocProvider.of<ClaimDetailsCubit>(context).assignClaim(widget.claimId , userId.toString() , Helper.convertDateTimeToDate(startDate) , Helper.convertDateTimeToDate(endDate)).then((value){
                                if(value){
                                  Navigator.pop(widget.ctx , true);
                                }
                              });
                            },
                            child: Text(
                              'confirm'.tr,
                              style: TextStyle(
                                  fontSize: 16.0.fSize,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF679C0D)
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
              ),
            );
          },
        );
      },
    );
  }

  Widget acceptByMeWidget(){
    if(AppConst.acceptClaim){
      return InkWell(
        onTap: (){
          _acceptClaimByMeMenu(context);
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
                  SVGImageWidget(image: AssetsManager.acceptIcon, width: 18.w, height: 18.h),
                  SizedBox(width: 12.w,),
                  Container(
                    margin: EdgeInsets.only(top: 5.h),
                    child: Text(
                      'acceptByMe'.tr,
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
    return acceptByMeWidget();
  }
}
