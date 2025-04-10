import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:technician/config/PrefHelper/prefs.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/add%20attendance/presentation/cubit/add_attendance_cubit.dart';
import 'package:technician/widgets/app_headline_widget.dart';
import 'package:technician/widgets/bar_widget.dart';
import 'package:technician/widgets/image_loader_widget.dart';
import 'package:technician/widgets/message_widget.dart';
import 'package:technician/widgets/svg_image_widget.dart';

class AddAttendanceScreen extends StatefulWidget {
  const AddAttendanceScreen({super.key});

  @override
  State<AddAttendanceScreen> createState() => _AddAttendanceScreenState();
}

class _AddAttendanceScreenState extends State<AddAttendanceScreen> {

  final String formattedDate = DateFormat('EEEE, MMM dd, yyyy').format(DateTime.now());
  bool checkIn = false , checkOut = false;
  String image = '' , userName = '';
  late Timer _timer;
  String _formattedTime = '' , checkInCurrentTime = '' , checkOutCurrentTime = '';
  TextEditingController remarksController = TextEditingController();
  double latitude = 0 , longitude = 0;



  @override
  void initState() {
    super.initState();
    getUserImage();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  void _updateTime() {
    final now = DateTime.now();
    final hour = now.hour % 12 == 0 ? 12 : now.hour % 12; // Convert to 12-hour format
    final amPm = now.hour >= 12 ? 'PM' : 'AM';
    setState(() {
      _formattedTime = '${_formatNumber(hour)}:${_formatNumber(now.minute)} $amPm';
    });
  }


  String _formatNumber(int number) {
    return number < 10 ? '0$number' : '$number';
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  getUserImage(){
    setState(() {
      image = Prefs.getString(AppStrings.image);
      userName = Prefs.getString(AppStrings.userName);
    });
  }

  void updateCheckInTime() {
    setState(() {
      checkIn = true;
      checkInCurrentTime = DateFormat('hh:mm a').format(DateTime.now());
    });
  }

  void updateCheckOutTime() {
    setState(() {
      checkOut = true;
      checkOutCurrentTime = DateFormat('hh:mm a').format(DateTime.now());
    });
  }

  Widget screenWidget(){
    return ListView(
      children: [
        SizedBox(height: 50.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: AppBarItem(
                title: 'addAttendance'.tr,
                image: AssetsManager.backIcon2,
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 100.w,
                height: 100.h,
                decoration:  BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  shape: BoxShape.circle, // Makes the container circular
                ),
                child: Center(
                  child: ClipOval( // Ensures the profile image is circular
                    child: ImageLoader(
                      imageUrl: image,
                      width: 80.w,
                      height: 80.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20.w,),
              Column(
                children: [
                  Text(userName , style: TextStyle(fontSize: 20.fSize , fontWeight: FontWeight.w700 ,color: Theme.of(context).textTheme.bodySmall!.color),),
                  SizedBox(height: 5.h,),
                  Text('Technician'.tr , style: TextStyle(fontSize: 16.fSize , fontWeight: FontWeight.w500 ,color: Theme.of(context).textTheme.bodySmall!.color),),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 20.h),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              formattedDate,
              style: TextStyle(
                fontSize: 25.fSize,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
            SizedBox(height: 8.h), // Space between date and time
            Text(
              _formattedTime,
              style: TextStyle(
                fontSize: 30.fSize,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text('checkIn'.tr , style: TextStyle(fontSize: 25.fSize , color: const Color(0xFF00A800) , fontWeight: FontWeight.w500),),
                checkIn ? Text(checkInCurrentTime , style: TextStyle(fontSize: 25.fSize , color: const Color(0xFF00A800) , fontWeight: FontWeight.w500),) : Text('--:--' , style: TextStyle(fontSize: 25.fSize , color: const Color(0xFF00A800) , fontWeight: FontWeight.w500),),
              ],
            ),
            Column(
              children: [
                Text('checkOut'.tr , style: TextStyle(fontSize: 25.fSize , color: Colors.redAccent , fontWeight: FontWeight.w500),),
                checkOut ? Text(checkOutCurrentTime , style: TextStyle(fontSize: 25.fSize , color: Colors.redAccent , fontWeight: FontWeight.w500),) : Text('--:--' , style: TextStyle(fontSize: 25.fSize , color: Colors.redAccent , fontWeight: FontWeight.w500),),
              ],
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15.w),
          child: AppHeadline(image: ''  , isSVGImage: false , addImage: false , title: 'remarks'.tr),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15.0), // Reduced horizontal margin
          child: TextField(
            style: const TextStyle(color: Colors.black),
            controller: remarksController,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelText: 'typeYourRemarksHere'.tr,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide:  BorderSide(color: Theme.of(context).textTheme.bodyMedium!.color!),
              ),
            ),
          ),
        ),
        SizedBox(height: 50.h,),
        /*Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: SwipeButton(
            borderRadius: BorderRadius.circular(8),
            activeTrackColor: const Color(0xFF00A800),
            activeThumbColor: Colors.white,
            thumbPadding: EdgeInsets.symmetric(horizontal: 10.w , vertical: 10.h),
            height: 60.h,
            child: Center(
              child: Text(
                "swipeRight".tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.fSize
                ),
              ),
            ),
            onSwipe: () {
              if(remarksController.value.text.isEmpty){
                MessageWidget.showSnackBar("pleaseAddRemarksFirst".tr, AppColors.errorColor);
                return;
              }
              _getUserLocation(true);
            },
          ),
        ),
        SizedBox(height: 20.h,),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: Directionality(
            textDirection: dir.TextDirection.rtl,
            child: SwipeButton(
              thumbPadding: EdgeInsets.symmetric(horizontal: 10.w , vertical: 10.h),
              borderRadius: BorderRadius.circular(8),
              activeTrackColor: Colors.red,
              activeThumbColor: Colors.white,
              height: 60.h,
              child: Center(
                child: Text(
                  "swipeLeft".tr, // Localized text
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.fSize,
                  ),
                ),
              ),
              onSwipe: () {
                if (remarksController.value.text.isEmpty) {
                  MessageWidget.showSnackBar("pleaseAddRemarksFirst".tr, AppColors.errorColor);
                  return;
                }
                _getUserLocation(false);
              },
            ),
          ),
        ),*/
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            checkInButton(),
            checkOutButton()
          ],
        )
      ],
    );
  }

  Future<void> _getUserLocation(bool isCheckIn) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      MessageWidget.showSnackBar("pleaseEnableLocationFirst".tr, AppColors.errorColor);
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        MessageWidget.showSnackBar("pleaseEnableLocationFirst".tr, AppColors.errorColor);
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      MessageWidget.showSnackBar("pleaseEnableLocationFirst".tr, AppColors.errorColor);
      return Future.error('Location permissions are permanently denied.');
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
    if(isCheckIn){
      BlocProvider.of<AddAttendanceCubit>(context).checkIn(longitude.toString(), latitude.toString(), remarksController.value.text.toString()).then((value){
        if(value){
          remarksController.clear();
        }
      });
    } else {
      BlocProvider.of<AddAttendanceCubit>(context).checkOut(longitude.toString(), latitude.toString(), remarksController.value.text.toString()).then((value){
        if(value){
          remarksController.clear();
        }
      });
    }
    if(isCheckIn){
      updateCheckInTime();
    } else {
      updateCheckOutTime();
    }

  }

  Widget checkInButton() {
    return GestureDetector(
      onTap: (){
        if(remarksController.value.text.isEmpty){
          MessageWidget.showSnackBar("pleaseAddRemarksFirst".tr, AppColors.errorColor);
          return;
        }
        _getUserLocation(true);
      },
      child: Container(
        width: 150.w,
        height: 150.h,
        decoration: const BoxDecoration(
          color: Color(0xFF00A800),
          shape: BoxShape.circle,
        ),
        child: Center( // This centers the Column within the circle
          child: Column(
            mainAxisSize: MainAxisSize.min, // Shrinks the column to fit its children
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SVGImageWidget(
                image: AssetsManager.checkInIcon,
                width: 60.w,
                height: 60.h,
              ),
              const SizedBox(height: 8), // Space between the image and text
              Text(
                'checkIn'.tr,
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 20.fSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget checkOutButton(){
    return GestureDetector(
      onTap: (){
        if(remarksController.value.text.isEmpty){
          MessageWidget.showSnackBar("pleaseAddRemarksFirst".tr, AppColors.errorColor);
          return;
        }
        _getUserLocation(false);
      },
      child: Container(
        width: 150.w,
        height: 150.h,
        decoration: const BoxDecoration(
          color: Color(0xFFFF0000),
          shape: BoxShape.circle, // Makes the container circular
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SVGImageWidget(image: AssetsManager.checkOutIcon, width: 60.w, height: 60.h),
              SizedBox(height: 15.h,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                child: Text('checkOut'.tr , style: TextStyle(color: AppColors.whiteColor , fontSize: 20.fSize , fontWeight: FontWeight.w500),),
              )
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: screenWidget(),
    ), onWillPop: () async{
          return true;
    });
  }
}


/*
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
checkInButton(),
checkOutButton()
],
)*/
