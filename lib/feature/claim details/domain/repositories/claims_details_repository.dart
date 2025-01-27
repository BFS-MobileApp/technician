import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/feature/claim%20details/data/models/claim_details_model.dart';

abstract class ClaimsDetailsRepository{

  Future<Either<Failures , bool>> downloadSignature(GlobalKey<SfSignaturePadState> _signaturePadKey);

  Future<Either<Failures , bool>> assignClaim(String claimId , String employeeId , String startDate , String endDate);

  Future<Either<Failures , bool>> changePriority(int claimId , String priority);

  Future<Either<Failures , ClaimDetailsModel>> getClaimDetails(String referenceId);

  Future<Either<Failures , bool>> startAndEndWork(String claimId);

  Future<Either<Failures , bool>> addComment(String claimId , String comment , String status);

  Future<Either<Failures , bool>> addSignature(String claimId , File signatureFile , String comment);

  Future<Either<Failures , bool>> changeClaimStatus(String claimId , String status);

}