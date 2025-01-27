import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/forgot%20password/presentation/cubit/forgot_password_cubit.dart';
import 'package:technician/widgets/aligment_widget.dart';
import 'package:technician/widgets/app_bar_widget.dart';
import 'package:technician/widgets/button_widget.dart';
import 'package:technician/widgets/message_widget.dart';
import 'package:technician/widgets/text_widget.dart';
import 'package:technician/widgets/textfield_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  AlignmentWidget alignmentWidget = AlignmentWidget();

  Widget screenWidget(){
    return ListView(
      children: [
        ClaimizerAppBar(title: ''),
        SizedBox(height: 80.h,),
        Center(
          child: TextWidget(text: 'forgotPasswordWithoutMark'.tr, fontSize: 25.fSize , fontWeight: FontWeight.bold,),
        ),
        SizedBox(height: 5.h,),
        Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 85.w),
            child: TextWidget(text: 'forgotPasswordPhase'.tr,fontColor: AppColors.primaryLightColor , fontSize: 14.fSize,fontWeight: FontWeight.w500,maxLine: 2,),
          ),
        ),
        SizedBox(height: 50.h,),
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
                hintText: 'email'.tr,
                height: 60,
                width: MediaQuery.of(context).size.width / 1.3,
                controller: emailController,
                isPasswordTextField: false,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20.h),
              ButtonWidget(
                btColor: AppColors.buttonColor,
                height: 50,
                onTap: () {
                  if(emailController.value.text.isEmpty){
                    MessageWidget.showSnackBar('pleaseEnterYourEmail', AppColors.errorColor);
                    return;
                  }
                  BlocProvider.of<ForgotPasswordCubit>(context).forgotPassword(emailController.value.text.toString());
                },
                name: 'sendRequestLink'.tr,
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
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenWidget(),
    );
  }
}
