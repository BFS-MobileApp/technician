import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';

class AppBarItem extends StatelessWidget {

  final String title;
  String image;
  int fontSize;
  Color fontColor;
  FontWeight textFontWeight;

  AppBarItem({
    super.key,
    required this.title,
    this.image = AssetsManager.backIcon,
    this.fontSize = 18,
    this.textFontWeight = FontWeight.w700,
    this.fontColor = const Color(0xFF4A4A68)
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
        margin: EdgeInsets.symmetric(vertical: 5.h , horizontal: 12.w),
        padding: EdgeInsets.only(top: 5.h),
        child:Row(
          children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context , true);
                },
                child: Container(
                  width: 20.w, // Set the size of the container
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: Colors.transparent, // Transparent background
                    shape: BoxShape.circle,    // Rounded container
                    border: Border.all(        // Optional border
                      color: Colors.transparent,       // Border color (can customize)
                      width: 1.0,              // Border width
                    ),
                  ),
                  child: Center(
                    child: AppStrings.appLocal != 'en'
                        ? RotatedBox(
                      quarterTurns: 2,
                      child: SvgPicture.asset(
                        image,width: 16.w,height: 16.h,
                      ),
                    )
                        : SvgPicture.asset(
                      image,width: 18.w,height: 18.h,
                    )
                  ),
                ),),
            Expanded(
              child: Center(
                child: AutoSizeText(
                  capitalize(title),
                  style: TextStyle(fontSize:  fontSize.fSize , fontWeight: textFontWeight , color: fontColor),
                ),
              ),
            )
          ],
        )
    );
  }
}