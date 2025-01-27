import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/claim%20details/presentation/cubit/claim_details_cubit.dart';
import 'package:technician/widgets/svg_image_widget.dart';

class CompleteButton extends StatefulWidget {
  String claimId;
  String referenceId;
  BuildContext ctx;
  CompleteButton({super.key , required this.claimId , required this.referenceId , required this.ctx});

  @override
  State<CompleteButton> createState() => _CompleteButtonState();
}

class _CompleteButtonState extends State<CompleteButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        BlocProvider.of<ClaimDetailsCubit>(context).changeClaimStatus(widget.claimId , 'completed').then((value){
          if(value){
            Navigator.pop(widget.ctx , true);
          }
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Container(
          width: 327.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: AppColors.mainColor,
            borderRadius:const  BorderRadius.all(
                Radius.circular(25.0)
            ),
            border: Border.all(
                color: AppColors.mainColor
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SVGImageWidget(image: AssetsManager.acceptIcon, width: 18.w, height: 18.h),
                SizedBox(width: 12.w,),
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  child: Text(
                    'completeButton'.tr,
                    style: TextStyle(color: AppColors.whiteColor , fontSize: 18.fSize , fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
