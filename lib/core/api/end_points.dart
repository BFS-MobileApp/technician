class EndPoints{

  static const liveUrl = 'https://claimizer.com/api/v3/';

  static const liveUrl2 = 'https://api.claimizer.com/tenant/';

  // static const betaUrl = 'https://beta.claimizer.com/api/v3/';

  static const String login = 'login';

  static const String profile = 'emp-profile';

  static const String claims = 'claims';

  static  String updateClaims(String claimId) => 'claims/$claimId/update';

  static const String homeClaims = 'statistics';

  static const String buildings = 'buildings';

  static const String units = 'units';

  static const String category = 'claims/categories';

  static const String claimsType = 'claims/claim-types';

  static const String availableTimes = 'claims/available-times';

  static const String allTechnician = 'technicaians';

  static const String claimTechnicians = 'claim_technicians';

  static const String assignClaim = 'claims/assign';

  static const String addMaterial = 'claims/add_claim_product';

  static String changePriority(int claimId) => 'claims/$claimId/priority';

  static String claimDetails(String referenceId) => 'claim/$referenceId';

  static String material(int page) => 'materials?page=$page';

  static String deleteMaterial(String materialId) => 'claims/delete_claim_item/$materialId';

  static String deleteFile(String claimId) => 'claims/$claimId/deleteFile';

  static String deleteClaim(String claimId) => 'claims/$claimId';

  static String editMaterial(String materialId) => 'claims/update_qty/$materialId';

  static String uploadFile(String claimId) => 'claims/$claimId/addFile';

  static const String changePassword = 'change-password';

  static const String startAndEndWork = '/claims/toggleWork';

  static const String updateProfile = 'profile';

  static const String addComment = 'claims/comment';

  static const String changeClaimStatus = 'claims/changeStatus';

  static const String notifications = 'show-client-notifications';

  static const String forgotPassword = 'reset-password';

  static const String resetPassword = 'password/reset';

  static const String myAttendance = 'attendance';

  static const String addAttendance = 'attendance/toggle';



}