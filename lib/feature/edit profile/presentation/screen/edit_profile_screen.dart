import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:technician/config/PrefHelper/prefs.dart';
import 'package:technician/config/routes/app_routes.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/edit%20profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:technician/feature/edit%20profile/presentation/cubit/edit_profile_state.dart';
import 'package:technician/widgets/editprofile_text_field_widget.dart';
import 'package:technician/widgets/error_widget.dart';
import 'package:technician/widgets/image_loader_widget.dart';
import 'package:technician/widgets/message_widget.dart';
import 'package:technician/widgets/svg_image_widget.dart';
import 'package:technician/widgets/text_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  int _selectedTabIndex = 0;

  int _emailNotification = 1;

  File _image = File('');

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  final picker = ImagePicker();
  TextEditingController passwordController = TextEditingController();

  TextEditingController oldPasswordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _dataLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Color(0xFF5686E1),statusBarIconBrightness: Brightness.light,),);
    getData();
    nameController.text = '';
    emailController.text = '';
    phoneController.text = '';
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent,statusBarIconBrightness: Brightness.dark,),);

    super.dispose();
  }

  getData() =>BlocProvider.of<EditProfileCubit>(context).getUserInfo();

  setData(String name , String email , String phone , int emailNotification){
    Future.delayed(const Duration(milliseconds: 50), () {
      setState(() {
        nameController.text = name;
        emailController.text = email;
        phoneController.text = phone;
        _emailNotification = emailNotification;
        _dataLoaded = true;

      });
    });
  }

  void changePassword(){
    if(oldPasswordController.value.text.isEmpty){
      MessageWidget.showSnackBar('pleaseWriteYourOldPassword'.tr, AppColors.red);
      return;
    }
    if(passwordController.value.text.isEmpty){
      MessageWidget.showSnackBar('pleaseWriteYourPassword'.tr, AppColors.red);
      return;
    }
    if(confirmPasswordController.value.text.isEmpty){
      MessageWidget.showSnackBar('pleaseWriteYourConfirmPassword'.tr, AppColors.red);
      return;
    }
    BlocProvider.of<EditProfileCubit>(context).changePassword(oldPasswordController.value.text.toString() , passwordController.value.text.toString() , confirmPasswordController.value.text.toString()).then((value){
      if(value){
        Prefs.setBool(AppStrings.login, false);
        Navigator.of(context).pushNamedAndRemoveUntil(Routes.login, (Route<dynamic> route) => false);
      }
    });
  }

  void updateProfile(){
    if(nameController.value.text.isEmpty){
      MessageWidget.showSnackBar('pleaseWriteYourName'.tr, AppColors.red);
      return;
    }
    if(phoneController.value.text.isEmpty){
      MessageWidget.showSnackBar('pleaseWriteYourPhone'.tr, AppColors.red);
      return;
    }
    BlocProvider.of<EditProfileCubit>(context).updateProfile(nameController.value.text.toString(), phoneController.value.text.toString(),_image , _emailNotification).then((value){
      if(value){
        Navigator.pushReplacementNamed(context, Routes.main);
      }
    });
  }

  Widget editProfileWidgets(String image){
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 15.h),
              decoration: const BoxDecoration(
                  color: Color(0xFF5686E1),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )
              ),
              child: Column(
                children: [
                  SizedBox(height: 10.h,),
                  Row(
                    children: [
                      InkWell(
                        onTap: ()=>Navigator.pop(context),
                        child: const SVGImageWidget(image: AssetsManager.whiteBack,width: 39,height: 39,),
                      ),
                      SizedBox(width: 20.w,),
                      TextWidget(text: 'editProfile'.tr,fontSize: 18.fSize,fontWeight: FontWeight.w400,fontColor: Colors.white,)
                    ],
                  ),
                  SizedBox(height: 10.h,),
                  Stack(
                    children: [
                      Container(
                        height: 90.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                          color: AppColors.pageBackground,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child:_image.path != '' ? Image.file(_image,fit: BoxFit.cover,) :  ImageLoader(imageUrl: image , width: 100.w,height: 100.h,fit: BoxFit.cover)
                        ),
                      ),
                      PositionedDirectional(
                        bottom: 2.h,
                        end: 0,
                        child: InkWell(
                          onTap: () {
                            _showBottomSheet(context);
                          },
                          child: Container(
                            height: 30.h,
                            width: 30.w,
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Icon(Icons.edit , size: 20.adaptSize, color: AppColors.mainColor,),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h,),
                  TextWidget(text: nameController.value.text, fontSize: 16.fSize , fontWeight: FontWeight.w600, fontColor: Colors.white,)
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [

                  buttonsWidget(),
                  Container(
                    color: AppColors.pageBackground,
                    padding: EdgeInsets.symmetric(horizontal: 6.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10.h),
                        Container(
                          child: _selectedTabIndex == 0
                              ? _buildBasicInfoContent()
                              : _buildUpdatePasswordContent(), //_buildUpdatePasswordContent(),
                        ),
                      ],
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

  Widget buttonsWidget(){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25), // <-- Radius
              ),
              minimumSize: Size(150.w, 40.h),
              backgroundColor: _selectedTabIndex == 0 ? AppColors.mainColor : AppColors.whiteColor,
              textStyle: const TextStyle(color: AppColors.whiteColor,
              ),
            ),
            onPressed: (){
              setState(() {
                _selectedTabIndex = 0;
              });
            },
            child: Text(
              'basicInfo'.tr,
              style: TextStyle(color: _selectedTabIndex == 0 ? AppColors.whiteColor : const Color(0xFF2E435C) , fontSize: 14.fSize , fontWeight: FontWeight.w500),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25), // <-- Radius
              ),
              minimumSize: Size(150.w, 40.h),
              backgroundColor: _selectedTabIndex == 1 ? AppColors.mainColor : AppColors.whiteColor,
              textStyle: const TextStyle(color: AppColors.whiteColor,
              ),
            ),
            onPressed: (){
              setState(() {
                _selectedTabIndex = 1;
              });
            },
            child: Text(
              'updatePassword'.tr,
              style: TextStyle(color: _selectedTabIndex == 1 ? AppColors.whiteColor : const Color(0xFF2E435C) , fontSize: 14.fSize , fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNotificationToggle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'emailNotifications'.tr,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.fSize),
        ),
        SizedBox(height: 2.h,),
        Row(
          children: [
            Row(
              children: [
                Radio(
                  fillColor: WidgetStateProperty.all<Color>(AppColors.textButtonColor),
                  value: 1,
                  groupValue: _emailNotification,
                  onChanged: (value) {
                    setState(() {
                      _emailNotification = value!;
                    });
                  },
                ),
                Text('enable'.tr , style:  TextStyle(fontSize: 14.fSize , fontWeight: FontWeight.w400),),
              ],
            ),
            SizedBox(width: 1.0.w),
            Radio(
              fillColor: WidgetStateProperty.all<Color>(AppColors.textButtonColor),
              value: 0,
              groupValue: _emailNotification,
              onChanged: (value) {
                setState(() {
                  _emailNotification = value!;
                });
              },
            ),
            Text('disable'.tr, style:  TextStyle(fontSize: 14.fSize , fontWeight: FontWeight.w400),),
          ],
        ),
      ],
    );
  }

  Widget _buildUpdatePasswordContent() {
    return Container(
      decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.h),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(text: 'updatePassword'.tr, fontSize: 20.fSize,fontColor: AppColors.black,fontWeight: FontWeight.w700,),
            SizedBox(height: 15.h,),
            buildOldPasswordField(context),
            SizedBox(height: 20.h,),
            buildPasswordField(context),
            SizedBox(height: 20.h,),
            buildConfirmPasswordField(context),
            SizedBox(height: 20.h,),
            buildEditProfileButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfoContent() {
    return Container(
      decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.h),
      margin: EdgeInsets.only(bottom:20.h),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(text: 'basicInfo'.tr, fontSize: 20.fSize,fontColor: AppColors.black,fontWeight: FontWeight.w700,),
            SizedBox(height: 8.h,),
            buildNameField(context),
            SizedBox(height: 8.h,),
            buildEmailField(context),
            SizedBox(height: 8.h,),
            buildPhoneField(context),
            SizedBox(height: 8.h,),
            //buildNotificationToggle(context),
            SizedBox(height: 8.h,),
            buildNotificationToggle(),
            SizedBox(height: 8.h,),
            buildEditProfileButton(),
          ],
        ),
      ),
    );
  }

  Widget buildNameField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .872,
      margin: EdgeInsetsDirectional.only(start: 1.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'name'.tr,
            style: TextStyle(fontSize: 17.fSize , color: AppColors.black , fontWeight: FontWeight.w700),
          ),
          EditProfileTextFieldWidget(isPassword: false ,  controller: nameController),
        ],
      ),
    );
  }

  Widget buildEmailField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .872,
      margin: EdgeInsetsDirectional.only(start: 1.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'email'.tr,
            style: TextStyle(fontSize: 17.fSize , color: AppColors.black , fontWeight: FontWeight.w500),
          ),
          EditProfileTextFieldWidget(inputType: TextInputType.emailAddress , readOnly: true , isPassword: false , controller: emailController),
        ],
      ),
    );
  }

  Widget buildPhoneField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .872,
      margin: EdgeInsetsDirectional.only(start: 1.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'phone'.tr,
            style: TextStyle(fontSize: 17.fSize , color: AppColors.black , fontWeight: FontWeight.w500),
          ),
          IntlPhoneField(
              style: TextStyle(fontWeight: FontWeight.w500 , fontSize: 15.fSize),
            dropdownTextStyle: TextStyle(fontWeight: FontWeight.w500 , fontSize: 15.fSize),
              decoration: InputDecoration(
                hintStyle: Theme.of(context).textTheme.displaySmall,
                counterText: "",
                errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.redAccent),
                contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.outlineBorderLight)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.outlineBorderLight)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.rejectedColor)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.rejectedColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.primaryLightColor)),
              ),
              showCountryFlag: false,
              controller: phoneController,
              keyboardType: TextInputType.phone,
              showDropdownIcon: false,
              initialCountryCode: 'AE',
              onChanged: (phone) {
              },
              onCountryChanged: (country) {
              },
          )
        ],
      ),
    );
  }

  Widget buildOldPasswordField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .872,
      margin: EdgeInsetsDirectional.only(start: 1.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'oldPassword'.tr,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          SizedBox(height: 8.h,),
          EditProfileTextFieldWidget(controller: oldPasswordController, isPassword: true),
        ],
      ),
    );
  }

  Widget buildPasswordField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .872,
      margin: EdgeInsetsDirectional.only(start: 1.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'password'.tr,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          SizedBox(height: 8.h,),
          EditProfileTextFieldWidget(controller: passwordController, isPassword: true),
        ],
      ),
    );
  }

  Widget buildConfirmPasswordField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .872,
      margin: EdgeInsetsDirectional.only(start: 1.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'confirmPassword'.tr,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          SizedBox(height: 8.h,),
          EditProfileTextFieldWidget(controller: confirmPasswordController, isPassword: true),
        ],
      ),
    );
  }

  Widget buildEditProfileButton() {
    return Center(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(AppColors.mainColor),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          fixedSize: WidgetStateProperty.all<Size>(
            Size(170.w, 50.h),
          ),
        ),
        onPressed: (){
          if(_selectedTabIndex == 0){
            updateProfile();
          } else {
            changePassword();
          }
        },
        child: Text(
          'saveChanges'.tr,
          style: GoogleFonts.montserrat(fontSize: 14.fSize, fontWeight: FontWeight.w500, color: AppColors.whiteColor),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          padding: EdgeInsets.all(16.0.adaptSize),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextWidget(
                text: 'profilePhoto'.tr,
                fontSize: 18.fSize,
                fontWeight: FontWeight.w700,
                fontColor: AppColors.black,
              ),
              SizedBox(height: 20.h),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.w),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: AppColors.mainColor),
                    ),
                    minimumSize: Size(80.w, 60.h),
                    backgroundColor: AppColors.whiteColor,
                    textStyle: const TextStyle(color: AppColors.whiteColor),
                  ),
                  onPressed: () {
                    getImageFromGallery();
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SVGImageWidget(image: AssetsManager.upload2, width: 25, height: 25),
                      SizedBox(width: 20.w),
                      Text(
                        'uploadPhoto'.tr,
                        style: TextStyle(color: AppColors.black, fontSize: 14.fSize, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 35.w),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: AppColors.mainColor),
                    ),
                    minimumSize: Size(80.w, 60.h),
                    backgroundColor: AppColors.whiteColor,
                    textStyle: const TextStyle(color: AppColors.whiteColor),
                  ),
                  onPressed: () {
                    getImageFromCamera();
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: AppStrings.appLocal == 'en' ? EdgeInsets.only(left: 25.w) : EdgeInsets.only(right: 25.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SVGImageWidget(image: AssetsManager.camera, width: 25, height: 25),
                        SizedBox(width: 20.w),
                        Text(
                          'takeNewPhoto'.tr,
                          style: TextStyle(color: AppColors.black, fontSize: 14.fSize, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  minimumSize: Size(280.w, 40.h),
                  backgroundColor: AppColors.mainColor,
                  textStyle: const TextStyle(color: AppColors.whiteColor),
                ),
                onPressed: () {},
                child: Text(
                  'submit'.tr,
                  style: TextStyle(color: AppColors.whiteColor, fontSize: 14.fSize, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        );
      },
    );
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColors.errorColor,
            margin: EdgeInsets.all(8.adaptSize),
            behavior: SnackBarBehavior.floating,
            content: Text('noImageSelected'.tr)));
        Navigator.pop(context);
      }
    });
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColors.errorColor,
            margin: EdgeInsets.all(8.adaptSize),
            behavior: SnackBarBehavior.floating,
            content: Text('noImageSelected'.tr)));
      }
    });
  }

  Widget checkState(EditProfileState state){
    if(state is EditProfileIsLoading){
      return const Center(child: CircularProgressIndicator(color: AppColors.mainColor,),);
    } else if(state is EditProfileError){
      return ErrorWidgetItem(onTap: ()=>getData());
    } else if(state is EditProfileLoaded) {
      if (!_dataLoaded) {
        setData(state.userInfo.name, state.userInfo.email, state.userInfo.phone , state.userInfo.emailNotification);
      }
      return editProfileWidgets(state.userInfo.image);
    } else {
      return editProfileWidgets('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<EditProfileCubit , EditProfileState>(builder: (context , state){
      return Scaffold(
          body: checkState(state)
      );
    });
  }
}
