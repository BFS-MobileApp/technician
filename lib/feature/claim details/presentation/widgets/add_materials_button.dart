import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../config/PrefHelper/helper.dart';

import 'package:technician/core/utils/app_consts.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/claim%20details/presentation/cubit/claim_details_cubit.dart';
import 'package:technician/widgets/svg_image_widget.dart';
import 'package:technician/widgets/text_widget.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../claims/data/models/technician_model.dart';
import '../../data/models/claim_details_model.dart';
import 'claim_materials.dart';
class AddMaterialsButton extends StatelessWidget {
  final List<ClaimMaterials> materials;
  final String referenceId;
  final int claimId;
  const AddMaterialsButton({super.key, required this.materials, required this.referenceId, required this.claimId});

  Widget reAssignWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Container(
        width: 327.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: const BorderRadius.all(
              Radius.circular(25.0)
          ),
          border: Border.all(
              color: AppColors.mainColor
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SVGImageWidget(
                  image: AssetsManager.signatureIcon, width: 18.w, height: 18.h),
              SizedBox(width: 12.w,),
              Container(
                margin: EdgeInsets.only(top: 5.h),
                child: Text(
                  "Add Materials",
                  style: TextStyle(color: AppColors.whiteColor,
                      fontSize: 18.fSize,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) =>  ClaimMaterialsScreen(materials: materials,referenceId: referenceId, claimId: claimId,)),
        );
      },
        child: reAssignWidget());
  }
}
