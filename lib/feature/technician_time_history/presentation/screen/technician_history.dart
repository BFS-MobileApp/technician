import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../config/PrefHelper/helper.dart';

import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/claim%20details/data/models/claim_details_model.dart';
import 'package:technician/feature/technician_time_history/presentation/widgets/time_line_painter.dart';
import 'package:technician/feature/technician_time_history/presentation/widgets/time_line_widget.dart';
import 'package:technician/widgets/bar_widget.dart';
import 'package:technician/widgets/image_loader_widget.dart';

class TechnicianHistory extends StatefulWidget {

  final List<Employee> employeeList;
  final List<Log> logList;
  final List<Time> timeList;

  const TechnicianHistory({super.key , required this.employeeList , required this.logList , required this.timeList});

  @override
  State<TechnicianHistory> createState() => _TechnicianHistoryState();
}

class _TechnicianHistoryState extends State<TechnicianHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final GlobalKey _timelineKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Add listener to detect swipe changes
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {}); // This ensures UI updates when user swipes
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          AppBarItem(title: 'history'.tr),
          _buildCustomTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Stack(
                    children: [
                      // CustomPainter for the continuous line
                      Positioned.fill(
                        child: CustomPaint(
                          painter: TimelineLinePainter(timelineKey: _timelineKey , logList: widget.logList),
                        ),
                      ),
                      ListView.builder(
                        key: _timelineKey, // Assign the key to the ListView
                        itemCount: widget.logList.length,
                        itemBuilder: (context, index) {
                          final item = widget.logList[index];
                          final isLeft = index % 2 == 0; // Left for odd indices, right for even
                          return TimelineItem(
                            status: item.name,
                            dateTime: Helper.removeSeconds(item.createdAt),
                            user: item.createdBy.name,
                            color: Helper.getLogColor(item.name),
                            image: Helper.getLogImage(item.name),
                            isLeft: !isLeft,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                widget.timeList.isEmpty? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AssetsManager.noDataImage, width: 80.w, height: 80.h),
                    Text(
                      'noData'.tr,
                      style: TextStyle(
                        fontSize: 20.fSize,
                        color: AppColors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ) :
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 10.0.w),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(''),
                          Text(
                            'startOn'.tr,
                            style: TextStyle(
                                fontSize: 17.fSize,
                                fontWeight: FontWeight.w700,
                                color: AppColors.mainColor),
                          ),
                          Text(
                            'endOn'.tr,
                            style: TextStyle(
                                fontSize: 17.fSize,
                                fontWeight: FontWeight.w700,
                                color: AppColors.mainColor),
                          ),
                          Text(
                            'duration'.tr,
                            style: TextStyle(
                                fontSize: 17.fSize,
                                fontWeight: FontWeight.w700,
                                color: AppColors.mainColor),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 610.h,
                        child: ListView.builder(itemCount: widget.timeList.length , itemBuilder: (ctx , pos){
                          return buildRow(widget.timeList[pos].createdBy.avatar,Helper.extractDate(widget.timeList[pos].startOn) , Helper.extractTime(widget.timeList[pos].startOn), Helper.extractDate(widget.timeList[pos].endOn) , Helper.extractTime(widget.timeList[pos].endOn), Helper.calculateDuration(widget.timeList[pos].startOn , widget.timeList[pos].endOn));
                        }),
                      )
                    ],
                  ),
                ),
                _buildStaffGrid(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRow(String userImage, String startDate, String startTime, String endDate, String endTime, String duration) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ImageLoader(imageUrl: userImage , width: 25.w,height: 25.h,),
          SizedBox(width: 17.0.w), // Dynamic width
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                startDate,
                style: TextStyle(fontSize: 14.fSize, fontWeight: FontWeight.w500),
              ),
              Text(
                startTime,
                style: TextStyle(fontSize: 14.fSize, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(width: 45.0.w), // Dynamic width
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                endDate,
                style: TextStyle(fontSize: 14.fSize, fontWeight: FontWeight.w500),
              ),
              Text(
                endTime,
                style: TextStyle(fontSize: 14.fSize, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(width: 40.0.w), // Dynamic width
          Text(
            duration,
            style: TextStyle(fontSize: 14.fSize, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomTabBar() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 1.w),
      child: TabBar(
        indicator: const BoxDecoration(),
        controller: _tabController,
        labelPadding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
        labelColor: AppColors.primaryColor,
        unselectedLabelColor: Colors.black12,
        tabs: [
          _buildTab('timeline'.tr, 0),
          _buildTab('workingHours'.tr, 1),
          _buildTab('staff'.tr, 2),
        ],
      ),
    );
  }

  Widget _buildTab(String text, int index) {
    return GestureDetector(
      onTap: () {
        _tabController.animateTo(index);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: _tabController.index == index
              ? const Color(0xFFEBEBEB)
              : const Color(0xFFFEFEFE),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _tabController.index == index
                ? AppColors.mainColor
                : Colors.grey,
            width: 1,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13.fSize,
            fontWeight: FontWeight.w600,
            color: _tabController.index == index
                ? AppColors.mainColor
                : Colors.black12,
          ),
        ),
      ),
    );
  }

  Widget _buildStaffGrid() {
    if(widget.employeeList.isEmpty){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AssetsManager.noDataImage, width: 80.w, height: 80.h),
          Text(
            'noData'.tr,
            style: TextStyle(
              fontSize: 20.fSize,
              color: AppColors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    }
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: GridView.builder(
        itemCount: widget.employeeList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          return _buildStaffCard(index);
        },
      ),
    );
  }

  Widget _buildStaffCard(int index) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageLoader(imageUrl: widget.employeeList[index].imageUrl , width: 50.w,height: 50.h,),
          SizedBox(height: 8.h),
          Text(
            widget.employeeList[index].name,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15.fSize,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}