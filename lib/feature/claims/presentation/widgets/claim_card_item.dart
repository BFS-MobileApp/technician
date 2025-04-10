import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../config/PrefHelper/helper.dart';

import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/app_consts.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/claim%20details/presentation/cubit/claim_details_cubit.dart';
import 'package:technician/feature/claims/data/models/technician_model.dart';
import 'package:technician/feature/claims/presentation/cubit/claims_cubit.dart';
import 'package:technician/feature/claims/presentation/cubit/technicial_cubit.dart';
import 'package:technician/widgets/text_widget.dart';

class ClaimCardItem extends StatefulWidget {

  String referenceId;
  String claimId;
  String status;
  String buildingName;
  String priority;
  String type;
  String date;
  String availableTime;
  int screenId;
  String estimateTime;
  String unitNo;
  BuildContext ctx;
  ClaimCardItem({super.key , required this.unitNo, required this.ctx , required this.estimateTime , required this.claimId ,  required this.referenceId , required this.status , required this.buildingName , required this.priority , required this.type , required this.date , required this.availableTime , required this.screenId});

  @override
  State<ClaimCardItem> createState() => _ClaimCardItemState();
}

class _ClaimCardItemState extends State<ClaimCardItem> {
  final int space = 16;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  bool chooseStartDate = false , chooseEndDate = false , chooseTechnician = false;
  List<Datum> technicalList = [];
  String selectedOption = '';


  void _showAssignBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                    technicalList.isNotEmpty
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
                      items: technicalList.map<DropdownMenuItem<String>>((Datum datum) {
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
                            var splited = widget.estimateTime.split(':');
                            int hour = int.parse(splited[0]);
                            int minute = int.parse(splited[1]);
                            endDate = endDate.add(Duration(hours: hour , minutes: minute));
                            Navigator.pop(context);
                            BlocProvider.of<ClaimDetailsCubit>(context).assignClaim(
                              widget.claimId,
                              selectedOption,
                              Helper.assignFormatDateTime(startDate.toString()),
                              Helper.assignFormatDateTime(endDate.toString()),
                            ).then((value){
                              if(value){
                                final data = {
                                  "status":"new",
                                  "per_page":"200"
                                };
                                BlocProvider.of<ClaimsCubit>(widget.ctx).getAllClaims(data);
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

  void getData()=>BlocProvider.of<TechnicalCubit>(context).getAllTechnician(widget.claimId).then((model){
    setState(() {
      technicalList= model!.data;
      selectedOption = technicalList[0].id.toString();
    });
    _showAssignBottomSheet();
  });

  Widget statusOrButton() {
    if (widget.screenId == 1 && AppConst.assignClaims) {
      return InkWell(
        onTap: getData,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.0,
              color: Colors.blueAccent,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(20.0),
            ),
            color: Colors.blueAccent,
          ),
          child: Center(
            child: TextWidget(
              text: 'assign'.tr,
              fontSize: 16.fSize,
              fontWeight: FontWeight.w600,
              fontColor:  Colors.white,
            ),
          ),
        ),
      );
    } else if (widget.screenId != 1) {
      return Container(
        width: 120.w,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: Helper.returnScreenStatusColor(widget.status),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
          color: Helper.returnScreenStatusColor(widget.status),
        ),
        child: Center(
          child: TextWidget(
            text: widget.status,
            fontSize: 14.fSize,
            fontWeight: FontWeight.w500,
            fontColor: Colors.white,
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w , vertical: 3.w),
      child: Card(
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding:  EdgeInsets.all(16.0.adaptSize),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            child: SizedBox(
              height: 180.h,
              child: ListView(
                physics:  const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(text: widget.referenceId, fontSize: 16.fSize , fontWeight: FontWeight.w600, fontColor: Theme.of(context).textTheme.bodyMedium!.color,),
                          SizedBox(height: 3.h,),
                          SizedBox(
                            width: 170.w,
                            child: TextWidget(text: '${widget.buildingName} - ${widget.unitNo}', fontSize: 12.fSize , fontWeight: FontWeight.w500, fontColor: AppColors.claimListFontColor,maxLine: 2,),
                          ),
                        ],
                      ),
                      statusOrButton()
                    ],
                  ),
                  SizedBox(height: 5.h,),
                  const Divider(thickness: 1,color: AppColors.grey,),
                  SizedBox(height: 8.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(text: 'priority'.tr, fontSize: 12.fSize , fontColor: Theme.of(context).textTheme.bodyMedium!.color, fontWeight: FontWeight.w500,),
                      TextWidget(text: widget.priority, fontSize: 12.fSize , fontColor: Helper.getPriorityColor(widget.priority), fontWeight: FontWeight.w500,),
                    ],
                  ),
                  SizedBox(height: space.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(text: 'type'.tr, fontSize: 12.fSize , fontColor: Theme.of(context).textTheme.bodyMedium!.color, fontWeight: FontWeight.w500,),
                      TextWidget(text: widget.type, fontSize: 12.fSize , fontColor: Theme.of(context).textTheme.bodyMedium!.color, fontWeight: FontWeight.w500,maxLine: 4,),
                    ],
                  ),
                  SizedBox(height: space.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(text: 'createdDate'.tr, fontSize: 12.fSize , fontColor: Theme.of(context).textTheme.bodyMedium!.color, fontWeight: FontWeight.w500,),
                      TextWidget(text: widget.date, fontSize: 12.fSize , fontColor: Theme.of(context).textTheme.bodyMedium!.color, fontWeight: FontWeight.w500,maxLine: 2,),
                    ],
                  ),
                  SizedBox(height: space.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(text: 'availableTime'.tr, fontSize: 12.fSize , fontColor: Theme.of(context).textTheme.bodyMedium!.color, fontWeight: FontWeight.w500,),
                      TextWidget(text: widget.availableTime, fontSize: 12.fSize , fontColor: Theme.of(context).textTheme.bodyMedium!.color, fontWeight: FontWeight.w500,maxLine: 2,),
                    ],
                  ),
                  SizedBox(height: space.h,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}