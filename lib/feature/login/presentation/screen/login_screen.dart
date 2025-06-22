
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:technician/config/routes/app_routes.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/login/presentation/cubit/login_cubit.dart';
import 'package:technician/feature/login/presentation/widgets/logo_item.dart';
import 'package:technician/widgets/aligment_widget.dart';
import 'package:technician/widgets/button_widget.dart';
import 'package:technician/widgets/message_widget.dart';
import 'package:technician/widgets/text_widget.dart';
import 'package:technician/widgets/textfield_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isErrorMessageAppeared = false , checkedValue = false;
  AlignmentWidget alignmentWidget = AlignmentWidget();


  Widget loginWidget(){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 100.h),
          const LogoItem(),
          SizedBox(
            height: 20.h,
          ),
          TextWidget(text: 'capitalLogin'.tr, fontSize: 32 , fontWeight: FontWeight.w700,),
          TextWidget(text: 'welcomePhase'.tr, fontSize: 14 , fontColor: AppColors.primaryLightColor, fontWeight: FontWeight.w500,),
          SizedBox(
            height: 13.h,
          ),
          SizedBox(height: 15.h),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: alignmentWidget.returnAlignment(),
                  margin: EdgeInsets.symmetric(horizontal: 30.w),
                  child: TextWidget(text: 'emailAddress'.tr, fontSize: 16 , fontWeight: FontWeight.w600,),
                ),
                SizedBox(height: 3.h,),
                TextFieldWidget(
                  hintText: '',
                  height: 60,
                  width: MediaQuery.of(context).size.width / 1.3,
                  controller: emailController,
                  isPasswordTextField: false,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 5.h),
                Container(
                  alignment: alignmentWidget.returnAlignment(),
                  margin: EdgeInsets.symmetric(horizontal: 30.w),
                  child: TextWidget(text: 'password'.tr, fontSize: 16 , fontWeight: FontWeight.w600,),
                ),
                SizedBox(height: 3.h,),
                TextFieldWidget(
                  hintText: '',
                  height: 60,
                  width: MediaQuery.of(context).size.width / 1.3,
                  controller: passwordController,
                  isPasswordTextField: true,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 8.h),
                rememberMeAndForgotPassword(),
                SizedBox(height: 30.h),
                ButtonWidget(
                  btColor: AppColors.buttonColor,
                  height: 50,
                  onTap: () {
                    login();
                  },
                  name: 'capitalLogin'.tr,
                  width: MediaQuery.of(context).size.width / 1.3,
                ),
                SizedBox(height: 15.h),
                SizedBox(
                  height: 4.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget rememberMeAndForgotPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  onChanged(!checkedValue);
                },
                child: Container(
                  width: 16.w,
                  height: 16.w,
                  decoration: BoxDecoration(
                    color: checkedValue ? AppColors.secondColor : Colors.transparent, // Red background when checked
                    borderRadius: BorderRadius.circular(6), // Rounded corners
                    border: Border.all(
                      color: AppColors.primaryColor, // Red border color
                      width: 2.0,
                    ),
                  ),
                  child: checkedValue
                      ? Center(
                    child: Icon(
                      Icons.check,
                      size: 16.fSize,
                      color: AppColors.whiteColor, // White checkmark color
                    ),
                  ) : null,
                ),
              ),
              SizedBox(width: 4.w), // Space between checkbox and text
              Container(
                margin: EdgeInsets.only(top: 3.h),
                child: TextWidget(text: 'rememberMe'.tr, fontSize: 14.fSize , fontWeight: FontWeight.w500,),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.forgotPassword);
            },
            child: TextWidget(text: 'forgotPassword'.tr,fontSize: 14.fSize , fontWeight: FontWeight.w500,fontColor: AppColors.secondColor,),
          ),
        ],
      ),
    );
  }

  void onChanged(bool? value) {
    setState(() {
      checkedValue = value!;
    });
  }

  void moveToLoginScreen() {
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.main, (Route<dynamic> route) => false);
      context.read<LoginCubit>().initLoginPage();
    });
  }

  Widget checkState(LoginState state){
    if(state is LoginIsLoading){
      initialErrorStatus();
      return const Center(child: CircularProgressIndicator(color: AppColors.mainColor,),);
    } else if(state is LoginError){
      showErrorMessage(state.msg);
      return loginWidget();
    } else if(state is LoginLoaded) {
      if(state.login.role.contains("employee")){
        moveToLoginScreen();
      }else{
        showErrorMessage('permissionDenied'.tr);
      }
      return loginWidget();
    } else {
      return loginWidget();
    }
  }

  void login(){
    if(emailController.value.text.isEmpty){
      MessageWidget.showSnackBar('emptyEmail'.tr, AppColors.red);
      return;
    }
    if(passwordController.value.text.isEmpty){
      MessageWidget.showSnackBar('emptyPassword'.tr, AppColors.red);
      return;
    }
    context.read<LoginCubit>().login(emailController.value.text.toString(), passwordController.value.text.toString() , checkedValue);
  }

  showErrorMessage(String message){
    Future.delayed(const Duration(milliseconds: 500), () {
      if(!isErrorMessageAppeared){
        MessageWidget.showSnackBar(message, AppColors.redAlertColor);
        setState(() {
          isErrorMessageAppeared = true;
        });
      }
    });
  }

  initialErrorStatus(){
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isErrorMessageAppeared = false;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<LoginCubit , LoginState>(builder: (context , state){
      return Scaffold(
          body: checkState(state)
      );
    });
  }
}
