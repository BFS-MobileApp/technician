import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:technician/config/routes/app_routes.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/reset_password/presentation/cubit/reset_password_cubit.dart';
import 'package:technician/widgets/editprofile_text_field_widget.dart';
import 'package:technician/widgets/message_widget.dart';
import 'package:technician/widgets/text_widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String token;
  const ResetPasswordScreen({super.key , required this.email , required this.token});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void changePassword(){
    if(passwordController.value.text.isEmpty){
      MessageWidget.showSnackBar('pleaseWriteYourPassword'.tr, AppColors.red);
      return;
    }
    if(confirmPasswordController.value.text.isEmpty){
      MessageWidget.showSnackBar('pleaseWriteYourConfirmPassword'.tr, AppColors.red);
      return;
    }
    BlocProvider.of<ResetPasswordCubit>(context).resetPassword(widget.token, widget.email, passwordController.value.text.toString(), confirmPasswordController.value.text.toString()).then((value){
      if(value){
        Navigator.of(context).pushNamedAndRemoveUntil(Routes.login, (Route<dynamic> route) => false);
      }
    });
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
          changePassword();
        },
        child: Text(
          'resetPassword'.tr,
          style: GoogleFonts.montserrat(fontSize: 14.fSize, fontWeight: FontWeight.w500, color: AppColors.whiteColor),
        ),
      ),
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
            Center(
              child: TextWidget(text: 'resetPassword'.tr, fontSize: 20.fSize,fontColor: AppColors.black,fontWeight: FontWeight.w700,),
            ),
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

  Widget screenWidget(){
    return ListView(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height/4,),
        _buildUpdatePasswordContent()

      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenWidget(),
    );
  }
}
