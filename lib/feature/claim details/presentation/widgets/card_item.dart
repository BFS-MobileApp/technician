import 'package:flutter/material.dart';
import 'package:technician/core/utils/size_utils.dart';

class CardItem extends StatelessWidget {
  Widget child;
  CardItem({super.key , required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w , vertical: 2.w),
      child: Column(
        children: [
          Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding:  EdgeInsets.all(16.0.adaptSize),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
