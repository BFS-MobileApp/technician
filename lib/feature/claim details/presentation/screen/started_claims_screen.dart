import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:technician/config/PrefHelper/helper.dart';
import 'package:technician/config/arguments/routes_arguments.dart';
import 'package:technician/config/routes/app_routes.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/claim%20details/data/models/claim_details_model.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/assign_button.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/claim_details_card_item.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/claim_details_describtion_item.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/claim_details_id_widget.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/claim_details_status_widget.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/claim_details_text_item.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/complete_button.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/priority_button.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/replies_widget.dart';
import 'package:technician/widgets/aligment_widget.dart';
import 'package:technician/widgets/all_files_widget.dart';
import 'package:technician/widgets/app_headline_widget.dart';
import 'package:technician/widgets/bar_widget.dart';
import 'package:technician/widgets/error_widget.dart';
import 'package:technician/widgets/svg_image_widget.dart';

import '../cubit/claim_details_cubit.dart';

class StartedClaimsScreen extends StatefulWidget {
  String claimId;
  String referenceId;
  StartedClaimsScreen({super.key , required this.referenceId , required this.claimId});

  @override
  State<StartedClaimsScreen> createState() => _StartedClaimsScreenState();
}

class _StartedClaimsScreenState extends State<StartedClaimsScreen> {

  ClaimDetailsModel? claimDetailsModel;
  AlignmentWidget alignmentWidget = AlignmentWidget();
  String btName = '';

  @override
  void initState() {
    super.initState();
    getData();
  }


  checkEndDate() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      bool hasEmptyEndDate = claimDetailsModel!.data.times.any((record) => record.endOn == '');
      if(hasEmptyEndDate){
        setState(() {
          btName = 'endWork'.tr;
        });
      } else {
        setState(() {
          btName = 'startWork'.tr;
        });
      }
    });
  }

  getData()=>BlocProvider.of<ClaimDetailsCubit>(context).getClaimDetails(widget.referenceId);

  Widget _buildClaimCard() {
    return ClaimDetailsCardItem(cardChildWidget: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClaimDetailsIdWidget(id: claimDetailsModel!.data.referenceId),
        ClaimDetailsTextItem(itemName: 'unit'.tr, itemValue: claimDetailsModel!.data.unit.building+' - '+claimDetailsModel!.data.unit.name , isClickable: false, type: '',),
        //ClaimDetailsTextItem(itemName: 'building'.tr, itemValue: claimDetailsModel!.data.unit.building , isClickable: false, type: '',),
        //ClaimDetailsTextItem(itemName: 'propertyUnit'.tr, itemValue: claimDetailsModel!.data.unit.name , isClickable: false, type: '',),
        ClaimDetailsTextItem(itemName: 'type'.tr, itemValue: claimDetailsModel!.data.category.name+'-'+claimDetailsModel!.data.subCategory.name+'-'+claimDetailsModel!.data.type.name , isClickable: false, type: '',),
        ClaimDetailsStatusWidget(itemName: 'status'.tr, isStatus: true, itemValue: claimDetailsModel!.data.status),
        //ClaimDetailsTextItem(itemName: 'claimSubCategory'.tr, itemValue: claimDetailsModel!.data.subCategory.name , isClickable: false, type: '',),
        //ClaimDetailsTextItem(itemName: 'claimType'.tr, itemValue: claimDetailsModel!.data.type.name , isClickable: false, type: '',),
        //ClaimDetailsTextItem(itemName: 'createdAt'.tr, itemValue: Helper.convertSecondsToDate(claimDetailsModel!.data.createdAt.toString()) , isClickable: false, type: '',),
        //ClaimDetailsTextItem(itemName: 'assignTo'.tr, itemValue: employeeName() , isClickable: false, type: '',),
        ClaimDetailsStatusWidget(itemName: 'priority'.tr, isStatus: false, itemValue: claimDetailsModel!.data.priority),
        ClaimDetailsTextItem(itemName: 'availableTime'.tr, itemValue: '${Helper.convertSecondsToDate(claimDetailsModel!.data.availableDate.toString())} - ${Helper.getAvailableTime(claimDetailsModel!.data.availableTime)}' , isClickable: false, type: '',),
        //ClaimDetailsStatusWidget(itemName: 'status'.tr, isStatus: true, itemValue: claimDetailsModel!.data.status),
        ClaimDetailsDescriptionItem(itemValue: claimDetailsModel!.data.description),
        AllFilesWidget(images: claimDetailsModel!.data.files,)
      ],
    ));
  }

  Widget _statusInfoWidget(){
    return ClaimDetailsCardItem(cardChildWidget: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClaimDetailsStatusWidget(itemName: 'status'.tr, isStatus: true, itemValue: claimDetailsModel!.data.status),
        ClaimDetailsTextItem(itemName: 'assignTo'.tr, itemValue: employeeName() , isClickable: false, type: '',),
      ],
    ));
  }

  Widget _userInfoWidget(){
    return ClaimDetailsCardItem(cardChildWidget: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClaimDetailsTextItem(itemName: 'createdAt'.tr, itemValue: Helper.convertSecondsToDate(claimDetailsModel!.data.createdAt.toString()) , isClickable: false, type: '',),
        ClaimDetailsTextItem(itemName: 'createdBy'.tr, itemValue: claimDetailsModel!.data.creator.data.name , isClickable: false, type: '',),
        ClaimDetailsTextItem(itemName: 'phoneNumber'.tr, itemValue: claimDetailsModel!.data.creator.data.mobile , isClickable: true, type: AppStrings.tel,),
        ClaimDetailsTextItem(itemName: 'emailAddress'.tr, itemValue: claimDetailsModel!.data.creator.data.email , isClickable: true, type: AppStrings.email,),
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

  Widget _detailsWidget(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Container(
          color: AppColors.offWhite,
          child: Column(
            
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
                    child: SVGImageWidget(image: AssetsManager.timeHistory,width: 35.w,height: 35.h,),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    
                    // SizedBox(height: 20.h,),
                    _buildClaimCard(),
                    SizedBox(height: 5.h,),
                    _userInfoWidget(),
                    SizedBox(height: 5.h,),
                    _statusInfoWidget(),
                    SizedBox(height: 10.h,),
                    AppHeadline(title: 'replies'.tr,),
                    RepliesWidget(claimType: 2 ,ctx: context , submitOnly: false , comments: claimDetailsModel!.data.comments,claimId: widget.claimId,status: claimDetailsModel!.data.status),
                    _techWorkButtons(),
                    SizedBox(height: 10.h,),
                    PriorityButton(claimId: widget.claimId,referenceId: widget.referenceId,ctx: context),
                    SizedBox(height: 10.h,),
                    CompleteButton(ctx: context, claimId: widget.claimId, referenceId: widget.referenceId,),
                    SizedBox(height: 10.h,),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }

  Widget _techWorkButtons(){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h , horizontal: 8.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              BlocProvider.of<ClaimDetailsCubit>(context).startAndEndWork(widget.claimId).then((value){
                if(value){
                  getData();
                }
              });
            },
            child: AssignButton(borderColor: AppColors.mainColor , horizontalMargin: 0 , btText: btName , image: '',width: 125 , height: 40 , btColor: AppColors.whiteColor , btTextColor: AppColors.mainColor,),
          ),
        ],
      ),
    );
  }

  Widget checkState(ClaimDetailsState state){
    if(state is ClaimDetailsIsLoading){
      return const Center(child: CircularProgressIndicator(color: AppColors.mainColor,),);
    } else if(state is ClaimDetailsError){
      return ErrorWidgetItem(onTap: ()=>getData());
    } else if(state is ClaimDetailsLoaded) {
      claimDetailsModel = state.model;
      checkEndDate();
      return _detailsWidget();
    } else if(state is AssignedClaimLoaded){
      return _detailsWidget();
    } else {
      return _detailsWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClaimDetailsCubit , ClaimDetailsState>(builder: (context , state){
      return Scaffold(
          body: checkState(state)
      );
    });
  }
}
