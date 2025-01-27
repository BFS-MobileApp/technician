import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/widgets/svg_image_widget.dart';
import 'package:technician/widgets/text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class URLWidget extends StatelessWidget {

  final String itemName;

  final String url;

  final String image;

  final bool isSVG;

  const URLWidget({super.key , required this.itemName , required this.url , required this.image , required this.isSVG});

  Future<void> _launchUrl() async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>_launchUrl(),
      child: Row(
        children: [
          isSVG ? SVGImageWidget(image: image, width: 26, height: 26) : Image.asset(image, width: 26.w, height: 26.h),
          SizedBox(width: 8.w,),
          TextWidget(text: itemName.tr, fontSize: 18 , fontWeight: FontWeight.w500,fontColor: AppColors.lightTextColor.withOpacity(0.8),)
        ],
      ),
    );
  }
}
