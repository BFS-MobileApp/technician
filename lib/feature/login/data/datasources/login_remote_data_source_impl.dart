

import 'package:technician/core/api/api_consumer.dart';
import 'package:technician/core/api/end_points.dart';
import 'package:technician/feature/login/data/models/login_model.dart';

import 'login_remote_data_source.dart';

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  ApiConsumer consumer;

  LoginRemoteDataSourceImpl({required this.consumer});

  @override
  Future<Map<String, dynamic>> login(String email , String password) async{
    final body = {
      "email":email,
      "password":password,
    };
    final res = await consumer.post(EndPoints.login  , body: body);
    return res;
  }
}
