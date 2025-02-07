import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';

class TimelineItem extends StatelessWidget {
  final String status;
  final String dateTime;
  final String user;
  final Color color;
  final bool isLeft;
  final String image;

  const TimelineItem({
    super.key,
    required this.status,
    required this.dateTime,
    required this.user,
    required this.color,
    required this.isLeft,
    required this.image
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16.0.h),
        child: Stack(
          //alignment: Alignment.center,
          children: [
            Row(
              children: [
                if (isLeft)
                  Expanded(
                    child: buildContent(context, CrossAxisAlignment.end),
                  ),
                SizedBox(width: 27.w), // Spacer for alignment
                if (!isLeft)
                  Expanded(
                    child: buildContent(context, CrossAxisAlignment.start),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCircle() {
    return Container(
      padding: EdgeInsets.all(6.adaptSize),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        color: color.withOpacity(0.15)
      ),
      child: SvgPicture.asset(
        image,
        width: 25.w,
        height: 25.h,
      ),
    );
  }

  Widget buildContent(BuildContext context, CrossAxisAlignment alignment) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        margin: !isLeft ? EdgeInsets.only(right: 25.w) : EdgeInsets.only(left: 25.w),
        child: Column(
          crossAxisAlignment: alignment,
          children: [
            isLeft ? Row(
              //mainAxisAlignment:MainAxisAlignment.end ,
              children: [
                Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 150.w),
                      child: Divider(color: color,),
                    )
                ),
                buildCircle(),
                SizedBox(width: 5.w,),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 16.fSize,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ) : Row(
              //mainAxisAlignment:MainAxisAlignment.start ,
              children: [
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 16.fSize,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                SizedBox(width: 5.w,),
                buildCircle(),
                Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 150.w),
                      child: Divider(color: color,),
                    )
                )
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              dateTime,
              style: TextStyle(fontSize: 14.fSize, color: Colors.black54),
            ),
            SizedBox(height: 4.h),
            SizedBox(
              width: 85, // Set your desired width
              child: Text(
                user,
                style: TextStyle(fontSize: 14.fSize, color: Colors.black54),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )

          ],
        ),
      ),
    );
  }
}


// Sample data for timeline
final List<Map<String, dynamic>> timelineData = [
  {
    'status': 'New',
    'dateTime': '11/11/2024 7:00 AM',
    'user': 'User 1',
    'color': Colors.yellow,
    'image':AssetsManager.newClaims
  },
  {
    'status': 'Assigned',
    'dateTime': '11/11/2024 7:00 AM',
    'user': 'User 1',
    'color': Colors.blue,
    'image':AssetsManager.assignedClaims
  },
  {
    'status': 'Started',
    'dateTime': '11/11/2024 7:00 AM',
    'user': 'User 1',
    'color': Colors.cyan,
    'image':AssetsManager.startedClaims
  },
  {
    'status': 'Completed',
    'dateTime': '11/11/2024 7:00 AM',
    'user': 'User 1',
    'color': Colors.green,
    'image':AssetsManager.completedClaims
  },
  {
    'status': 'Closed',
    'dateTime': '11/11/2024 7:00 AM',
    'user': 'User 1',
    'color': Colors.green,
    'image':AssetsManager.closedClaims
  },
  {
    'status': 'Canceled',
    'dateTime': '11/11/2024 7:00 AM',
    'user': 'User 1',
    'color': Colors.red,
    'image':AssetsManager.canceledClaims
  },
];

