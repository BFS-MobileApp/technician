import 'package:flutter/material.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:flutter_svg/svg.dart';

class SVGImageWidget extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  const SVGImageWidget({super.key , required this.image , required this.width , required this.height});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
        image,
        height: height.h,
        width: width.w,
    );
  }
}
