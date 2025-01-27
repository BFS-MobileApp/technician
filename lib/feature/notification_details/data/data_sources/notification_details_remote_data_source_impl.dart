import 'package:technician/core/api/api_consumer.dart';
import 'package:technician/core/api/end_points.dart';
import 'package:technician/feature/notification_details/data/data_sources/notification_details_remote_data_source.dart';

class NotificationDetailsRemoteDataSourceImpl extends NotificationDetailsRemoteDataSource{

  ApiConsumer consumer;


  NotificationDetailsRemoteDataSourceImpl({required this.consumer});

  @override
  Future<Map<String, dynamic>> getNotificationsDetails(String referenceId) async{
    final res = await consumer.get(EndPoints.claimDetails(referenceId));
    return res;
  }
}