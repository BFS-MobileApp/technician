import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

abstract class ClaimsDetailsDataSource{

  Future<bool> downloadSignature(GlobalKey<SfSignaturePadState> _signaturePadKey);

  Future<Map<String, dynamic>> assignClaim(String claimId , String employeeId , String startDate , String endDate);

  Future<Map<String , dynamic>> changePriority(int claimId , String priority);

  Future<Map<String , dynamic>> getClaimDetails(String referenceId);

  Future<Map<String , dynamic>> startAndEndWork(String claimId);

  Future<Map<String , dynamic>> addComment(String claimId, String comment , String status);

  Future<Map<String , dynamic>> addSignature(String claimId, File signatureFile , String comment);

  Future<Map<String , dynamic>> changeClaimStatus(String claimId, String status);

}