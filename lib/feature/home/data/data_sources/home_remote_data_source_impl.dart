import 'package:technician/core/api/api_consumer.dart';
import 'package:technician/core/api/end_points.dart';
import 'package:technician/feature/home/data/data_sources/home_remote_data_source.dart';

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource{

  ApiConsumer consumer;

  HomeRemoteDataSourceImpl({required this.consumer});

  @override
  Future<Map<String, dynamic>> getUserInfo() async{
    final res = await consumer.get(EndPoints.profile);
    return res;
  }

  @override
  Future<Map<String, dynamic>> getClaimsCount() async{
    final res = await consumer.get(EndPoints.homeClaims);
    return res;
  }
}
