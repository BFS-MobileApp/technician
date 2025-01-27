import 'dart:convert';

import 'package:technician/core/api/api_consumer.dart';
import 'package:http/http.dart' as http;
import 'package:technician/core/api/end_points.dart';
import 'package:technician/feature/reset_password/data/data_sources/reset_password_remote_data_source.dart';

class ResetPasswordRemoteDataSourceImpl extends ResetPasswordRemoteDataSource{

  ApiConsumer consumer;


  ResetPasswordRemoteDataSourceImpl({required this.consumer});

  @override
  Future<Map<String, dynamic>> resetPassword(String email , String token , String password , String confirmPassword) async {
    final data = {
      "token": token,
      "email": email,
      "password": password,
      "password_confirmation": confirmPassword
    };
    final res = await consumer.post(EndPoints.resetPassword , body: data);
    return res;
  }

}