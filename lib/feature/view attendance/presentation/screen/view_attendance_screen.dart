import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:technician/config/PrefHelper/helper.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/widgets/app_headline_widget.dart';
import 'package:technician/widgets/bar_widget.dart';

class ViewAttendanceScreen extends StatefulWidget {

  final String longitude;
  final String latitude;
  final String remMarks;
  final String date;
  final String time;
  final String checkType;
  final Color color;

  const ViewAttendanceScreen({super.key , required this.color , required this.checkType , required this.longitude , required this.latitude , required this.remMarks , required this.date , required this.time});

  @override
  State<ViewAttendanceScreen> createState() => _ViewAttendanceScreenState();
}

class _ViewAttendanceScreenState extends State<ViewAttendanceScreen> {

  EdgeInsets marginItem(){
    if(Helper.getCurrentLocal() == 'ar'){
      return EdgeInsets.only(left: 220.w , right: 20.w , top: 10.h , bottom: 10.h);
    }
    return EdgeInsets.only(right: 220.w , left: 20.w , top: 10.h , bottom: 10.h);
  }

  Widget screenWidget(){
    return ListView(
      children: [
        SizedBox(height: 30.h),
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
          ],
        ),
        //googleMapItem(),
        SizedBox(height: 400.h,),
        SizedBox(height: 20.h,),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15.w),
          child: AppHeadline(image: ''  , isSVGImage: false , addImage: false , title: 'attendanceType'.tr),

        ),
        Container(
          alignment:AlignmentDirectional.topStart ,
          margin: marginItem(),
          padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 16.0.w),
          decoration: BoxDecoration(
            color: widget.color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            widget.checkType,
            style: TextStyle(
              color: widget.color,
              fontWeight: FontWeight.w600,
              fontSize: 18.fSize

            ),
          ),
        ),
        SizedBox(height: 10.h,),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15.w),
          child: AppHeadline(image: ''  , isSVGImage: false , addImage: false , title: 'dateTime'.tr),

        ),
        SizedBox(height: 10.h,),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              Text(widget.date , style: TextStyle(fontSize: 18.fSize , fontWeight: FontWeight.w400),),
              SizedBox(width: 20.w,),
              Text(widget.time , style: TextStyle(fontSize: 18.fSize , fontWeight: FontWeight.w400),),
            ],
          ),
        ),
        SizedBox(height: 15.h,),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15.w),
          child: AppHeadline(image: ''  , isSVGImage: false , addImage: false , title: 'remarks'.tr),

        ),
        SizedBox(height: 10.h,),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(widget.remMarks , style: TextStyle(fontSize: 18.fSize , fontWeight: FontWeight.w400),),
        )

      ],
    );
  }

  Widget googleMapItem(){
    return SizedBox(
      width: double.infinity,
      height: 466.h,
      child: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(29.9773, 31.1325), // Coordinates for Giza, Egypt
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('marker1'),
            position: const LatLng(29.9773, 31.1325),
            infoWindow: const InfoWindow(title: "Pyramids"),
          ),
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenWidget(),
    );
  }
}
