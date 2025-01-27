import 'package:flutter/material.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/widgets/text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ClaimDetailsTextItem extends StatelessWidget {

  String itemName;
  String itemValue;
  String type;
  bool isClickable;

  ClaimDetailsTextItem({super.key , required this.itemName , required this.itemValue , required this.type , required this.isClickable});

  String _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  void launchItem() async{
    if(type == AppStrings.email){
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: itemValue,
        query: _encodeQueryParameters(<String, String>{
          'subject': 'Example Subject',
          'body': 'Hello, this is an example email.'
        }),
      );
      await launchUrl(emailLaunchUri);
    } else if(type == AppStrings.tel){
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: itemValue,
      );
      await launchUrl(launchUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w , vertical: 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(text: itemName, fontSize: 16.fSize , fontWeight: FontWeight.w600, fontColor: const Color(0xFF2E435C),),
          SizedBox(height: 5.h,),
          isClickable ? GestureDetector(
            onTap: (){
              launchItem();
            },
            child: TextWidget(text: itemValue, fontSize: 14.fSize , fontWeight: FontWeight.w400, fontColor: Colors.blueAccent,),
          )
              : TextWidget(text: itemValue, fontSize: 14.fSize , fontWeight: FontWeight.w400, fontColor: AppColors.black,),
        ],
      ),
    );
  }
}
