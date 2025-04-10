import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:technician/core/error/exceptions.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/network/network_info.dart';
import 'package:technician/feature/claims/data/data_sources/claims_data_source.dart';
import 'package:technician/feature/claims/data/models/claims_model.dart';
import 'package:technician/feature/claims/data/models/technician_model.dart';
import 'package:technician/feature/claims/domain/repositories/claims_repository.dart';

class ClaimsRepositoryImpl extends ClaimsRepository{

  final NetworkInfo networkInfo;
  final ClaimsDataSource claimsDataSource;


  ClaimsRepositoryImpl({required this.networkInfo , required this.claimsDataSource});

  @override
  Future<Either<Failures, ClaimsModel>> getAllClaims(Map<String, dynamic> data) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await claimsDataSource.getAllClaims(data);
        print(response['data']);
        final int statusCode = response['statusCode'];

        if (statusCode == 200) {
          final ClaimsModel claims = ClaimsModel.fromJson(response['data']);
          return Right(claims);
        } else {
          final String errorMsg = response['data']['error'];
          return Left(ServerFailure(msg: errorMsg));
        }
      } on ServerException catch (e) {
        return Left(ServerFailure(msg: e.message!));
      }
    } else {
      return Left(CashFailure(msg: 'connectionError'.tr));
    }
  }


  @override
  Future<Either<Failures, TechnicianModel>> getAllTechnician(String claimId) async{
    if(await networkInfo.isConnected){
      try{
        final response = await claimsDataSource.getAllTechnician(claimId);
        final int statusCode = response['statusCode'];
        if(statusCode == 200){
          TechnicianModel technicianModel = TechnicianModel.fromJson(response['data']);
          print(technicianModel.data.length);
          return Right(technicianModel);
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
}