import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';

class ClaimizerAppBar extends StatelessWidget {

  final String title;
  String image;

  ClaimizerAppBar({
    super.key,
    required this.title,
    this.image = AssetsManager.backIcon
  });

  String capitalize(String s){
   if(title != ''){
     return s[0].toUpperCase() + s.substring(1);
   }
   return '';
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5.h , horizontal: 8.w),
        padding: EdgeInsets.only(top: 5.h),
        child:Row(
          children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context , true);
                },
                child: AppStrings.appLocal != 'en'
                    ? RotatedBox(
                  quarterTurns: 2,
                  child: SvgPicture.asset(
                    image,
                  ),
                )
                    : SvgPicture.asset(
                  image,
                )),
            Expanded(
              child: Center(
                child: AutoSizeText(
                  capitalize(title),
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, color: AppColors.darkTextColor),
                ),
              ),
            )
          ],
        )
    );
  }
}
