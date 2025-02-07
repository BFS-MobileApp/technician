import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:technician/config/routes/app_routes.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/new%20claim/data/models/avaliable_time_model.dart';
import 'package:technician/feature/new%20claim/data/models/building_model.dart';
import 'package:technician/feature/new%20claim/data/models/category_model.dart';
import 'package:technician/feature/new%20claim/data/models/claim_type_model.dart';
import 'package:technician/feature/new%20claim/data/models/unit_model.dart';
import 'package:technician/feature/new%20claim/domain/entities/add_new_claim.dart';
import 'package:technician/feature/new%20claim/presentation/cubit/new_claim_cubit.dart';
import 'package:technician/feature/new%20claim/presentation/cubit/new_claim_state.dart';
import 'package:technician/feature/new%20claim/presentation/widgets/app_bar_widget.dart';
import 'package:technician/feature/new%20claim/presentation/widgets/claim_summary_widget.dart';
import 'package:technician/feature/new%20claim/presentation/widgets/stepper_item.dart';
import 'package:technician/widgets/app_headline_widget.dart';
import 'package:technician/widgets/back_button_widget.dart';
import 'package:technician/widgets/button_widget.dart';
import 'package:technician/widgets/message_widget.dart';
import 'package:technician/widgets/no_data_widget_grid.dart';
import 'package:technician/widgets/svg_image_widget.dart';
import 'package:technician/widgets/text_widget.dart';
import 'package:technician/feature/new%20claim/data/models/avaliable_time_model.dart' as time_model;
import '../../../../widgets/error_widget.dart';

class NewClaimScreen extends StatefulWidget {
  const NewClaimScreen({super.key});

  @override
  State<NewClaimScreen> createState() => _NewClaimScreenState();
}

class _NewClaimScreenState extends State<NewClaimScreen> {

  int _currentStep = 0;

  bool _claimSummary = false , isDateTimeSelected = false , newClaimAdded = false;

  DateTime selectedDate = DateTime.now();

  TextEditingController descriptionController = TextEditingController();

  time_model.Datum? selectedTimeAvailable;

  ImagePicker picker = ImagePicker();

  File filePicker = File('');

  List<XFile> imageFiles = [];

  BuildingModel? buildingModel;

  UnitModel? unitModel;

  CategoryModel? categoryModel;

  CategoryModel? subCategoryModel;

  ClaimsTypeModel? claimsTypeModel;

  AvailableTimeModel? availableTimeModel;

  AddNewClaim? addNewClaim;

  int _buildingId = -1 , _unitId = -1  , _companyId = -1, _categoryId = -1 , _subCategoryId = -1 , _claimsTypeId = -1 , _availableTimeId = -1;

  bool chooseAvailableTime = false;

  String _buildingName = '' , _unitName = '', _claimCategoryName = '' , _claimSubCategoryName = '' , _claimTypeName = '' , _claimError = '';


  @override
  void initState() {
    super.initState();
    intializeDate();
    getData();
  }

  getData(){
    BlocProvider.of<NewClaimCubit>(context).getBuildings();
  }

  void checkStepsTaped(int step){
    if(_currentStep == 0 && _buildingId == -1 && _currentStep < step){
      MessageWidget.showSnackBar('pleaseSelectBuildingFirst'.tr, AppColors.errorColor);
      return;
    }
    if(_currentStep == 1 && _unitId == -1 && _currentStep < step){
      MessageWidget.showSnackBar('pleaseSelectUnitFirst'.tr, AppColors.errorColor);
      return;
    }
    if(_currentStep == 2 && _categoryId == -1 && _currentStep < step){
      MessageWidget.showSnackBar('pleaseSelectCategoryFirst'.tr, AppColors.errorColor);
      return;
    }
    if(_currentStep == 3 && _subCategoryId == -1 && _currentStep < step){
      MessageWidget.showSnackBar('pleaseSelectSubCategoryFirst'.tr, AppColors.errorColor);
      return;
    }
    if(_currentStep == 4 && _claimsTypeId == -1 && _currentStep < step){
      MessageWidget.showSnackBar('pleaseSelectClaimTypeFirst'.tr, AppColors.errorColor);
      return;
    }
    setState(() {
      _currentStep = step;
    });
  }

  void intializeDate() async{
    await initializeDateFormatting();
  }

  void onStepContinue(){
    if (_currentStep < 5) {
      setState(() {
        _currentStep += 1;
      });
    }
  }

  void getSubCategoriesItems(int id) async{
    for (var e in categoryModel!.data) {
      if(e.id == id){
        setState(() {
          subCategoryModel = e.child;
        });
      }
    }
  }

  Widget step1Widget(){
    return InkWell(
      onTap: onStepContinue,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppHeadline(image: AssetsManager.building  , isSVGImage: true , addImage: true , title: 'selectBuilding'.tr),
          buildingModel!.data.isNotEmpty
              ? GridView.builder(
            itemCount: buildingModel!.data.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 50.h,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _buildingId = buildingModel!.data[index].id;
                      _buildingName = buildingModel!.data[index].name;
                    });
                    BlocProvider.of<NewClaimCubit>(context).getUnits(_buildingId.toString());
                    onStepContinue();
                  },
                  child: SteeperItem(index: index, currentStep: _currentStep , item: buildingModel!.data[index].name,),
                ),
              );
            },
          )
              : const NoDataWidgetGrid()
        ],
      ),
    );
  }

  Widget step2Widget(){
    return InkWell(
      onTap: onStepContinue,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppHeadline(title: 'selectUnit'.tr),
          unitModel!.data.isNotEmpty
              ? GridView.builder(
            itemCount: unitModel!.data.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 50.h,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _unitId = unitModel!.data[index].id;
                      _companyId = unitModel!.data[index].companyId;
                      _unitName = unitModel!.data[index].name;
                    });
                    BlocProvider.of<NewClaimCubit>(context).getCategories(_unitId.toString());
                    onStepContinue();
                  },
                  child: SteeperItem(index: index, currentStep: _currentStep , item: unitModel!.data[index].name.toString(),),
                ),
              );
            },
          )
              : const NoDataWidgetGrid()
        ],
      ),
    );
  }

  Widget step3Widget(){
    return InkWell(
      onTap: onStepContinue,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
         AppHeadline(title: 'selectClaimCategory'.tr),
          categoryModel!.data.isNotEmpty
              ? GridView.builder(
            itemCount: categoryModel!.data.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 50.h,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _categoryId = categoryModel!.data[index].id;
                      _claimCategoryName = categoryModel!.data[index].name;
                    });
                    getSubCategoriesItems(_categoryId);
                    onStepContinue();
                  },
                  child: SteeperItem(index: index, currentStep: _currentStep , item: categoryModel!.data[index].name,),
                ),
              );
            },
          )
              : const NoDataWidgetGrid()
        ],
      ),
    );
  }

  Widget step4Widget(){
    return InkWell(
      onTap: onStepContinue,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppHeadline(image: AssetsManager.building  ,addImage: false , title: 'selectClaimSubCategory'.tr),
          subCategoryModel!.data.isNotEmpty
              ? GridView.builder(
            itemCount: subCategoryModel!.data.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 50.h,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _subCategoryId = subCategoryModel!.data[index].id;
                      _claimSubCategoryName = subCategoryModel!.data[index].name;
                    });
                    BlocProvider.of<NewClaimCubit>(context).getClaimsType(_subCategoryId.toString());
                    onStepContinue();
                  },
                  child: SteeperItem(index: index, currentStep: _currentStep , item: subCategoryModel!.data[index].name,),
                ),
              );
            },
          )
              : const NoDataWidgetGrid()
        ],
      ),
    );
  }

  Widget step5Widget(){
    return InkWell(
      onTap: onStepContinue,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppHeadline(title: 'selectClaimType'.tr),
          claimsTypeModel!.data.isNotEmpty
              ? GridView.builder(
            itemCount: claimsTypeModel!.data.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 50.h,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _claimsTypeId = claimsTypeModel!.data[index].id;
                      _claimTypeName = claimsTypeModel!.data[index].name;
                    });
                    BlocProvider.of<NewClaimCubit>(context).getAvailableTimes(_companyId.toString());
                    onStepContinue();
                  },
                  child: SteeperItem(index: index, currentStep: _currentStep , item: claimsTypeModel!.data[index].name,),
                ),
              );
            },
          )
              : const NoDataWidgetGrid()
        ],
      ),
    );
  }

  void setAvailableTimeData(){
    Future.delayed(const Duration(milliseconds: 50), () {
      if (mounted) {
        _availableTimeId = availableTimeModel!.data[0].id;
        selectedTimeAvailable = availableTimeModel!.data[0];
      }
    });
  }

  Widget step6Widget(){
    _availableTimeId = availableTimeModel!.data[0].id;
    //selectedTimeAvailable = availableTimeModel!.data[0];
    return InkWell(
      onTap: onStepContinue,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppHeadline(title: 'selectAvailableTime'.tr),
          SizedBox(height: 10.h,),
          GestureDetector(
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate:DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now().add(const Duration(days: 100000)));
              if (picked != null) {
                setState(() {
                  selectedDate = picked;
                  isDateTimeSelected = true;
                });
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.textFieldBorder),
              ),
              padding: EdgeInsets.all(10.0.adaptSize),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('yyyy-MM-dd', 'en').format(selectedDate),
                    style: TextStyle(
                      fontSize:14.fSize,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SVGImageWidget(image: AssetsManager.calender, width: 20, height: 20)
                ],
              ),
            ),
          ),
          SizedBox(height: 15.h,),
          _availableTimeId == -1 ? const SizedBox(): Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.textFieldBorder),
              color: Colors.white,
            ),
            child: DropdownButton<time_model.Datum>(
                isExpanded: true,
                underline: const SizedBox(),
                hint: Text(
                  'availableTime'.tr,
                  style: TextStyle(
                    fontSize: 14.fSize,
                    color: AppColors.primaryColor,
                  ),
                ),
                value: selectedTimeAvailable ,
                onChanged: (time_model.Datum? newValue) {
                  setState(() {
                    chooseAvailableTime = true;
                    selectedTimeAvailable = newValue;
                    _availableTimeId = newValue!.id;
                    print(selectedTimeAvailable!.name);
                    print(_availableTimeId);
                  });
                },
                items: availableTimeModel!.data.map((time_model.Datum value) {
                  return DropdownMenuItem<time_model.Datum>(
                    value: value,
                    child: Text(value.name),
                  );
                }).toList()),
          ) ,
          SizedBox(height: 15.h,),
          TextFormField(
            controller: descriptionController,
            maxLines: 3,
            style: GoogleFonts.montserrat(fontSize: 14.fSize, fontWeight: FontWeight.w500, color: AppColors.textDark),
            validator: (val){
              if(val!.isEmpty){
                return 'Description Required';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: 'typeYourComplaintsHere'.tr,
              hintStyle: TextStyle(
                fontSize: 14.fSize,
                color: AppColors.primaryColor,
              ).copyWith(
                  color: AppColors.secondaryTextColor
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.textFieldBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color:AppColors.textFieldBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.textFieldBorder),
              ),
            ),
          ),
          SizedBox(height: 15.h,),
          GestureDetector(
            onTap: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    insetPadding: EdgeInsets.all(14.adaptSize),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Upload Image From'.tr,
                          style: TextStyle(
                            fontSize: 14.fSize,
                            color: AppColors.primaryColor,
                          ).copyWith(color: AppColors.primaryTextColor),
                        ),
                        SizedBox(height: 30.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                                getImageFromCamera();
                              },
                              child: Container(
                                width: 80.w, // Increased width
                                padding: EdgeInsets.all(14.adaptSize),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor.withOpacity(.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.camera_alt, color: AppColors.primaryColor),
                                    SizedBox(height: 6.h),
                                    FittedBox(
                                      child: Text(
                                        'Take Photo'.tr,
                                        style: TextStyle(
                                          fontSize: 12.fSize,
                                          color: AppColors.primaryColor,
                                        ).copyWith(color: AppColors.primaryColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                                pickImages();
                              },
                              child: Container(
                                width: 80.w, // Increased width
                                padding: EdgeInsets.all(14.adaptSize),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor.withOpacity(.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.photo_library, color: AppColors.primaryColor),
                                    SizedBox(height: 6.h), // Corrected height
                                    FittedBox(
                                      child: Text(
                                        'From Gallery'.tr,
                                        style: TextStyle(
                                          fontSize: 12.fSize,
                                          color: AppColors.primaryColor,
                                        ).copyWith(color: AppColors.primaryColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.textFieldBorder),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(8.adaptSize),
              child: Row(
                children: [
                  const SVGImageWidget(image: AssetsManager.upload, width: 15, height: 15),
                  SizedBox(width: 8.w),
                  filePicker.path != ''
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      filePicker,
                      width: 40.w,
                      height: 40.w,
                      fit: BoxFit.cover,
                    ),
                  )
                      : imageFiles.isNotEmpty
                      ? Row(
                    children: [
                      const Icon(Icons.image, color: AppColors.rejectedColor),
                      Text(imageFiles.length.toString() + " " + 'images'),
                    ],
                  )
                      : Text(
                    'uploadAnyFiles'.tr,
                    style: GoogleFonts.montserrat(
                      fontSize: 14.fSize,
                      fontWeight: FontWeight.w500,
                      color: AppColors.mainColor,
                    ),
                  ),
                  const Spacer(),
                  imageFiles .isEmpty ? const SizedBox() : InkWell(
                    onTap: () async {
                      setState(() {
                        imageFiles.clear();
                        filePicker.path == '';
                      });
                    },
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.h,),
          ButtonWidget(width: 334, height: 44, onTap: (){
            if(descriptionController.value.text.isEmpty){
              MessageWidget.showSnackBar('pleaseAddDescriptionFirst'.tr, AppColors.errorColor);
              return;
            }
            setState(() {
              _claimSummary = true;
            });
          }, name: 'confirm'.tr , btColor: AppColors.mainColor,)
        ],
      ),
    );
  }

  String convertDate (){
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    return formattedDate;
  }

  Widget newClaimsWidget() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 12.h),
        child: Column(
          children: [
            // SizedBox(height: 30.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.adaptSize),
              child: const Row(
      
                children: [
                  BackButtonWidget(),
                  AppBarWidget(),
                ],
              ),
            ),
            Card(
              color: Colors.white,
              elevation: 0,
              child: Column(
                children: [
                  TextWidget(
                    text: 'addNewClaim'.tr,
                    fontSize: 18.fSize,
                    fontWeight: FontWeight.w600,
                    fontColor: AppColors.black,
                  ),
                  SizedBox(
                    height: 600.h,
                    child: Theme(
                      data: ThemeData(
                        shadowColor: Colors.transparent,
                        colorScheme: const ColorScheme.light(
                          primary: AppColors.primaryColor, // Change active color to blue
                        ),
                      ),
                      child: Stepper(
                        elevation: 0,
                        stepIconBuilder: (pos , S){
                          if(pos<_currentStep){
                            return Container(
                              width: 40.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.mainColor,
                                border: Border.all(
                                  color: AppColors.mainColor, // Blue border
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Icon(Icons.check , size: 15.adaptSize, color: AppColors.whiteColor,),
                              ),
                            );
                          } else if(pos == _currentStep){
                            return Container(
                              width: 40.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.whiteColor,
                                border: Border.all(
                                  color: AppColors.mainColor, // Blue border
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Container(
                                  width: 10.w,
                                  height: 10.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.mainColor,
                                    border: Border.all(
                                      color: AppColors.mainColor, // Blue border
                                      width: 2,
                                    ),
                                  ),
                                )
                              ),
                            );
                          }
                          return Container(
                            width: 40.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.whiteColor,
                              border: Border.all(
                                color: const Color(0xFFD8DADC),
                                width: 2,
                              ),
                            ),
                            child: Center(
                                child: Container(
                                  width: 10.w,
                                  height: 10.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color(0xFFD8DADC),
                                    border: Border.all(
                                      color: const Color(0xFFD8DADC), // Blue border
                                      width: 2,
                                    ),
                                  ),
                                )
                            ),
                          );
                        },
                        type: StepperType.horizontal,
                        currentStep: _currentStep,
                        onStepTapped: (step) {
                          checkStepsTaped(step);
                        },
                        onStepContinue: () {
                          onStepContinue();
                        },
                        onStepCancel: () {
                          if (_currentStep > 0) {
                            setState(() {
                              _currentStep -= 1;
                            });
                          }
                        },
                        steps: List.generate(6, (index) {
                          return Step(
                            title: Container(), // Empty title
                            content: Container(), // Empty content
                            isActive: _currentStep == index,
                          );
                        }),
                        controlsBuilder: (BuildContext context, ControlsDetails details) {
                          if (_currentStep == 0) return step1Widget();
                          if (_currentStep == 1) return step2Widget();
                          if (_currentStep == 2) return step3Widget();
                          if (_currentStep == 3) return step4Widget();
                          if (_currentStep == 4) return step5Widget();
                          if (_currentStep == 5) return step6Widget();
                          return const SizedBox();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void clearData(){
    setState(() {
      _unitId = -1;
      _buildingId = -1;
      _categoryId = -1;
      _subCategoryId = -1;
      _claimsTypeId = -1;
      _availableTimeId = -1;
      _buildingName = '' ;
      _unitName = '';
      _claimCategoryName = '' ;
      _claimSubCategoryName = '';
      _claimTypeName = '';
      isDateTimeSelected = false;
      imageFiles.clear();
      descriptionController.clear();
    });
  }

  Widget claimSummary(){
    return Container(
      color: const Color(0xFFFAF9F6),
      child: ListView(
        children: [
          SizedBox(height: 10.h,),
          const AppBarWidget(),
          SizedBox(height: 10.h,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            child: Card(
              color: AppColors.whiteColor,
              elevation: 0,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w , vertical: 15.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SVGImageWidget(image: AssetsManager.backIcon2, width: 7.fSize, height: 12.h,),
                        SizedBox(width: MediaQuery.of(context).size.width/3.5,),
                        Center(
                          child: TextWidget(text: 'addNewClaim'.tr , fontSize: 18.fSize, fontColor:const  Color(0xFF031D3C), fontWeight: FontWeight.w600,),
                        )
                      ],
                    ),
                    SizedBox(height: 12.h,),
                    ClaimSummaryWidget(name: 'yourBuilding'.tr, value: _buildingName),
                    ClaimSummaryWidget(name: 'yourUnit'.tr, value: _unitName),
                    ClaimSummaryWidget(name: 'claimCategory'.tr, value: _claimCategoryName),
                    ClaimSummaryWidget(name: 'claimSubCategory'.tr, value: _claimSubCategoryName),
                    ClaimSummaryWidget(name: 'claimType'.tr, value: _claimTypeName),
                    chooseAvailableTime ? ClaimSummaryWidget(name: 'availableTime'.tr, value: '${convertDate()} - ${selectedTimeAvailable!.name}') : ClaimSummaryWidget(name: 'availableTime'.tr, value: '${convertDate()} - ${availableTimeModel!.data[0].name}'),
                    ClaimSummaryWidget(name: 'description'.tr, value: descriptionController.value.text.isEmpty ? '' : descriptionController.value.text.toString()),
                    SizedBox(height: 20.h,),
                    ButtonWidget(width: 334, height: 44,
                      onTap: (){
                        BlocProvider.of<NewClaimCubit>(context).addNewClaim(_unitId.toString(), _categoryId.toString(), _subCategoryId.toString(), _claimsTypeId.toString(), descriptionController.value.text.toString(), convertDate(),chooseAvailableTime ? _availableTimeId.toString() : availableTimeModel!.data[0].id.toString());
                      //showCustomAlertDialog(context);
                    }, name: 'confirm'.tr , btColor: AppColors.mainColor,),
                    SizedBox(height: 10.h,),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: AppColors.mainColor),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          minimumSize: Size(99.w, 44.h),
                          backgroundColor: AppColors.whiteColor,
                          textStyle: const TextStyle(color: AppColors.mainColor,),
                        ),
                        onPressed: (){
                          setState(() {
                            _claimSummary = false;
                          });
                        },
                        child: Text(
                          'back'.tr,
                          style: TextStyle(color: AppColors.mainColor , fontSize: 14.fSize , fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void showCustomAlertDialog(BuildContext context , String code) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(10.0.fSize),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SVGImageWidget(
                image: AssetsManager.successDialog,
                width: 135.w,
                height: 128.h,
              ),
              SizedBox(height: 20.0.h),
              TextWidget(
                text: "${'newClaimDialogClaim'.tr} $code"' '+'newClaimDialogCreatedSuccessfully'.tr,
                fontSize: 16.0.fSize,
                fontWeight: FontWeight.w600,
                fontColor: const Color(0xFF031D3C),
              ),
              SizedBox(height: 10.h,),
              ButtonWidget(width: 150, height: 50, onTap: ()=>Navigator.of(context).pushNamedAndRemoveUntil(Routes.home, (Route<dynamic> route) => false), name: 'ok'.tr)
            ],
          ),
        );
      },
    );
  }

  Future<void> pickImages() async {
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.length > 4) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: AppColors.errorColor,
          margin: EdgeInsets.all(8.adaptSize),
          behavior: SnackBarBehavior.floating,
          content: const Text('only 4 Images Allowed')));
      return ;
    }
    if (pickedFiles.isNotEmpty) {
      setState(() {
        imageFiles = pickedFiles;
      });
    }
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        filePicker = File(pickedFile.path);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColors.primaryColor,
            margin: EdgeInsets.all(8.adaptSize),
            behavior: SnackBarBehavior.floating,
            content: const Text('only 4 Images Allowed')));
        Navigator.pop(context);
      }
    });
  }

  Widget checkState(NewClaimState state){
    if(state is NewClaimIsLoading){
      return const Center(child: CircularProgressIndicator(color: AppColors.mainColor,),);
    } else if(state is NewClaimError){
      return ErrorWidgetItem(onTap: (){});
    } else if(state is BuildingsLoaded) {
      buildingModel = state.buildingModel;
      return !_claimSummary  ? newClaimsWidget() : claimSummary();
    } else if(state is UnitLoaded){
      unitModel = state.unitModel;
      return !_claimSummary  ? newClaimsWidget() : claimSummary();
    }  else if(state is CategoryLoaded){
      categoryModel = state.categoryModel;
      return !_claimSummary  ? newClaimsWidget() : claimSummary();
    } else if(state is ClaimsTypeLoaded){
      claimsTypeModel = state.claimsTypeModel;
      return !_claimSummary  ? newClaimsWidget() : claimSummary();
    } else if(state is AvailableTimesLoaded){
      availableTimeModel = state.availableTimeModel;
      return !_claimSummary  ? newClaimsWidget() : claimSummary();
    } else if(state is AddNewClaimLoaded){
      addNewClaim = state.addNewClaim;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showCustomAlertDialog(context, addNewClaim!.claimId);
      });
      return !_claimSummary  ? newClaimsWidget() : claimSummary();
    } else if(state is AddNewClaimsError){
      return !_claimSummary  ? newClaimsWidget() : claimSummary();
    } else {
      return !_claimSummary  ? newClaimsWidget() : claimSummary();
    }
  }

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<NewClaimCubit , NewClaimState>(builder: (context , state){
      return Scaffold(
          body: checkState(state)
      );
    });
  }
}
