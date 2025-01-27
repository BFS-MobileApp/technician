abstract class ResetPasswordRemoteDataSource{

  Future<Map<String, dynamic>> resetPassword(String email , String token , String password , String confirmPassword);
}