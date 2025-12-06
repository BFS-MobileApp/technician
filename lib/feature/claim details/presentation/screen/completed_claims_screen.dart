import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../config/PrefHelper/helper.dart';

import 'package:technician/config/arguments/routes_arguments.dart';
import 'package:technician/config/routes/app_routes.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/app_consts.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/claim%20details/data/models/claim_details_model.dart';
import 'package:technician/feature/claim%20details/presentation/cubit/claim_details_cubit.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/claim_details_card_item.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/claim_details_describtion_item.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/claim_details_id_widget.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/claim_details_status_widget.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/claim_details_text_item.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/replies_widget.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/tenant_signature_button.dart';
import 'package:technician/widgets/aligment_widget.dart';
import 'package:technician/widgets/all_files_widget.dart';
import 'package:technician/widgets/app_headline_widget.dart';
import 'package:technician/widgets/bar_widget.dart';
import 'package:technician/widgets/error_widget.dart';
import 'package:technician/widgets/svg_image_widget.dart';

import '../../../../config/PrefHelper/prefs.dart';
import '../../../../res/colors.dart';
import '../../../login/presentation/screen/login_screen.dart';
import '../widgets/add_materials_button.dart';
import 'edit_claim_screen.dart';

class CompletedClaimsScreen extends StatefulWidget {
  String referenceId;
  String claimId;
  CompletedClaimsScreen({super.key , required this.referenceId , required this.claimId});

  @override
  State<CompletedClaimsScreen> createState() => _CompletedClaimsScreenState();
}

class _CompletedClaimsScreenState extends State<CompletedClaimsScreen> {

  AlignmentWidget alignmentWidget = AlignmentWidget();
  ClaimDetailsModel? claimDetailsModel;
  List<String> _permissions = [];
  @override
  void initState() {
    super.initState();
    getData();
    _loadPermissions();
  }
  Future<void> _loadPermissions() async {
    final permissions = Prefs.getStringList(AppStrings.permissions);
    if (permissions != null) {
      setState(() {
        _permissions = permissions;
      });
    }
  }

  void getData()=>BlocProvider.of<ClaimDetailsCubit>(context).getClaimDetails(widget.referenceId);

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
        AllFilesWidget(images: claimDetailsModel!.data.comments,files: claimDetailsModel!.data.files,ifUpdate: false,claimId: widget.claimId,)
      ],
    ));
  }

  Widget _statusInfoWidget() {
    return ClaimDetailsCardItem(
        cardChildWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClaimDetailsTextItem(
              itemName: 'assignTo'.tr,
              itemValue: employeeName(),
              isClickable: false,
              type: '',
            ),
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
        ClaimDetailsTextItem(itemName: 'createdAt'.tr, itemValue: Helper.convertSecondsToDate(claimDetailsModel!.data.createdAt.toString()) , isClickable: false, type: '',),
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
        color: MColors.gray,
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
                _permissions.contains("delete_claims") ? GestureDetector(
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Are you sure?"),
                      content: const Text("Do you really want to delete this claim?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("No"),
                        ),
                        TextButton(
                          onPressed: () async {
                            if (_permissions.contains("delete_claims")) {
                              Navigator.pop(context);
                              await context.read<ClaimDetailsCubit>()
                                  .deleteClaim(claimDetailsModel!.data.id.toString());
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('You do not have permission to delete this claim.'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          child: const Text("Yes"),
                        ),
                      ],
                    ),
                  ),
                  child: SVGImageWidget(
                    image: AssetsManager.clearIcon,
                    width: 30.w,
                    height: 30.h,
                  ),
                )  : const SizedBox(),
                SizedBox(width: 5.h,),
                _permissions.contains("update_claims") ? GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditClaimScreen(
                              claimsModel: claimDetailsModel!,
                            )));

                  },
                  child: SVGImageWidget(image: AssetsManager.editProfile,width: 30.w,height: 30.h,),
                ):  const SizedBox() ,
                SizedBox(width: 5.h,),
                GestureDetector(
                  onTap: ()=>Navigator.pushNamed(context , Routes.technicianHistory , arguments: TechnicianHistoryArguments(logList: claimDetailsModel!.data.logs, employeesList: claimDetailsModel!.data.employees , timeList: claimDetailsModel!.data.times)),
                  child: SVGImageWidget(image: AssetsManager.timeHistory,width: 30.w,height: 30.h,),
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
                  AddMaterialsButton(materials: claimDetailsModel!.data.material,referenceId:claimDetailsModel!.data.referenceId,claimId: claimDetailsModel!.data.id,),
                  SizedBox(height: 10.h,),
                  _submitButtonWidget(),
                  SizedBox(height: 10.h,),
                  AppConst.addClaimSignature ?  TenantSignatureButton(claimId: widget.claimId,referenceId: widget.referenceId , ctx: context,) : const SizedBox(),
                  SizedBox(height: 10.h,),
                  ClaimDetailsCardItem(
                    cardChildWidget: RepliesWidget(claimType: 3,ctx: context ,
                      submitOnly: false , comments: claimDetailsModel!.data.comments,
                      claimId: widget.claimId,status: claimDetailsModel!.data.status,
                      referenceId: widget.referenceId,
                      claimDetailsModel: claimDetailsModel!,),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _submitButtonWidget(){
    if(AppConst.submitClosedButton){
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 33.w),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // <-- Radius
            ),
            minimumSize: Size(327.w, 40.h),
            backgroundColor: AppColors.mainColor,
            textStyle: const TextStyle(color: AppColors.whiteColor,
            ),
          ),
          onPressed: (){
            BlocProvider.of<ClaimDetailsCubit>(context).changeClaimStatus(widget.claimId , 'closed').then((value){
              if(value){
                Navigator.pushReplacementNamed(context, Routes.home);
              }
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'submitAsClosed'.tr,
                style: TextStyle(color: AppColors.whiteColor , fontSize: 20.fSize , fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      );
    }
    return const SizedBox();
  }

  Widget checkState(ClaimDetailsState state){
    if(state is ClaimDetailsIsLoading){
      return const Center(child: CircularProgressIndicator(color: AppColors.mainColor,),);
    } else if(state is ClaimDetailsError){
      bool isUnauthenticated = state.msg.contains('Unauthenticated.');
      return ErrorWidgetItem(onTap: (){
        if(isUnauthenticated){
          Get.offAll(const LoginScreen());
        }else{
          getData();
        }
      },
        isUnauthenticated: isUnauthenticated,
      );
    } else if(state is ClaimDetailsLoaded) {
      claimDetailsModel = state.model;
      return _detailsWidget();
    } else {
      return _detailsWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClaimDetailsCubit, ClaimDetailsState>(
      listener: (context, state) {
        if (state is ClaimDeleted) {
          print("✅ Claim deleted — navigating to home");
          Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.home,
                (route) => false,
          );
        }
        else if (state is ClaimDetailsError){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  state.msg),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
  builder: (context, state) {
    return BlocBuilder<ClaimDetailsCubit , ClaimDetailsState>(builder: (context , state){
      return Scaffold(
        backgroundColor: MColors.gray,
          body: checkState(state)
      );
    });
  },
);
  }
}
