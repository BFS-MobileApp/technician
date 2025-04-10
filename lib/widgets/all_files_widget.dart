import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:technician/config/arguments/routes_arguments.dart';
import 'package:technician/config/routes/app_routes.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/claim%20details/data/models/claim_details_model.dart';
import 'package:technician/widgets/text_widget.dart';

class AllFilesWidget extends StatelessWidget {
  final Comments images;
  final int height;
  final List<FileElement>  files;

  const AllFilesWidget({super.key, required this.images, this.height = 100, required this.files});

  @override
  Widget build(BuildContext context) {
    // Combine all comment image files
    final commentFiles = images.data
        .expand((element) => (element.files ?? []).map((f) => FileElement.fromJson(f)))
        .toList();


    // Combine with external files list
    final combinedFiles = [...commentFiles, ...files];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: 'allFiles'.tr,
            fontSize: 16.fSize,
            fontWeight: FontWeight.w600,
            fontColor: Theme.of(context).textTheme.bodySmall?.color,
          ),
          SizedBox(height: 8.h),
          if (combinedFiles.isNotEmpty)
            SizedBox(
              height: 70.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: combinedFiles.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: 10.w);
                },
                itemBuilder: (BuildContext context, int index) {
                  final fileUrl = combinedFiles[index].fileUrl ?? '';
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.fullScreenImage,
                        arguments: FullScreenImageArguments(image: fileUrl),
                      );
                    },
                    child: Container(
                      width: 70.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: fileUrl.isNotEmpty
                            ? DecorationImage(
                          image: NetworkImage(fileUrl),
                          fit: BoxFit.cover,
                        )
                            : null,
                        color: fileUrl.isEmpty ? Colors.grey[300] : null,
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
