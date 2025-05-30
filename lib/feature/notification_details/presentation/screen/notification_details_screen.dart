import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../config/PrefHelper/helper.dart';

import 'package:technician/config/arguments/routes_arguments.dart';
import 'package:technician/config/routes/app_routes.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/claim%20details/data/models/claim_details_model.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/claim_details_card_item.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/claim_details_describtion_item.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/claim_details_id_widget.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/claim_details_status_widget.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/claim_details_text_item.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/replies_widget.dart';
import 'package:technician/feature/notification_details/presentation/cubit/notification_details_cubit.dart';
import 'package:technician/feature/notification_details/presentation/cubit/notification_details_state.dart';
import 'package:technician/widgets/aligment_widget.dart';
import 'package:technician/widgets/all_files_widget.dart';
import 'package:technician/widgets/app_headline_widget.dart';
import 'package:technician/widgets/bar_widget.dart';
import 'package:technician/widgets/error_widget.dart';
import 'package:technician/widgets/svg_image_widget.dart';

import '../../../login/presentation/screen/login_screen.dart';

class NotificationDetailsScreen extends StatefulWidget {

  final String referenceId;
  final String claimId;
  const NotificationDetailsScreen({super.key , required this.referenceId , required this.claimId});

  @override
  State<NotificationDetailsScreen> createState() => _NotificationDetailsScreenState();
}

class _NotificationDetailsScreenState extends State<NotificationDetailsScreen> {

  ClaimDetailsModel? claimDetailsModel;
  AlignmentWidget alignmentWidget = AlignmentWidget();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData()=>BlocProvider.of<NotificationDetailsCubit>(context).getNotificationDetails(widget.referenceId);

  Widget _buildClaimCard() {
    return ClaimDetailsCardItem(cardChildWidget: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClaimDetailsIdWidget(id: claimDetailsModel!.data.referenceId),
        ClaimDetailsTextItem(itemName: 'buildingId'.tr, itemValue: claimDetailsModel!.data.id.toString() , isClickable: false, type: '',),
        ClaimDetailsTextItem(itemName: 'building'.tr, itemValue: claimDetailsModel!.data.unit.building , isClickable: false, type: '',),
        ClaimDetailsTextItem(itemName: 'propertyUnit'.tr, itemValue: claimDetailsModel!.data.unit.name , isClickable: false, type: '',),
        ClaimDetailsTextItem(itemName: 'claimCategory'.tr, itemValue: claimDetailsModel!.data.category.name , isClickable: false, type: '',),
        ClaimDetailsTextItem(itemName: 'claimSubCategory'.tr, itemValue: claimDetailsModel!.data.subCategory.name , isClickable: false, type: '',),
        ClaimDetailsTextItem(itemName: 'claimType'.tr, itemValue: claimDetailsModel!.data.type.name , isClickable: false, type: '',),
        ClaimDetailsTextItem(itemName: 'createdAt'.tr, itemValue: Helper.convertSecondsToDate(claimDetailsModel!.data.createdAt.toString()) , isClickable: false, type: '',),
        ClaimDetailsTextItem(itemName: 'availableTime'.tr, itemValue: '${Helper.convertSecondsToDate(claimDetailsModel!.data.availableDate.toString())} - ${Helper.getAvailableTime(claimDetailsModel!.data.availableTime)}' , isClickable: false, type: '',),
        ClaimDetailsTextItem(itemName: 'assignTo'.tr, itemValue: employeeName() , isClickable: false, type: '',),
        ClaimDetailsStatusWidget(itemName: 'priority'.tr, isStatus: false, itemValue: claimDetailsModel!.data.priority),
        ClaimDetailsStatusWidget(itemName: 'status'.tr, isStatus: true, itemValue: claimDetailsModel!.data.status),
        ClaimDetailsDescriptionItem(itemValue: claimDetailsModel!.data.description),
        AllFilesWidget(images: claimDetailsModel!.data.comments,files: claimDetailsModel!.data.files,ifUpdate: false,claimId: widget.claimId,)
      ],
    ));
  }

  String employeeName() {
    if (claimDetailsModel!.data.employees.isEmpty) {
      return 'notAssigned'.tr;
    }
    Employee latestEmployee = claimDetailsModel!.data.employees.reduce((a, b) {
      return DateTime.parse(a.created_at).isAfter(DateTime.parse(b.created_at)) ? a : b;
    });
    return latestEmployee.name;
  }

  Widget _userInfoWidget(){
    return ClaimDetailsCardItem(cardChildWidget: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClaimDetailsTextItem(itemName: 'createdBy'.tr, itemValue: claimDetailsModel!.data.creator.data.name , isClickable: false, type: '',),
        ClaimDetailsTextItem(itemName: 'phoneNumber'.tr, itemValue: claimDetailsModel!.data.creator.data.mobile , isClickable: true, type: AppStrings.tel,),
        ClaimDetailsTextItem(itemName: 'emailAddress'.tr, itemValue: claimDetailsModel!.data.creator.data.email , isClickable: true, type: AppStrings.email,),
      ],
    ));
  }

  Widget _detailsWidget(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          children: [
            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: AppBarItem(
                    title: 'claimDetails'.tr,
                    image: AssetsManager.backIcon2,
                  ),
                ),
                GestureDetector(
                  onTap: ()=>Navigator.pushNamed(context , Routes.technicianHistory , arguments: TechnicianHistoryArguments(logList: claimDetailsModel!.data.logs, employeesList: claimDetailsModel!.data.employees , timeList: claimDetailsModel!.data.times)),
                  child: SVGImageWidget(image: AssetsManager.timeHistory,width: 32.w,height: 32.h,),
                ),
              ],
            ),
            SizedBox(height: 20.h,),
            _userInfoWidget(),
            SizedBox(height: 5.h,),
            _buildClaimCard(),
            SizedBox(height: 10.h,),
            AppHeadline(title: 'replies'.tr,),
            RepliesWidget(claimType: 5 ,ctx: context , submitOnly: false , comments: claimDetailsModel!.data.comments,claimId: widget.claimId,status: claimDetailsModel!.data.status),
            SizedBox(height: 10.h,),
          ],
        ),
      ),
    );
  }

  Widget checkState(NotificationDetailsState state){
    if(state is NotificationDetailsIsLoading){
      return const Center(child: CircularProgressIndicator(color: AppColors.mainColor,),);
    } else if(state is NotificationDetailsError){
      bool isUnauthenticated = state.error.contains('Unauthenticated.');
      return ErrorWidgetItem(onTap: (){
        if(isUnauthenticated){
          Get.offAll(const LoginScreen());
        }else{
          getData();
        }
      },
        isUnauthenticated: isUnauthenticated,
      );
    } else if(state is NotificationDetailsLoaded) {
      claimDetailsModel = state.model;
      return _detailsWidget();
    } else {
      return _detailsWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationDetailsCubit , NotificationDetailsState>(builder: (context , state){
      return Scaffold(
          body: checkState(state)
      );
    });
  }
}
