import 'package:flutter/material.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/widgets/svg_image_widget.dart';

class AssignButton extends StatelessWidget {

  final String btText;

  final String image;

  final double width;

  final double height;

  final Color btColor;

  final Color btTextColor;

  final double horizontalMargin;

  final Color borderColor;

  const AssignButton({super.key ,  required this.borderColor , this.horizontalMargin = 0 , required this.btText , required this.image , required this.width , required this.btTextColor , required this.height , required this.btColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalMargin.w),
        child: Container(
          width: width.w,
          height: height.h,
          decoration: BoxDecoration(
            color: btColor,
            borderRadius:const  BorderRadius.all(
                Radius.circular(25.0)
            ),
            border: Border.all(
            color: borderColor
          ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                image == '' ? const SizedBox(): SVGImageWidget(image: image, width: 18.w, height: 18.h),
                image == '' ? const SizedBox(): SizedBox(width: 12.w,),
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  child: Text(
                    btText,
                    style: TextStyle(color: btTextColor , fontSize: 18.fSize , fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
}


