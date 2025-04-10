import 'package:flutter/material.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/size_utils.dart';

class ClaimDetailsCardItem extends StatelessWidget {

  Widget cardChildWidget;
  ClaimDetailsCardItem({super.key , required this.cardChildWidget});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w , vertical: 5.w),
        child: cardChildWidget,
      ),
    );
  }
}
