import 'package:technician/feature/home/data/models/profile_model.dart';

abstract class HomeRemoteDataSource {

  Future<Map<String, dynamic>> getUserInfo();

  Future<Map<String, dynamic>> getClaimsCount();

}