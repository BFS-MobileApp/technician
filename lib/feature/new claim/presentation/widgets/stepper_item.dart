import 'package:flutter/material.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/widgets/svg_image_widget.dart';

class SteeperItem extends StatelessWidget {

  int index;

  int currentStep;

  String item;
  SteeperItem({super.key , required this.index , required this.currentStep , required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: currentStep == index
              ? AppColors.mainColor
              : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: AppColors.dividerColor.withOpacity(.6),
              width: 2.w)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          currentStep == index ? SVGImageWidget(image: AssetsManager.whiteBuildingIcon , width: 24.fSize , height: 24.fSize,) : SVGImageWidget(image: AssetsManager.buildingIcon , width: 24.fSize , height: 24.fSize,),
          SizedBox(height: 10.h,),
          Text(
            item,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.fSize,
              fontWeight: FontWeight.w600,
              color: currentStep == index
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
