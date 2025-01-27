import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:technician/core/api/api_consumer.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/feature/claim%20details/data/data_sources/claims_details_data_source.dart';
import 'package:technician/widgets/message_widget.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

import '../../../../core/api/end_points.dart';

class ClaimsDetailsDataSourceImpl extends ClaimsDetailsDataSource {
  ApiConsumer consumer;

  ClaimsDetailsDataSourceImpl({required this.consumer});

  @override
  Future<bool> downloadSignature(GlobalKey<SfSignaturePadState> _signaturePadKey) async {
    final signaturePadState = _signaturePadKey.currentState;
    if (signaturePadState == null) {
      MessageWidget.showSnackBar('SignaturePadStateIsNull'.tr, AppColors.errorColor);
      return false;
    }
    try {
      ui.Image image = await signaturePadState.toImage();
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        debugPrint('Failed to convert image to byte data');
        return false;
      }
      Uint8List imageBytes = byteData.buffer.asUint8List();
      final result = await SaverGallery.saveImage(
        skipIfExists: false,
        imageBytes,
        quality: 100,
        fileName: 'signature_image',
      );
      if (result.isSuccess) {
        MessageWidget.showSnackBar('SignatureSavedToGallery'.tr, AppColors.darkGreen);
      } else {
        MessageWidget.showSnackBar('errorSavingSignatureToGallery'.tr, AppColors.errorColor);
      }
    } catch (e) {
      MessageWidget.showSnackBar('errorSavingSignatureToGallery'.tr, AppColors.errorColor);
      debugPrint('Error: $e');
    }
    return false;
  }

  @override
  Future<Map<String, dynamic>> assignClaim(String claimId, String employeeId, String startDate, String endDate) async {
    final data = {"claim_id": claimId, "employee_id": employeeId, "start_at": startDate, "end_at": endDate};
    final res = await consumer.post(EndPoints.assignClaim, body: data);
    return res;
  }

  @override
  Future<Map<String, dynamic>> changePriority(int claimId, String priority) async {
    final data = {
      "priority": priority,
    };
    final res = await consumer.post(EndPoints.changePriority(claimId), queryParams: data);
    return res;
  }

  @override
  Future<Map<String, dynamic>> getClaimDetails(String referenceId) async {
    final res = await consumer.get(EndPoints.claimDetails(referenceId));
    return res;
  }

  @override
  Future<Map<String, dynamic>> startAndEndWork(String claimId) async {
    final data = {'claim_id': claimId};
    final res = await consumer.post(EndPoints.startAndEndWork, queryParams: data);
    return res;
  }

  @override
  Future<Map<String, dynamic>> addComment(String claimId, String comment, String status) async {
    final data = {'claim_id': claimId, 'comment': comment, 'status': status};
    print(data);
    final res = await consumer.post(EndPoints.addComment, body: data);
    return res;
  }

  @override
  Future<Map<String, dynamic>> addSignature(String claimId, File signatureFile, String comment) async {
    Map<String, dynamic> imageFileData = {};
    final data = {'claim_id': claimId, 'comment': comment};
    if (signatureFile.path != '') {
      imageFileData = {'signature': signatureFile};
    }
    final res = await consumer.postFile(EndPoints.addComment, queryParams: data, files: imageFileData);
    return res;
  }

  @override
  Future<Map<String, dynamic>> changeClaimStatus(String claimId, String status) async {
    final data = {'claim_id': claimId, 'status': status};
    final res = await consumer.post(EndPoints.changeClaimStatus, queryParams: data);
    return res;
  }
}
