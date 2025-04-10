import 'package:flutter/material.dart';
import '../../../../config/PrefHelper/helper.dart';

import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/widgets/svg_image_widget.dart';
import 'package:technician/widgets/text_widget.dart';

class SubmitButton extends StatelessWidget {
  
  String image;
  String text;
  String lang;
  SubmitButton({super.key , required this.image , required this.text , required this.lang});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.whiteColor,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // Apply border radius here
        side: const BorderSide(
          color: AppColors.mainColor, // Border color
          width: 1.0, // Border width
        ),
      ),
      child: Container(
        margin: lang == 'US' ? EdgeInsets.only(left: MediaQuery.of(context).size.width/4.2) : EdgeInsets.only(right: MediaQuery.of(context).size.width/4.2),
        padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SVGImageWidget(image: image, width: 30, height: 30),
            SizedBox(width: 10.w),
            TextWidget(
              text: text,
              fontSize: 16.fSize,
              fontWeight: FontWeight.w600,
              fontColor: Theme.of(context).textTheme.bodySmall!.color,
            ),
          ],
        ),
      ),
    );
  }
}
