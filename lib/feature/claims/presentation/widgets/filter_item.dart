import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/claims/presentation/widgets/filter_checkbox_item.dart';
import 'package:technician/feature/claims/presentation/widgets/filter_label_item.dart';
import 'package:technician/widgets/aligment_widget.dart';
import 'package:technician/widgets/button_widget.dart';
import 'package:technician/widgets/text_widget.dart';

import '../cubit/claims_cubit.dart';

class FilterBottomSheetContent extends StatefulWidget{

  final String menuName;

  final Map<String , dynamic> data;

  FilterBottomSheetContent({super.key , required this.menuName , required this.data});

  @override
  State<FilterBottomSheetContent> createState() => _FilterBottomSheetContentState();
}

class _FilterBottomSheetContentState extends State<FilterBottomSheetContent> {

  String filterStatus = '';
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  bool chooseStartDate = false , chooseEndDate = false;
  AlignmentWidget alignmentWidget = AlignmentWidget();
  bool newStatus = false , completedStatus = false , assignedStatus = false , closedStatus = false , startedStatus = false , cancelledStatus = false;
  bool lowPriority = false , highPriority = false , normalPriority = false , urgentPriority = false , mediumPriority = false;
  List<String> statuses = [];
  List<String> priorities = [];
  Map<String , dynamic> filterData = {};

  String addStatus(){
    if (newStatus) {
      statuses.add('new');
    }
    if (completedStatus) {
      statuses.add('completed');
    }
    if (assignedStatus) {
      statuses.add('assigned');
    }
    if (closedStatus) {
      statuses.add('closed');
    }
    if (startedStatus) {
      statuses.add('started');
    }
    if (cancelledStatus) {
      statuses.add('cancelled');
    }
    return statuses.join(',');
  }

  String addPriority(){
    if (lowPriority) {
      priorities.add('low');
    }
    if (urgentPriority) {
      priorities.add('urgent');
    }
    if (highPriority) {
      priorities.add('high');
    }
    if (mediumPriority) {
      priorities.add('medium');
    }
    if (normalPriority) {
      priorities.add('normal');
    }
    return priorities.join(',');
  }

  void appendString(String item , String value){
    if(item == ''){
      setState(() {
        item = value;
      });
    } else {
      setState(() {
        item = '$item,$value';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0.adaptSize),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 5.0.h,
            width: 50.0.w,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          SizedBox(height: 10.0.h),
          Center(
            child: Text(
              widget.menuName,
              style: TextStyle(
                  fontSize: 18.0.fSize,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black
              ),
            ),
          ),
          SizedBox(height: 5.0.h),
          FilterLabelItem(image: AssetsManager.date, labelText: 'date'.tr),
          SizedBox(height: 5.h,),
          Container(
            alignment: alignmentWidget.returnAlignment(),
            margin: EdgeInsets.symmetric(horizontal: 10.w , vertical: 8.h),
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
                      initialDate: startDate,
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2030),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        chooseStartDate = true;
                        startDate = pickedDate;
                      });
                    }
                  },
                  child: Text(
                    chooseStartDate
                        ? DateFormat('yyyy-MM-dd').format(startDate)
                        : DateFormat('yyyy-MM-dd').format(DateTime.now()),
                    style: TextStyle(
                        fontSize: 16.0.fSize,
                        fontWeight: FontWeight.bold,
                        color: AppColors.mainColor),
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
                      initialDate: endDate,
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2030),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        chooseEndDate = true;
                        endDate = pickedDate;
                      });
                    }
                  },
                  child: Text(
                    chooseEndDate
                        ? DateFormat('yyyy-MM-dd').format(endDate)
                        : DateFormat('yyyy-MM-dd').format(DateTime.now()),
                    style: TextStyle(
                        fontSize: 16.0.fSize,
                        fontWeight: FontWeight.bold,
                        color: AppColors.mainColor),
                  ),

                ),
              ],
            ),
          ),
          SizedBox(height: 10.h,),
          FilterLabelItem(image: AssetsManager.statusIcon, labelText: 'status'.tr),
          SizedBox(height: 5.h,),
          Container(
            alignment: alignmentWidget.returnAlignment(),
            margin: EdgeInsets.symmetric(horizontal: 5.w , vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FilterCheckboxItem(image: AssetsManager.newStatusIcon, text: 'new'.tr , onChanged: (value) => setState(() => newStatus = value),),
                    FilterCheckboxItem(image: AssetsManager.completedStatusIcon, text: 'complete'.tr , onChanged: (value) => setState(() => completedStatus = value)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FilterCheckboxItem(image: AssetsManager.assignedStatusIcon, text: 'assigned'.tr , onChanged: (value) => setState(() => assignedStatus = value)),
                    FilterCheckboxItem(image: AssetsManager.closedStatusIcon, text: 'closed'.tr , onChanged: (value) => setState(() => closedStatus = value)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FilterCheckboxItem(image: AssetsManager.startedStatusIcon, text: 'started'.tr , onChanged: (value) => setState(() => startedStatus = value)),
                    FilterCheckboxItem(image: AssetsManager.cancelledStatusIcon, text: 'cancelled'.tr , onChanged: (value) => setState(() => cancelledStatus = value)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h,),
          FilterLabelItem(image: AssetsManager.prioprityIcon, labelText: 'priority'.tr),
          SizedBox(height: 5.h,),
          Container(
            alignment: alignmentWidget.returnAlignment(),
            margin: EdgeInsets.symmetric(horizontal: 5.w , vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FilterCheckboxItem(image: AssetsManager.lowPriority, text: 'low'.tr , onChanged: (value) => setState(() => lowPriority = value)),
                    FilterCheckboxItem(image: AssetsManager.highPriority, text: 'high'.tr , onChanged: (value) => setState(() => highPriority = value)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FilterCheckboxItem(image: AssetsManager.normalPriority, text: 'normal'.tr , onChanged: (value) => setState(() => normalPriority = value)),
                    FilterCheckboxItem(image: AssetsManager.urgentPriority  , text: 'urgent'.tr , onChanged: (value) => setState(() => urgentPriority = value)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FilterCheckboxItem(image: AssetsManager.mediumPriority, text: 'medium'.tr , onChanged: (value) => setState(() => mediumPriority = value)),
                  ],
                ),
                SizedBox(height: 20.h,),
                ButtonWidget(width: 330, height: 40, onTap: () {
                  statuses.clear();
                  priorities.clear();
                  String statusString = addStatus();
                  String priorityString = addPriority();
                  if (statusString.isNotEmpty) {
                    filterData['status'] = statusString;
                  }
                  if (priorityString.isNotEmpty) {
                    filterData['priority'] = priorityString;
                  }
                  filterData['start_date'] = DateFormat('yyyy-MM-dd').format(startDate);
                  filterData['end_date'] = DateFormat('yyyy-MM-dd').format(endDate);
                  if (filterData.isEmpty) {
                    Navigator.pop(context);
                  } else {
                    Navigator.pop(context);
                    BlocProvider.of<ClaimsCubit>(context).getAllClaims(filterData);
                  }
                }
                  , name: 'showResult'.tr , btColor: AppColors.mainColor,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
