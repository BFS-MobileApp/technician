
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:technician/config/PrefHelper/helper.dart';
import 'package:technician/config/PrefHelper/prefs.dart';
import 'package:technician/config/arguments/routes_arguments.dart';
import 'package:technician/config/routes/app_routes.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/app_consts.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/claims/data/models/claims_model.dart';
import 'package:technician/feature/claims/presentation/cubit/claims_cubit.dart';
import 'package:technician/feature/home/data/models/home_model.dart';
import 'package:technician/feature/home/presentation/cubit/home_cubit.dart';
import 'package:technician/feature/home/presentation/cubit/home_state.dart';
import 'package:technician/feature/home/presentation/widgets/home_card_item.dart';
import 'package:technician/feature/home/presentation/widgets/notification_home_item.dart';
import 'package:technician/widgets/access_denied_widget.dart';
import 'package:technician/widgets/app_headline_widget.dart';
import 'package:technician/widgets/error_widget.dart';
import 'package:technician/widgets/image_loader_widget.dart';
import 'package:technician/widgets/svg_image_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String userName = '';
  HomeModel? model;
  List<Datum> claimsModel = [];
  bool loadedData = false;


  @override
  void initState() {
    super.initState();
    getData();
  }


  setData(String name) {
    Future.delayed(const Duration(milliseconds: 50), () {
      if (mounted) {
        setState(() {
          userName = name;
        });
      }
    });
  }

  goToClaimScreen(int screenId) async{
    final result = await Navigator.pushNamed(context, Routes.claims , arguments: ClaimsArguments(screenId: screenId));
    if (result == true) {
      getData();
    }
  }

  Widget notificationIcon(){
    if(Prefs.isContain(AppStrings.userNotification) && Prefs.getBool(AppStrings.userNotification) == true){
      return InkWell(
        onTap: () => Navigator.pushNamed(context, Routes.notification),
        child: SVGImageWidget(
          image: AssetsManager.notification,
          width: 30.w,
          height: 30.h,
        ),
      );
    }
    return const SizedBox();
  }

  Widget homeWidget() {
    if(AppConst.readClaims){
      return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ensure it doesn't take infinite height
            children: [
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 200.w,
                      child: Text(
                        '${"welcome".tr}, $userName',
                        maxLines: 2,
                        style: TextStyle(
                          color: AppColors.headlineTextColor,
                          fontSize: 22.fSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(width: 8.w),
                    Row(
                      children: [
                        InkWell(
                          onTap: () => Navigator.pushNamed(context, Routes.myAttendance),
                          child: SVGImageWidget(
                            image: AssetsManager.locationIcon,
                            width: 26.w,
                            height: 26.h,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        notificationIcon(),
                        SizedBox(width: 10.w),
                        InkWell(
                          onTap: () => Navigator.pushNamed(context, Routes.editProfile),
                          child: Container(
                            width: 30.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(200),
                              child: ImageLoader(
                                imageUrl: Prefs.getString(AppStrings.image),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              AppHeadline(
                title: 'statisticsForYourClaims'.tr,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
              ),
              SizedBox(height: 10.h),
              Container(
                height: 450.h,
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HomeCardItem(
                          fontColor: '#ff44A4F2',
                          cardColor: const Color(0xFF44A4F2),
                          title: 'allClaims'.tr,
                          imageIcon: AssetsManager.allClaims,
                          value: model!.data.claims.all.toString(),
                          onTap: (){
                            goToClaimScreen(0);
                          },
                        ),
                        SizedBox(width: 5.w), // Add spacing
                        HomeCardItem(
                          cardColor: const Color(0xFFFF9500),
                          fontColor: model!.data.claimColor.claimColorNew,
                          title: 'newClaims'.tr,
                          imageIcon: AssetsManager.newClaims,
                          value: model!.data.claims.claimsNew.toString(),
                          onTap: (){
                            goToClaimScreen(1);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HomeCardItem(
                          cardColor: const Color(0xFF3716EE),
                          fontColor: model!.data.claimColor.assigned,
                          title: 'assignedClaims'.tr,
                          imageIcon: AssetsManager.assignedClaims,
                          value: model!.data.claims.assigned.toString(),
                          onTap: (){
                            goToClaimScreen(2);
                          },
                        ),
                        SizedBox(width: 5.w), // Add spacing
                        HomeCardItem(
                          cardColor: const Color(0xFF10D2C8),
                          fontColor: model!.data.claimColor.started,
                          title: 'startedClaims'.tr,
                          imageIcon: AssetsManager.startedClaims,
                          value: model!.data.claims.inProgress.toString(),
                          onTap: (){
                            goToClaimScreen(3);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HomeCardItem(
                          cardColor: const Color(0xFF0A562E),
                          fontColor: model!.data.claimColor.completed,
                          title: 'completedClaims'.tr,
                          imageIcon: AssetsManager.completedClaims,
                          value: '1',
                          onTap: (){
                            goToClaimScreen(4);
                          },
                        ),
                        SizedBox(width: 5.w),
                        HomeCardItem(
                          cardColor: const Color(0xFFFF0000),
                          fontColor: model!.data.claimColor.cancelled,
                          title: 'cancelledClaims'.tr,
                          imageIcon: AssetsManager.canceledClaims,
                          value: model!.data.claims.cancelled.toString(),
                          onTap: (){
                            goToClaimScreen(5);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        HomeCardItem(
                          cardColor: const Color(0xFF679C0D),
                          fontColor: model!.data.claimColor.closed,
                          title: 'closedClaims'.tr,
                          imageIcon: AssetsManager.closedClaims,
                          value: model!.data.claims.closed.toString(),
                          onTap: (){
                            goToClaimScreen(6);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              claimsModel.isNotEmpty ? NotificationHomeItem(
                model: claimsModel,
              ) : const SizedBox(),
            ],
          ),
        ),
      );
    } else {
      if(loadedData){
        return const AccessDeniedWidget();
      }
      return const Center(child: CircularProgressIndicator(color: AppColors.mainColor,),);
    }
  }

  setColors(){
    model!.data.claimColor.toMap().forEach((status, color) {
      Helper.setStatusColors(color, status);
    });
  }


  Widget checkState(HomeState state){
    if(state is HomeIsLoading){
      return const Center(child: CircularProgressIndicator(color: AppColors.mainColor,),);
    } else if(state is HomeError){
      return ErrorWidgetItem(onTap: ()=>getData());
    } else if(state is HomeLoaded) {
      print('here');
      Helper.setPermissionRoles(state.userInfo.permissions);
      setData(state.userInfo.name);
      BlocProvider.of<HomeCubit>(context).getClaimsInfo();
      return const Center(child: CircularProgressIndicator(color: AppColors.mainColor,),);
    } else if(state is ClaimsLoaded){
      model = state.homeModel;
      loadedData = true;
      setColors();
      print(model!.data.claims.completed.toString());
      return homeWidget();
    } else {
      return homeWidget();
    }
  }

  void sortList() {
    if (claimsModel.isNotEmpty && claimsModel.length > 1) {
      claimsModel.sort((a, b) {
        Map<String, int> priorityOrder = {};
        int priorityA = 0;
        int priorityB = 0;
        if (Helper.getCurrentLocal() == 'US') {
          priorityOrder = {
            "urgent": 0,
            "high": 1,
            "medium": 2,
            "normal": 3,
            "low": 4
          };
        } else {
          priorityOrder = {
            "عاجل": 0,
            "مرتفع": 1,
            "متوسط": 2,
            "عادي": 3,
            "منخفض": 4
          };
        }
        if(Helper.getCurrentLocal() == 'US'){
           priorityA = priorityOrder[a.priority.toLowerCase()] ?? 4;
           priorityB = priorityOrder[b.priority.toLowerCase()] ?? 4;
        } else {
           priorityA = priorityOrder[a.priority.toLowerCase()] ?? 4;
           priorityB = priorityOrder[b.priority.toLowerCase()] ?? 4;
        }
        return priorityA.compareTo(priorityB);
      });
    }
  }


  getData(){
    setState(() {
      loadedData = false;
    });
    final data = {
      "status":"assigned",
      "per_page":"200"
    };
    BlocProvider.of<ClaimsCubit>(context).getStartedClaims(data).then((val){
      setState(() {
        claimsModel = val!.data;
      });
      sortList();
      BlocProvider.of<HomeCubit>(context).getUserInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<HomeCubit , HomeState>(builder: (context , state){
      return Scaffold(
          body: checkState(state)
      );
    });
  }
}
