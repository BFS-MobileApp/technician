import 'package:technician/core/api/api_consumer.dart';
import 'package:technician/core/api/end_points.dart';
import 'package:technician/feature/notification/data/data_sources/notification_remote_data_source.dart';

class NotificationRemoteDataSourceImpl extends NotificationRemoteDataSource{

  ApiConsumer consumer;


  NotificationRemoteDataSourceImpl({required this.consumer});

  @override
  Future<Map<String, dynamic>> getNotifications() async{
    final res = await consumer.get(EndPoints.notifications);
    return res;
  }


}