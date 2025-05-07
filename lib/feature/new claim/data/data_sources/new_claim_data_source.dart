import 'dart:io';

abstract class NewClaimDataSource{

  Future<Map<String, dynamic>> getBuildings();

  Future<Map<String, dynamic>> getUnits(String buildingId);

  Future<Map<String, dynamic>> getCategories(String unitId);

  Future<Map<String, dynamic>> getClaimsType(String subCategoryId);

  Future<Map<String, dynamic>> getAvailableTimes(String companyId);

  Future<Map<String , dynamic>> deleteFile(String claimId,String fileId);

  Future<Map<String, dynamic>> addNewClaim(String unitId , String categoryId , String subCategoryId ,
      String claimTypeId, String description , String availableTime , String availableDate, List<File> file,);

  Future<Map<String, dynamic>> updateClaim( String categoryId , String subCategoryId ,
      String claimTypeId, String description , String availableTime , String availableDate,
      // List<File> file,
      String claimId,
      String priority,
      );
}