import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:technician/core/error/exceptions.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/network/network_info.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/feature/claim%20details/data/data_sources/claims_details_data_source.dart';
import 'package:technician/feature/claim%20details/data/models/claim_details_model.dart';
import 'package:technician/feature/claim%20details/domain/repositories/claims_details_repository.dart';
import 'package:technician/widgets/message_widget.dart';

class ClaimsDetailsRepositoryImpl extends ClaimsDetailsRepository{

  final NetworkInfo networkInfo;
  final ClaimsDetailsDataSource claimsDetailsDataSource;

  ClaimsDetailsRepositoryImpl({required this.networkInfo,required this.claimsDetailsDataSource});

  @override
  Future<Either<Failures, bool>> downloadSignature(GlobalKey<SfSignaturePadState> _signaturePadKey) async{
    if(await networkInfo.isConnected){
      try{
        final response = await claimsDetailsDataSource.downloadSignature(_signaturePadKey);
        return Right(response);
      } on ServerException{
        return Left(ServerFailure(msg: 'error'.tr));
      }
    } else {
      return Left(CashFailure(msg: 'connectionError'.tr));
    }
  }

  @override
  Future<Either<Failures, bool>> assignClaim(String claimId, String employeeId, String startDate, String endDate) async{
    if(await networkInfo.isConnected){
      try{
        final response = await claimsDetailsDataSource.assignClaim(claimId , employeeId , startDate , endDate);
        final int statusCode = response['statusCode'];
        print(response['data']);
        if(statusCode == 200){
          MessageWidget.showSnackBar(response['data']['message'].toString(), AppColors.green);
          return const Right(true);
        } else {
          MessageWidget.showSnackBar(response['data']['message'].toString(), AppColors.errorColor);
          return Left(ServerFailure(msg: 'error'.tr));
        }
      } on ServerException{
        return Left(ServerFailure(msg: 'error'.tr));
      }
    } else {
      return Left(CashFailure(msg: 'connectionError'.tr));
    }
  }

  @override
  Future<Either<Failures, bool>> changePriority(int claimId, String priority) async{
    if(await networkInfo.isConnected){
      try{
        final response = await claimsDetailsDataSource.changePriority(claimId , priority);
        final int statusCode = response['statusCode'];
        if(statusCode == 200){
          print(response['data']);
          MessageWidget.showSnackBar(response['data']['message'].toString(), AppColors.green);
          return const Right(true);
        } else {
          MessageWidget.showSnackBar(response['data']['message'].toString(), AppColors.errorColor);
          return Left(ServerFailure(msg: 'error'.tr));
        }
      } on ServerException{
        return Left(ServerFailure(msg: 'error'.tr));
      }
    } else {
      return Left(CashFailure(msg: 'connectionError'.tr));
    }
  }

  @override
  Future<Either<Failures, ClaimDetailsModel>> getClaimDetails(String referenceId) async {
    if(await networkInfo.isConnected){
      try{
        final response = await claimsDetailsDataSource.getClaimDetails(referenceId);
        print(response['data']);
        final int statusCode = response['statusCode'];
        if(statusCode == 200){
          final ClaimDetailsModel claims = ClaimDetailsModel.fromJson(response['data']);
          return Right(claims);
        } else {
          return Left(ServerFailure(msg: 'error'.tr));
        }
      } on ServerException{
        return Left(ServerFailure(msg: 'error'.tr));
      }
    } else {
      return Left(CashFailure(msg: 'connectionError'.tr));
    }
  }

  @override
  Future<Either<Failures, bool>> startAndEndWork(String claimId) async{
    if(await networkInfo.isConnected){
      try{
        final response = await claimsDetailsDataSource.startAndEndWork(claimId);
        final int statusCode = response['statusCode'];
        if(statusCode == 200){
          print(response['data']);
          MessageWidget.showSnackBar(response['data']['message'].toString(), AppColors.green);
          return const Right(true);
        } else {
          MessageWidget.showSnackBar(response['data']['message'].toString(), AppColors.errorColor);
          return Left(ServerFailure(msg: 'error'.tr));
        }
      } on ServerException{
        return Left(ServerFailure(msg: 'error'.tr));
      }
    } else {
      return Left(CashFailure(msg: 'connectionError'.tr));
    }
  }

  @override
  Future<Either<Failures, bool>> addComment(String claimId, String comment , String status) async{
    if(await networkInfo.isConnected){
      try{
        final response = await claimsDetailsDataSource.addComment(claimId , comment , status);
        final int statusCode = response['statusCode'];
        if(statusCode == 200){
          print(response['data']);
          MessageWidget.showSnackBar(response['data']['message'].toString(), AppColors.green);
          return const Right(true);
        } else {
          MessageWidget.showSnackBar(response['data']['message'].toString(), AppColors.errorColor);
          return Left(ServerFailure(msg: 'error'.tr));
        }
      } on ServerException{
        return Left(ServerFailure(msg: 'error'.tr));
      }
    } else {
      return Left(CashFailure(msg: 'connectionError'.tr));
    }
  }

  @override
  Future<Either<Failures, bool>> addSignature(String claimId, File signatureFile , String comment) async{
    if(await networkInfo.isConnected){
      try{
        final response = await claimsDetailsDataSource.addSignature(claimId , signatureFile , comment);
        final int statusCode = response['statusCode'];
        if(statusCode == 200){
          print(response['data']);
          MessageWidget.showSnackBar(response['data']['message'].toString(), AppColors.green);
          return const Right(true);
        } else {
          MessageWidget.showSnackBar(response['data']['message'].toString(), AppColors.errorColor);
          return Left(ServerFailure(msg: 'error'.tr));
        }
      } on ServerException{
        return Left(ServerFailure(msg: 'error'.tr));
      }
    } else {
      return Left(CashFailure(msg: 'connectionError'.tr));
    }
  }

  @override
  Future<Either<Failures, bool>> changeClaimStatus(String claimId, String status) async{
    if(await networkInfo.isConnected){
      try{
        final response = await claimsDetailsDataSource.changeClaimStatus(claimId , status);
        final int statusCode = response['statusCode'];
        if(statusCode == 200){
          print(response['data']);
          MessageWidget.showSnackBar(response['data']['message'].toString(), AppColors.green);
          return const Right(true);
        } else {
          MessageWidget.showSnackBar(response['data']['message'].toString(), AppColors.errorColor);
          return Left(ServerFailure(msg: 'error'.tr));
        }
      } on ServerException{
        return Left(ServerFailure(msg: 'error'.tr));
      }
    } else {
      return Left(CashFailure(msg: 'connectionError'.tr));
    }
  }
 }