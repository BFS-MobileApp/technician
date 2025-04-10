import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/feature/new%20claim/data/models/avaliable_time_model.dart';
import 'package:technician/feature/new%20claim/data/models/building_model.dart';
import 'package:technician/feature/new%20claim/data/models/category_model.dart';
import 'package:technician/feature/new%20claim/data/models/claim_type_model.dart';
import 'package:technician/feature/new%20claim/data/models/unit_model.dart';
import 'package:technician/feature/new%20claim/domain/entities/add_new_claim.dart';

abstract class NewClaimRepository {

  Future<Either<Failures , BuildingModel>> getBuildings();

  Future<Either<Failures , UnitModel>> getUnits(String buildingId);

  Future<Either<Failures , CategoryModel>> getCategories(String unitId);

  Future<Either<Failures , ClaimsTypeModel>> getClaimsType(String subCategoryId);

  Future<Either<Failures , AvailableTimeModel>> getAvailableTimes(String companyId);

  Future<Either<Failures , AddNewClaim>> addNewClaim(String unitId , String categoryId ,
      String subCategoryId , String claimTypeId,
      String description , String availableTime , String availableDate, List<File> file);


}