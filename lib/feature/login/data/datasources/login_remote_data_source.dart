import 'package:technician/feature/login/data/models/login_model.dart';

abstract class LoginRemoteDataSource {

  Future<Map<String, dynamic>> login(String email , String password);

}
