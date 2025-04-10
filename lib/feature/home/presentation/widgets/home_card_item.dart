import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../config/PrefHelper/helper.dart';

import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:technician/widgets/text_widget.dart';

class HomeCardItem extends StatelessWidget {
  const HomeCardItem(
      {super.key, required this.cardColor, required this.title, required this.imageIcon, required this.value, this.onTap , required this.fontColor});

  final String fontColor;
  final Color cardColor;
  final String title;
  final String imageIcon;
  final Function? onTap;
  final String value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>onTap!(),
      child: Container(
        width: 165.w,
        height: 105.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: cardColor.withOpacity(0.15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AutoSizeText(
                  value,
                  style: TextStyle(color: cardColor, fontWeight: FontWeight.w600 , fontSize: 24.fSize),
                  maxLines: 1,
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.all(6.adaptSize),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(200), color: Helper.hexToColor(fontColor).withOpacity(.15)),
                  child: SvgPicture.asset(
                    imageIcon,
                    width: 25.w,
                    height: 25.h,
                  ),
                )
              ],
            ),
            const Spacer(),
            SizedBox(
              width: 130.w,
              child: TextWidget(maxLine: 2, fontWeight: FontWeight.w500 , fontSize: 16.fSize,fontColor: Theme.of(context).textTheme.bodySmall!.color,text: title,),
            ),
          ],
        ),
      ),
    );
  }
}
