import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';

class NoDataWidgetGrid extends StatelessWidget {
  const NoDataWidgetGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      margin: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: 36.w,
              width: 36.w,
              child: SvgPicture.asset(AssetsManager.noSearchResult , width: 20.w, height: 20.h,),),
          SizedBox(height: 2.w),
          Text(
            'noResult'.tr,
            style: GoogleFonts.montserrat(fontSize: 14.fSize, fontWeight: FontWeight.w500, color: AppColors.darkTextColor),
          ),
          SizedBox(height: 6.h,),
          InkWell(
            onTap: () async {},
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
                decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Text('refresh'.tr)),
          )
        ],
      ),
    );
  }
}
