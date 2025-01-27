import 'package:flutter/material.dart';
import 'package:technician/core/utils/size_utils.dart';

class VerticalDataItem extends StatelessWidget {

  final String itemName;
  final String itemValue;

  final IconData itemIcon;
  const VerticalDataItem({super.key , required this.itemName , required this.itemValue , required this.itemIcon});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align items to the start (left)
        children: [
          Row(
            children: [
              Icon(
                itemIcon, // Use a function to get the icon for the label
                color: Colors.blue,
                size: 18.fSize,
              ),
              SizedBox(width: 8.0.w),
              Text(
                '$itemName:',
                style: TextStyle(
                  fontSize: 14.fSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0.h), // Add spacing between the label and data
          Text(
            itemValue,
            style: TextStyle(
              fontSize: 14.fSize,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}
