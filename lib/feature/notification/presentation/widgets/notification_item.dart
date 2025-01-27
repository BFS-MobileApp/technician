import 'package:flutter/material.dart';
import 'package:technician/config/arguments/routes_arguments.dart';
import 'package:technician/config/routes/app_routes.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/notification/data/models/notification_model.dart';
import 'package:technician/widgets/aligment_widget.dart';
import 'package:technician/widgets/svg_image_widget.dart';
import 'package:technician/widgets/text_widget.dart';

class NotificationItem extends StatelessWidget {

  String date;
  String notificationDate;
  AlignmentWidget alignmentWidget = AlignmentWidget();
  int counter = 0;
  List<Item> items;
  List<String> icons = [AssetsManager.notificationAlert1 , AssetsManager.notificationAlert2 , AssetsManager.notificationAlert3];
  NotificationItem({super.key , required this.date , required this.notificationDate , required this.items});

  int getNextNumber() {
    int currentNumber = counter % 3;
    counter++;
    return currentNumber;
  }

  String extractClaimId(String url) {
    final regex = RegExp(r'claims/([^/]+)');
    final match = regex.firstMatch(url);
    return match != null ? match.group(1) ?? '' : '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            alignment: alignmentWidget.returnAlignment(),
            child: TextWidget(
              text: date,
              fontSize: 14.fSize,
              fontWeight: FontWeight.w500,
              fontColor: const Color(0xFF777A95),
            ),
          ),
          SizedBox(height: 10.h),
          Card(
            elevation: 1,
            color: AppColors.whiteColor,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 15.h),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (ctx, pos) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, Routes.notificationDetailsScreen , arguments: ClaimDetailsArguments(claimId: items[pos].modelId.toString(), referenceId: extractClaimId(items[pos].url)));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Center(
                                child: SVGImageWidget(
                                  image: icons[getNextNumber()],
                                  width: 32.w,
                                  height: 32.h,
                                ),
                              ),
                              SizedBox(width: 15.w),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      text: items[pos].title,
                                      fontSize: 14.fSize,
                                      fontWeight: FontWeight.w500,
                                      fontColor: const Color(0xFF031D3C),
                                    ),
                                    SizedBox(height: 5.h),
                                    TextWidget(
                                      text: items[pos].title,
                                      fontSize: 12.fSize,
                                      fontWeight: FontWeight.w400,
                                      fontColor: const Color(0xFF8C8CA1),
                                      maxLine: 3,
                                    ),
                                    SizedBox(height: 5.h),
                                    TextWidget(
                                      text: notificationDate,
                                      fontSize: 12.fSize,
                                      fontColor: const Color(0xFF2E435C),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          pos == items.length-1 ? const SizedBox() : const Divider(color: AppColors.grey, thickness: 1),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
