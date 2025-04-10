import 'dart:io';

import 'package:technician/core/api/end_points.dart';
import 'package:technician/feature/new%20claim/data/data_sources/new_claim_data_source.dart';

import '../../../../core/api/api_consumer.dart';

class NewClaimDataSourceImpl extends NewClaimDataSource {

  ApiConsumer consumer;


  NewClaimDataSourceImpl({required this.consumer});

  @override
  Future<Map<String, dynamic>> getBuildings() async {
    final res = await consumer.get(EndPoints.buildings);
    return res;
  }

  @override
  Future<Map<String, dynamic>> getUnits(String buildingId) async {
    Map<String, dynamic> data = {
      'building': buildingId
    };
    final res = await consumer.get(EndPoints.units, queryParams: data);
    return res;
  }

  @override
  Future<Map<String, dynamic>> getCategories(String unitId) async {
    Map<String, dynamic> data = {
      'property_unit_id': unitId
    };
    final res = await consumer.get(EndPoints.category, queryParams: data);
    return res;
  }

  @override
  Future<Map<String, dynamic>> getClaimsType(String subCategoryId) async {
    Map<String, dynamic> data = {
      'subcategory_id': subCategoryId
    };
    final res = await consumer.get(EndPoints.claimsType, queryParams: data);
    return res;
  }

  @override
  Future<Map<String, dynamic>> getAvailableTimes(String companyId) async {
    Map<String, dynamic> data = {
      'company_id': companyId
    };
    final res = await consumer.get(EndPoints.availableTimes, queryParams: data);
    return res;
  }

  @override
  Future<Map<String, dynamic>> addNewClaim(String unitId,
      String categoryId,
      String subCategoryId,
      String claimTypeId,
      String description,
      String availableTime,
      String availableDate,
      List<File> files,) async {
    Map<String, dynamic> data = {
      'unit_id': unitId,
      'category_id': categoryId,
      'sub_category_id': subCategoryId,
      'claim_type_id': claimTypeId,
      'description': description,
      'available_date': availableTime,
      'available_time': availableDate,
    };

    final Map<String, File> fileMap = {
      for (int i = 0; i < files.length; i++) 'file[$i]': files[i],
    };
    final res = await consumer.postFile(
      EndPoints.claims,
      data: data,
      files: fileMap, // Send the entire list
    );

    return res;
  }
}