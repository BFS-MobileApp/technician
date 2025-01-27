import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/widgets/back_button_widget.dart';
import 'package:technician/widgets/svg_image_widget.dart';

class AppHeadline extends StatelessWidget {
  const AppHeadline({super.key,
    required this.title,
    this.isSVGImage = true,
    this.image = '',
    this.addImage = false,
    this.padding=EdgeInsets.zero});

  final String title;

  final EdgeInsets padding;

  final String image;

  final bool addImage;

  final bool isSVGImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [

          Container(
            margin: EdgeInsetsDirectional.only(start: 3.w , bottom: 5.h),
            width: 3.5.w,
            height: 16.h,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: AppColors.mainColor),
          ),
          SizedBox(
            width: 6.w,
          ),
          addImage ? Container(
            margin: EdgeInsets.only(bottom: 5.h),
            child: isSVGImage ? SVGImageWidget(image: image, width: 25, height: 25) : Image.asset(image , width: 25.w , height: 25.h)
          ) : const SizedBox(),
          addImage ? SizedBox(
            width: 6.w,
          ) : const SizedBox(),
          AutoSizeText(title,
              maxLines: 1,
              style: TextStyle(color: AppColors.headlineTextColor, fontWeight: FontWeight.w600 , fontSize: 18.fSize)),
        ],
      ),
    );
  }
}
