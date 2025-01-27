import 'package:flutter/material.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/size_utils.dart';

class ClaimDataItem extends StatelessWidget {

  final String itemName;
  final String itemValue;

  final IconData itemIcon;

  final bool isPriority;
  const ClaimDataItem({super.key , required this.itemName , required this.itemValue , required this.itemIcon , required this.isPriority});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0.w),
      child: Row(
        children: [
          Icon(
            itemIcon,
            color: AppColors.primaryColor,
            size: 18.0.fSize,// Use red for icons
          ),
          SizedBox(width: 8.0.w),
          Expanded(
            child: Text(
              '$itemName: $itemValue ',
              style: TextStyle(
                fontSize: 15.fSize,
                fontWeight: FontWeight.bold, // Bold font weight
                color: Colors.grey[800],
              ),
            ),
          ),
          isPriority ?
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0.h, vertical: 5.0.w),
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
              'Medium',
              style: TextStyle(
                color: Colors.white, // White text color for contrast
                fontWeight: FontWeight.bold,
                fontSize: 15.fSize
              ),
            ),
          ) : const SizedBox(),
        ],
      ),
    );
  }

}
