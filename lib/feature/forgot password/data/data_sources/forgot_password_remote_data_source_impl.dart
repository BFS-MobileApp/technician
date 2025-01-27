import 'package:technician/core/api/api_consumer.dart';
import 'package:technician/core/api/end_points.dart';
import 'package:technician/feature/forgot%20password/data/data_sources/forgot_password_remote_data_source.dart';

class ForgotPasswordRemoteDataSourceImpl extends ForgotPasswordRemoteDataSource{

  ApiConsumer consumer;

  ForgotPasswordRemoteDataSourceImpl({required this.consumer});

  @override
  Future<Map<String, dynamic>> forgotPassword(String email) async{
    final data = {
      "email":email
    };
    final res = await consumer.post(EndPoints.forgotPassword , body: data);
    return res;
  }


}