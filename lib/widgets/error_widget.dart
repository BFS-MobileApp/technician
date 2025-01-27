import 'package:flutter/material.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:get/get.dart';

class ErrorWidgetItem extends StatelessWidget {

  final VoidCallback onTap;
  const ErrorWidgetItem({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Icon(Icons.warning_amber_rounded , size: 150.adaptSize, color: AppColors.mainColor,),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 12.w),
          child: Text('somethingWentWrong'.tr , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w700 , fontSize: 20.fSize),),
        ),
        Text('pleaseTryAgain'.tr , style:  TextStyle(color: AppColors.grey , fontSize: 18.fSize , fontWeight: FontWeight.w500),),
        Container(
          width: context.width*0.55,
          height: 55.h,
          margin: EdgeInsets.symmetric(vertical: 15.w),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainColor,
                foregroundColor: Theme.of(context).primaryColor,
                elevation: 500,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)
                )
            ),
            onPressed: onTap,
            child: Text('reloadScreen'.tr , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white , fontSize: 20.fSize),),
          ),
        )
      ],
    );
  }
}
