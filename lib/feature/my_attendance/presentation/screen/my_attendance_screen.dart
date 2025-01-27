import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:technician/config/PrefHelper/prefs.dart';
import 'package:technician/config/arguments/routes_arguments.dart';
import 'package:technician/config/routes/app_routes.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/my_attendance/data/models/my_attendance_model.dart';
import 'package:technician/feature/my_attendance/presentation/cubit/my_attendance_cubit.dart';
import 'package:technician/feature/my_attendance/presentation/cubit/my_attendance_state.dart';
import 'package:technician/widgets/bar_widget.dart';
import 'package:technician/widgets/error_widget.dart';

class MyAttendanceScreen extends StatefulWidget {
  const MyAttendanceScreen({super.key});

  @override
  State<MyAttendanceScreen> createState() => _MyAttendanceScreenState();
}

class _MyAttendanceScreenState extends State<MyAttendanceScreen> {

  TextEditingController searchControl = TextEditingController();
  MyAttendanceModel? model;
  String chooseFilter = '';
  String selectedMonth = '';
  List<String> filterList = [];
  List<Datum> originalData = [];

  @override
  void initState() {
    super.initState();
    getData();
    getPastFiveMonths();
  }

   getPastFiveMonths() {
    final now = DateTime.now();
    List<String> pastMonths = [];
    for (int i = 0; i < 5; i++) {
      final pastMonth = DateTime(now.year, now.month - i);
      final formattedMonth = DateFormat('MMMM').format(pastMonth);
      pastMonths.add(formattedMonth);
    }
    setState(() {
      filterList = pastMonths;
      filterList.insert(0, 'all'.tr);
      chooseFilter = filterList[0];
    });
    print(filterList);
  }

  String formatDateTime(String isoDateTime) {
    DateTime dateTime = DateTime.parse(isoDateTime).toLocal();
    String formattedDate = DateFormat('dd/MM/yyyy hh:mm a').format(dateTime);
    return formattedDate;
  }

  String getDateOnly(String isoDateTime) {
    DateTime dateTime = DateTime.parse(isoDateTime).toLocal();
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    return formattedDate;
  }

  String getTimeOnly(String isoDateTime) {
    DateTime dateTime = DateTime.parse(isoDateTime).toLocal();
    String formattedTime = DateFormat('hh:mm a').format(dateTime);
    return formattedTime;
  }

  Widget screenWidget() {
    return ListView(
      children: [
        SizedBox(height: 50.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: AppBarItem(
                title: 'myAttendance'.tr,
                image: AssetsManager.backIcon2,
              ),
            ),
            GestureDetector(
              onTap: () async{
                final result = await Navigator.pushNamed(context , Routes.addAttendance);
                if(result == true || result == null ){
                  getData();
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                width: 35.w,
                height: 35.h,
                decoration: const BoxDecoration(
                    color: AppColors.mainColor,
                    shape: BoxShape.circle),
                child: Center(
                  child: Icon(Icons.add, color: AppColors.whiteColor, size: 25.fSize),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15.0), // Reduced horizontal margin
                child: TextField(
                  controller: searchControl,
                  onChanged: ((value){
                    if(value.isEmpty || value == ''){
                      getData();
                    } else {
                      search(value);
                    }
                  }),
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'search'.tr,
                    hintStyle: const TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: const Color(0xFFEBEBEB),
                    prefixIcon: const Icon(Icons.search, color: AppColors.mainColor),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close, color: AppColors.mainColor),
                      onPressed: () {
                        searchControl.clear();
                        getData();
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none, // Remove the underline
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Color(0xFFEBEBEB)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Color(0xFFEBEBEB)),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.w), // Reduced horizontal margin
              child: DropdownButton<String>(
                value: chooseFilter,
                onChanged: (String? newValue) {
                  setState(() {
                    chooseFilter = newValue.toString();
                    selectedMonth = newValue.toString();
                    resetData();
                  });
                },
                items: filterList
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Allow horizontal scrolling
          child: FittedBox(
            child: DataTable(
              horizontalMargin: 10,
              columnSpacing: 10.w,
              headingRowHeight: 40,
              columns: [
                DataColumn(
                  label: Text(
                    'type'.tr,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainColor,
                      fontSize: 16.fSize,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'dateTime'.tr,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainColor,
                      fontSize: 16.fSize,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'remarks'.tr,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainColor,
                      fontSize: 16.fSize,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainColor,
                      fontSize: 16.fSize,
                    ),
                  ),
                ),
              ],
              rows: List<DataRow>.generate(model!.data.length, (index) {
                return DataRow(
                  cells: [
                    DataCell(
                      Row(
                        children: [
                          Icon(
                            model!.data[index].checkinAddress != null
                                ? Icons.arrow_circle_right
                                : Icons.arrow_circle_left,
                            color: model!.data[index].checkinAddress != null ? Colors.green : Colors.red,
                          ),
                          const SizedBox(width: 4), // Reduced the width of the spacing
                          Text(
                            model!.data[index].checkinAddress != null ? 'in'.tr : 'out'.tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                              fontSize: 14.fSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0), // Reduced padding
                        child: Text(
                          model!.data[index].clockInTime != '' ? formatDateTime(model!.data[index].clockInTime) : formatDateTime(model!.data[index].clockOutTime),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                            fontSize: 14.fSize,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0), // Reduced padding
                        child: Text(
                          model!.data[index].note.length > 10
                              ? '${model!.data[index].note.substring(0, 7)}...'
                              : model!.data[index].note,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                            fontSize: 14.fSize,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      IconButton(
                        icon: const Icon(
                          Icons.remove_red_eye,
                          color: Colors.blue,
                        ),
                        onPressed: () => Navigator.pushNamed(
                            context,
                            Routes.viewAttendance,
                            arguments: ViewAttendanceArguments(
                              longitude: model!.data[index].checkoutAddress != null
                                  ? model!.data[index].checkoutAddress!.longitude
                                  : model!.data[index].checkinAddress!.longitude,
                              latitude: model!.data[index].checkoutAddress != null
                                  ? model!.data[index].checkoutAddress!.latitude
                                  : model!.data[index].checkinAddress!.latitude,
                              remMarks: model!.data[index].note,
                              date: model!.data[index].clockInTime != ''
                                  ? getDateOnly(model!.data[index].clockInTime)
                                  : getDateOnly(model!.data[index].clockOutTime),
                              time: model!.data[index].clockInTime != ''
                                  ? getTimeOnly(model!.data[index].clockInTime)
                                  : getTimeOnly(model!.data[index].clockOutTime),
                              checkType: model!.data[index].checkoutAddress != null
                                ? 'checkOut'.tr
                                : 'checkIn'.tr,
                              color: model!.data[index].checkoutAddress != null
                                ? const Color(0xFFFF0000)
                                : const Color(0xFF00A800)
                            )
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  int getMonthNumber(){
    switch (selectedMonth){
      case 'December':
        return 12;
      case 'November':
        return 11;
      case 'October':
        return 10;
      case 'September':
        return 9;
      case 'August':
        return 8;
      case 'July':
        return 7;
      case 'June':
        return 6;
      case 'May':
        return 5;
      case 'April':
        return 4;
      case 'March':
        return 3;
      case 'February':
        return 2;
      case 'January':
        return 1;
      default:
        return 0;
    }
  }

  resetList(){
    setState(() {
      String jsonString = Prefs.getString('AttList');
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      MyAttendanceModel mode2 = MyAttendanceModel.fromJson(jsonMap);
      model = mode2;
    });
  }

  void filterDataByMonth() {
    print(model!.data.length);
    print(originalData.length);
    print(selectedMonth);
    if (selectedMonth == '') return;
    if (selectedMonth == 'all'.tr) {
      getData(); // Reset data if "All" is selected
      return;
    }
    int selectedMonthNumber = getMonthNumber();
    model!.data = model!.data.where((item) {
      DateTime? clockInDateTime = item.clockInTime.isNotEmpty ? DateTime.parse(item.clockInTime) : null;
      DateTime? clockOutDateTime = item.clockOutTime.isNotEmpty ? DateTime.parse(item.clockOutTime) : null;
      bool matchesMonth = false;

      if (clockInDateTime != null) {
        matchesMonth = clockInDateTime.month == selectedMonthNumber;
      }
      if (!matchesMonth && clockOutDateTime != null) {
        matchesMonth = clockOutDateTime.month == selectedMonthNumber;
      }

      return matchesMonth;
    }).toList();
  }


  void search(String item) {
    setState(() {
      model!.data = model!.data
          .where((element) => element.note.contains(item))
          .toList();
    });
  }

  Widget checkState(MyAttendanceState state) {
    if (state is MyAttendanceIsLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.mainColor),
      );
    } else if (state is MyAttendanceError) {
      return ErrorWidgetItem(onTap: () => getData());
    } else if (state is MyAttendanceLoaded) {
      model = state.model;
      String jsonString = jsonEncode(state.model.toJson());
      Prefs.setString('AttList', jsonString);
      return screenWidget();
    } else if(state is MyAttendanceLoaded2){
      model = state.model;
      filterDataByMonth();
      return screenWidget();
    }else {
      return screenWidget();
    }
  }


  getData()=>BlocProvider.of<MyAttendanceCubit>(context).getMyAttendance();

  resetData()=>BlocProvider.of<MyAttendanceCubit>(context).resetMyAttendance();


  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<MyAttendanceCubit , MyAttendanceState>(builder: (context , state){
      return Scaffold(
          body: checkState(state)
      );
    });
  }
}
