import 'package:flutter/material.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/widgets/aligment_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DataItem extends StatelessWidget {

  AlignmentWidget alignmentWidget = AlignmentWidget();

  final String itemName;
  final String itemValue;

  final IconData itemIcon;

  final bool addBorder;

  final bool isClickable;

  final String type;

  DataItem({super.key , required this.itemName , required this.itemValue , required this.itemIcon , required this.addBorder , required this.isClickable , this.type = AppStrings.tel});

  Widget borderItem() {
    if (addBorder) {
      return Expanded(
        child: Align(
          alignment: Alignment.topRight,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: double.infinity,
            ),
            child: Container(
              padding: EdgeInsets.all(5.adaptSize),
              decoration: BoxDecoration(
                color: AppColors.primaryColor, // Green background color
                borderRadius: BorderRadius.circular(15.0), //
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 5, // Spread radius
                    blurRadius: 7, // Blur radius
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Text(
                itemValue,
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 15.fSize, // Adjust font size using the responsive extension
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Expanded(
        child: clickableItem(),
      );
    }
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

  String _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
  Widget clickableItem(){
    if(isClickable){
      return InkWell(
        onTap: ()=>launchItem(),
        child: Text(
          itemValue,
          textAlign: TextAlign.end,
          style: TextStyle(
            fontSize: 15.fSize, // Adjust font size using the responsive extension
            color: Colors.blue,
          ),
        ),
      );
    } else {
      return Text(
        itemValue,
        textAlign: TextAlign.end,
        style: TextStyle(
          fontSize: 15.fSize, // Adjust font size using the responsive extension
          color: Colors.grey[800],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: Row(
        children: [
          Icon(
            itemIcon,
            color: Colors.blue,
            size: 18.0.fSize, // Adjust icon size using the responsive extension
          ),
          SizedBox(width: 8.0.w), // Adjust spacing using the responsive extension
          Text(
            '$itemName:',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15.fSize, // Adjust font size using the responsive extension
            ),
          ),
          SizedBox(width: 8.0.w), // Adjust spacing using the responsive extension
          borderItem(),
        ],
      ),
    );
  }

}
