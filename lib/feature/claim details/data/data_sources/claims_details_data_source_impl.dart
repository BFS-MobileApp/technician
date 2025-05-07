import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:saver_gallery/saver_gallery.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:technician/core/api/api_consumer.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/feature/claim%20details/data/data_sources/claims_details_data_source.dart';
import 'package:technician/widgets/message_widget.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

import '../../../../core/api/end_points.dart';
import '../../../../core/error/exceptions.dart';

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
  Future<Map<String, dynamic>> getMaterial(String referenceId, int page, String? search) async {
    final bool isSearching = search != null && search.isNotEmpty;

    final response = await consumer.get(
      'materials',
      queryParams: {
        'claim_id': referenceId,
        'page': page,
        if (!isSearching) 'is_featured': 'true',
        if (isSearching) 'search': search,
      },
    );
    return response;
  }




  @override
  Future<Map<String, dynamic>> deleteMaterial(String materialId) async {
    final res = await consumer.delete(EndPoints.deleteMaterial(materialId));
    return res;
  }
  @override
  Future<Map<String, dynamic>> deleteClaim(String claimId) async {
    final res = await consumer.delete(EndPoints.deleteClaim(claimId));
    return res;
  }
  @override
  Future<Map<String, dynamic>> editMaterialQuantity(String materialId, int quantity) async {
    final response = await consumer.patch(
      EndPoints.editMaterial(materialId),
      body: {'qty': quantity},
    );
    return response;
  }
  @override
  Future<Map<String, dynamic>> addMaterial(Map<String, dynamic> data) async {
    final response = await consumer.post(
      EndPoints.addMaterial,
      body: data,
    );
    return response;
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
  Future<Map<String, dynamic>> uploadCommentFile(String claimId, String commentId, List<File> file, String status) async {

    final data = {
      'claim_id': claimId,
      'comment': "File Upload",
      'status': status,
    };

    final Map<String, File> fileMap = {
      for (int i = 0; i < file.length; i++) 'file[$i]': file[i],
    };

    print("Uploading file with data: $data");

    // Call `postFile` with correctly formatted files
    final res = await consumer.postFile(EndPoints.addComment, files: fileMap, data: data);

    print("File upload response: $res");
    return res;
  }

  @override
  Future<Map<String, dynamic>> uploadFile(String claimId, List<File> files) async {
    final Map<String, File> fileMap = {
      for (int i = 0; i < files.length; i++) 'file[$i]': files[i],
    };


    final res = await consumer.postFile(EndPoints.uploadFile(claimId), files: fileMap);

    print("File upload response: $res");
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
