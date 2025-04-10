import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/claim%20details/presentation/cubit/claim_details_cubit.dart';
import 'package:technician/widgets/text_widget.dart';
import 'dart:typed_data';
import '../../../../core/utils/assets_manager.dart';
import '../../../../widgets/svg_image_widget.dart';

class TenantSignatureButton extends StatefulWidget {

  String claimId;
  String referenceId;
  BuildContext ctx;
  TenantSignatureButton({super.key , required this.claimId , required this.ctx , required this.referenceId});

  @override
  State<TenantSignatureButton> createState() => _TenantSignatureButtonState();
}

class _TenantSignatureButtonState extends State<TenantSignatureButton> {

  final GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey<SfSignaturePadState>();
  TextEditingController subsriberController = TextEditingController();

  bool checkIfTextEmpty = false;

  void _signatureBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AnimatedPadding(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
              ),
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16.0.adaptSize),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(26.0),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.topLeft,
                        child: TextWidget(
                          text: 'tenantSignature'.tr,
                          fontSize: 22.fSize,
                          fontWeight: FontWeight.w600,
                          fontColor: const Color(0xFF031D3C),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Container(
                        margin: EdgeInsets.only(top: 10.h, right: 10.w, left: 10.w),
                        alignment: Alignment.topLeft,
                        child: TextWidget(
                          text: 'drawTenantSignature'.tr,
                          fontSize: 16.fSize,
                          fontWeight: FontWeight.w500,
                          fontColor: const Color(0xFF031D3C),
                        ),
                      ),
                      SizedBox(
                        height: 130.h,
                        width: 315.w,
                        child: SfSignaturePad(
                          key: _signaturePadKey,
                          minimumStrokeWidth: 1,
                          maximumStrokeWidth: 3,
                          strokeColor: Theme.of(context).textTheme.bodySmall!.color,
                          backgroundColor: AppColors.whiteColor,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h, right: 10.w, left: 10.w),
                        alignment: Alignment.topLeft,
                        child: TextWidget(
                          text: 'signerName'.tr,
                          fontSize: 16.fSize,
                          fontWeight: FontWeight.w500,
                          fontColor: const Color(0xFF031D3C),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10.w, left: 10.w),
                        child: TextField(
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.fSize),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.redAccent),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 5.w),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: AppColors.outlineBorderLight)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: AppColors.outlineBorderLight)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: AppColors.rejectedColor)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: AppColors.rejectedColor)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: AppColors.primaryLightColor)),
                            counterText: "",
                            hintStyle: Theme.of(context).textTheme.displaySmall,
                          ),
                          maxLength: 50,
                          keyboardType: TextInputType.text,
                          controller: subsriberController,
                          autofocus: false,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      // Display message if the text field is empty
                      if (checkIfTextEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'pleaseAddSubscriber'.tr,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14.fSize,
                            ),
                          ),
                        ),
                      SizedBox(height: 15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: (){
                                  _signaturePadKey.currentState?.clear();
                                  subsriberController.clear();
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 3.h, bottom: 3.h, left: 13.w, right: 13.w),
                                  decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(color: AppColors.red)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SVGImageWidget(image: AssetsManager.clearIcon, width: 18, height: 18),
                                      SizedBox(width: 5.w),
                                      Container(
                                        margin: EdgeInsets.only(top: 5.h),
                                        child: TextWidget(
                                          text: 'clear'.tr,
                                          fontSize: 17.fSize,
                                          fontWeight: FontWeight.w500,
                                          fontColor: AppColors.errorColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () async {
                                  if (subsriberController.value.text.isEmpty) {
                                    setState(() {
                                      checkIfTextEmpty = true;
                                    });
                                    return;
                                  }
                                  final signatureFile = await getSignatureFile();
                                  context.read<ClaimDetailsCubit>().addSignature(
                                    widget.claimId,
                                    signatureFile,
                                    subsriberController.value.text.toString(),
                                  ).then((value) {
                                    if(value){
                                      setState(() {
                                        checkIfTextEmpty = false;
                                        subsriberController.clear();
                                      });
                                      Navigator.pop(context);
                                      BlocProvider.of<ClaimDetailsCubit>(widget.ctx).getClaimDetails(widget.referenceId);
                                    }
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 5.h, bottom: 5.h, left: 13.w, right: 12.w),
                                  decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(25.0),
                                      border: Border.all(color: const Color(0xFF679C0D))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SVGImageWidget(image: AssetsManager.checkIcon, width: 15, height: 15),
                                      SizedBox(width: 5.w),
                                      Container(
                                        margin: EdgeInsets.only(top: 5.h),
                                        child: TextWidget(
                                          text: 'submit'.tr,
                                          fontSize: 17.fSize,
                                          fontWeight: FontWeight.w500,
                                          fontColor: const Color(0xFF679C0D),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     context.read<ClaimDetailsCubit>().downloadSignature(_signaturePadKey).then((_) {
                          //       Navigator.pop(context);
                          //     });
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.only(top: 5.h, bottom: 5.h, left: 13.w, right: 12.w),
                          //     decoration: BoxDecoration(
                          //         color: AppColors.mainColor,
                          //         borderRadius: BorderRadius.circular(25.0),
                          //         border: Border.all(color: AppColors.mainColor)),
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         const SVGImageWidget(image: AssetsManager.downloadIcon, width: 15, height: 15),
                          //         SizedBox(width: 5.w),
                          //         Container(
                          //           margin: EdgeInsets.only(top: 5.h),
                          //           child: TextWidget(
                          //             text: 'downloadSignature'.tr,
                          //             fontSize: 17.fSize,
                          //             fontWeight: FontWeight.w500,
                          //             fontColor: AppColors.whiteColor,
                          //           ),
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                      SizedBox(height: 15.h),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }


  Future<File> getSignatureFile() async {
    try {
      // Render the signature as an image
      final image = await _signaturePadKey.currentState?.toImage(pixelRatio: 3.0);
      final byteData = await image?.toByteData(format: ImageByteFormat.png);

      if (byteData != null) {
        // Convert image data to Uint8List
        Uint8List imageData = byteData.buffer.asUint8List();

        // Get the temporary directory to store the file
        final tempDir = await getTemporaryDirectory();
        final filePath = '${tempDir.path}/signature.png';

        // Write the image data to the file
        final file = await File(filePath).writeAsBytes(imageData);
        return file;
      }
    } catch (e) {
      print("Error saving signature: $e");
    }
    File file = File('');
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        _signatureBottomSheet(context);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Container(
          width: 327.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: AppColors.mainColor,
            borderRadius:const  BorderRadius.all(
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
                SVGImageWidget(image: AssetsManager.signatureIcon, width: 18.w, height: 18.h),
                SizedBox(width: 12.w,),
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  child: Text(
                    'tenantSignature'.tr,
                    style: TextStyle(color: AppColors.whiteColor , fontSize: 18.fSize , fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
