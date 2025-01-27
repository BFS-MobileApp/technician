import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';

class EditProfileTextFieldWidget extends StatefulWidget {
  TextEditingController controller;
  bool readOnly;
  bool isPassword;
  TextInputType inputType;


  EditProfileTextFieldWidget({super.key, required this.controller, this.readOnly = false, this.inputType = TextInputType.text , required this.isPassword});

  @override
  State<EditProfileTextFieldWidget> createState() => _EditProfileTextFieldWidgetState();
}

class _EditProfileTextFieldWidgetState extends State<EditProfileTextFieldWidget> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.w),
      child: TextField(
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.fSize),
        readOnly: widget.readOnly,
        obscureText: widget.isPassword && !showPassword,  // Updated to dynamically show/hide password
        decoration: InputDecoration(
          suffixIcon: widget.isPassword
              ? GestureDetector(
            onTap: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: showPassword
                  ? SvgPicture.asset(
                AssetsManager.showPassword,
                color: AppColors.darkBlueColor,
              )
                  : SvgPicture.asset(
                AssetsManager.hidePassword,
                color: AppColors.darkBlueColor,
              ),
            ),
          )
              : const SizedBox(),
          errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.redAccent),
          contentPadding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 5.w),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.outlineBorderLight)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.outlineBorderLight)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.rejectedColor)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.rejectedColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primaryLightColor)),
          counterText: "",
          hintStyle: Theme.of(context).textTheme.displaySmall,
        ),
        inputFormatters: [LengthLimitingTextInputFormatter(50)],
        maxLength: 50,
        keyboardType: widget.inputType,
        controller: widget.controller,
        autofocus: false,
        textInputAction: TextInputAction.next,
      ),
    );
  }
}

