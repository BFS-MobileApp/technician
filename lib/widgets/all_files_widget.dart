import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:technician/config/arguments/routes_arguments.dart';
import 'package:technician/config/routes/app_routes.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/claim%20details/data/models/claim_details_model.dart';
import 'package:technician/widgets/text_widget.dart';

class AllFilesWidget extends StatelessWidget {

  List<FileElement> images;
  final int height;
  AllFilesWidget({super.key , required this.images , this.height = 100});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w , vertical: 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(text: 'allFiles'.tr, fontSize: 16.fSize , fontWeight: FontWeight.w600, fontColor: AppColors.black,),
          SizedBox(height: 8.h,),
          SizedBox(
            height: (images.isNotEmpty || images == null) ? 70.h : 10.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 10.w); // Space between images
              },
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.fullScreenImage , arguments: FullScreenImageArguments(image: images[index].fileUrl));
                  },
                  child: Container(
                    width: 70.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners
                      image: DecorationImage(
                        image: NetworkImage(images[index].fileUrl),
                        fit: BoxFit.cover, // Cover the entire container
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
