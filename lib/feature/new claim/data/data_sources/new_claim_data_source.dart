abstract class NewClaimDataSource{

  Future<Map<String, dynamic>> getBuildings();

  Future<Map<String, dynamic>> getUnits(String buildingId);

  Future<Map<String, dynamic>> getCategories(String unitId);

  Future<Map<String, dynamic>> getClaimsType(String subCategoryId);

  Future<Map<String, dynamic>> getAvailableTimes(String companyId);

  Future<Map<String, dynamic>> addNewClaim(String unitId , String categoryId , String subCategoryId , String claimTypeId, String description , String availableTime , String availableDate);
}