import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:technician/core/error/exceptions.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/network/network_info.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/feature/new%20claim/data/data_sources/new_claim_data_source.dart';
import 'package:technician/feature/new%20claim/data/models/avaliable_time_model.dart';
import 'package:technician/feature/new%20claim/data/models/building_model.dart';
import 'package:technician/feature/new%20claim/data/models/category_model.dart';
import 'package:technician/feature/new%20claim/data/models/unit_model.dart';
import 'package:technician/feature/new%20claim/domain/entities/add_new_claim.dart';
import 'package:technician/feature/new%20claim/domain/repositories/new_claim_repository.dart';
import 'package:technician/widgets/message_widget.dart';

import '../models/claim_type_model.dart';

class NewClaimRepositoryImpl extends NewClaimRepository{

  NewClaimDataSource newClaimDataSource;
  final NetworkInfo networkInfo;


  NewClaimRepositoryImpl({required this.newClaimDataSource , required this.networkInfo});

  @override
  Future<Either<Failures, BuildingModel>> getBuildings() async{
    if(await networkInfo.isConnected){
      try{
        final response = await newClaimDataSource.getBuildings();
        final int statusCode = response['statusCode'];
        if(statusCode == 200){
          final BuildingModel model = BuildingModel.fromJson(response['data']);
          return Right(model);
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
  Future<Either<Failures, UnitModel>> getUnits(String buildingId) async{
    if(await networkInfo.isConnected){
      try{
        final response = await newClaimDataSource.getUnits(buildingId);
        final int statusCode = response['statusCode'];
        print(response['data']);
        if(statusCode == 200){
          final UnitModel model = UnitModel.fromJson(response['data']);
          return Right(model);
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
  Future<Either<Failures, CategoryModel>> getCategories(String unitId) async{
    if(await networkInfo.isConnected){
      try{
        final response = await newClaimDataSource.getCategories(unitId);
        final int statusCode = response['statusCode'];
        if(statusCode == 200){
          final CategoryModel model = CategoryModel.fromJson(response['data']);
          return Right(model);
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
  Future<Either<Failures, ClaimsTypeModel>> getClaimsType(String subCategoryId) async{
    if(await networkInfo.isConnected){
      try{
        final response = await newClaimDataSource.getClaimsType(subCategoryId);
        final int statusCode = response['statusCode'];
        if(statusCode == 200){
          final ClaimsTypeModel model = ClaimsTypeModel.fromJson(response['data']);
          return Right(model);
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
  Future<Either<Failures, AvailableTimeModel>> getAvailableTimes(String companyId) async{
    if(await networkInfo.isConnected){
      try{
        final response = await newClaimDataSource.getAvailableTimes(companyId);
        final int statusCode = response['statusCode'];
        if(statusCode == 200){
          final AvailableTimeModel model = AvailableTimeModel.fromJson(response['data']);
          return Right(model);
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
  Future<Either<Failures, AddNewClaim>> addNewClaim(String unitId, String categoryId, String subCategoryId, String claimTypeId, String description, String availableTime, String availableDate) async{
    if(await networkInfo.isConnected){
      try{
        final response = await newClaimDataSource.addNewClaim(unitId , categoryId , subCategoryId , claimTypeId , description , availableTime , availableDate);
        final int statusCode = response['statusCode'];
        print(response['data']);
        if(statusCode == 200){
          MessageWidget.showSnackBar(response['data']['message'], AppColors.green);
          AddNewClaim addNewClaim = AddNewClaim(result: true , claimId: response['data']['id']);
          return Right(addNewClaim);
        } else {
          MessageWidget.showSnackBar(response['data']['message'], AppColors.red);
          return Left(ServerFailure(msg: response['data']['errors'].toString()));
        }
      } on ServerException{
        return Left(ServerFailure(msg: 'error'.tr));
      }
    } else {
      return Left(CashFailure(msg: 'connectionError'.tr));
    }
  }


}