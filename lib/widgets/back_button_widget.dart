import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';

import '../config/routes/app_routes.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.main,
                  (Route<dynamic> route) => false,
            );
          },
          child: Container(
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.transparent,
                width: 1.0,
              ),
            ),
            child: Center(
              child: AppStrings.appLocal != 'en'
                  ? RotatedBox(
                quarterTurns: 2,
                child: SvgPicture.asset(
                  AssetsManager.backIcon,
                  width: 16.w,
                  height: 16.h,
                ),
              )
                  : SvgPicture.asset(
                AssetsManager.backIcon,
                width: 16.w,
                height: 16.h,
              ),
            ),
          ),
        )
      ],
    );
  }
}
