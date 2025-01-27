
abstract class ClaimsDataSource{

  Future<Map<String, dynamic>> getAllClaims(Map<String, dynamic> data);

  Future<Map<String, dynamic>> getAllTechnician(String claimId);
}