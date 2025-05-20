import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:technician/config/routes/app_routes.dart';
import '../../../../config/PrefHelper/helper.dart';

import 'package:technician/core/utils/app_consts.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/claim%20details/presentation/cubit/claim_details_cubit.dart';
import 'package:technician/widgets/svg_image_widget.dart';
import 'package:technician/widgets/text_widget.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../claims/data/models/technician_model.dart';

class ReassignButton extends StatefulWidget {
  String btName;
  List<Datum> technicalList;
  String claimId;
  String referenceId;
  BuildContext ctx;
  String estimateTime;
  ReassignButton({super.key , required this.estimateTime , required this.ctx , required this.btName ,required this.technicalList , required this.claimId , required this.referenceId});

  @override
  State<ReassignButton> createState() => _ReassignButtonState();
}

class _ReassignButtonState extends State<ReassignButton> {

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  bool chooseStartDate = false , chooseEndDate = false , chooseTechnician = false;
  String selectedOption = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      selectedOption = widget.technicalList[0].id.toString();
    });

  }

  void _showAssignBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return FractionallySizedBox(
              heightFactor: 0.5,
              child: Padding(
                padding: EdgeInsets.all(16.0.adaptSize),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'assign'.tr,
                        style: TextStyle(
                          fontSize: 18.0.fSize,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).textTheme.bodySmall!.color,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    TextWidget(
                      text: 'selectTechnician'.tr,
                      fontSize: 14.fSize,
                      fontWeight: FontWeight.w500,
                      fontColor: Theme.of(context).textTheme.bodySmall!.color,
                    ),
                    widget.technicalList.isNotEmpty
                        ? DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0.w, vertical: 12.0.h),
                      ),
                      value: selectedOption,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedOption = newValue!;
                          chooseTechnician = true;
                        });
                      },
                      items: widget.technicalList.map<DropdownMenuItem<String>>((Datum datum) {
                        return DropdownMenuItem<String>(
                          value: datum.id.toString(),
                          child: Text(datum.name),
                        );
                      }).toList(),
                    )
                        : const SizedBox(),
                    SizedBox(height: 16.h),
                    TextWidget(
                      text: 'startDate'.tr,
                      fontSize: 16.fSize,
                      fontColor: Theme.of(context).textTheme.bodySmall!.color,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 3.h),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: AppColors.mainColor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minimumSize: Size(230.w, 40.h),
                        backgroundColor: AppColors.whiteColor,
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
                            setState(() {
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
                          color: AppColors.mainColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    TextWidget(
                      text: 'endDate'.tr,
                      fontSize: 16.fSize,
                      fontColor: Theme.of(context).textTheme.bodySmall!.color,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 3.h),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: AppColors.mainColor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minimumSize: Size(230.w, 40.h),
                        backgroundColor: AppColors.whiteColor,
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
                            setState(() {
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
                          color: AppColors.mainColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: AppColors.errorColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minimumSize: Size(150.w, 40.h),
                            backgroundColor: AppColors.whiteColor,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'close'.tr,
                            style: TextStyle(
                              fontSize: 16.0.fSize,
                              fontWeight: FontWeight.bold,
                              color: AppColors.errorColor,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Color(0xFF679C0D)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minimumSize: Size(150.w, 40.h),
                            backgroundColor: AppColors.whiteColor,
                          ),
                          onPressed: () {
                            print(endDate);
                            var splited = widget.estimateTime.split(':');
                            int hour = int.parse(splited[0]);
                            int minute = int.parse(splited[1]);
                            endDate = endDate.add(Duration(hours: hour , minutes: minute));
                            print(endDate);
                            Navigator.pop(context);
                            BlocProvider.of<ClaimDetailsCubit>(context).assignClaim(
                              widget.claimId,
                              selectedOption,
                              Helper.assignFormatDateTime(startDate.toString()),
                              Helper.assignFormatDateTime(endDate.toString()),
                            ).then((value){
                              if(value){
                                Navigator.pushReplacementNamed(context, Routes.home);
                                //BlocProvider.of<ClaimDetailsCubit>(context).getClaimDetails(widget.referenceId);
                              }
                            });
                          },
                          child: Text(
                            'confirm'.tr,
                            style: TextStyle(
                              fontSize: 16.0.fSize,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF679C0D),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  int _parseEstimateTime(String estimateTimeString) {
    // Using regular expressions to find the number of hours and minutes (if mentioned)
    final regex = RegExp(r'(\d+)\s*(hours?|hr|h)|half|(\d+)\s*(minutes?|min|m)');
    final hoursMatch = regex.firstMatch(estimateTimeString);

    int hours = 0;
    int minutes = 0;

    if (hoursMatch != null) {
      // Parsing hours
      if (hoursMatch.group(1) != null) {
        hours = int.tryParse(hoursMatch.group(1) ?? '') ?? 0;
      }

      // Check if "half" is mentioned, which implies 30 minutes
      if (estimateTimeString.contains('half')) {
        minutes = 30;
      }

      // Parsing minutes (if present)
      if (hoursMatch.group(3) != null) {
        minutes = int.tryParse(hoursMatch.group(3) ?? '') ?? 0;
      }
    }

    // Return total hours as a combined value (hours + minutes converted to hours)
    return hours + (minutes ~/ 60); // minutes are converted to hours (e.g., 90 minutes = 1.5 hours)
  }

  Widget reAssignWidget(){
    if(AppConst.reassignClaims){
      return InkWell(
        onTap: (){
          _showAssignBottomSheet();
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
                  SVGImageWidget(image: AssetsManager.reassignIcon, width: 18.w, height: 18.h),
                  SizedBox(width: 12.w,),
                  Container(
                    margin: EdgeInsets.only(top: 5.h),
                    child: Text(
                      widget.btName,
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
    return reAssignWidget();
  }
}
