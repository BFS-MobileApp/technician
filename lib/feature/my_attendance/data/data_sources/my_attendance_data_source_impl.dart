import 'package:technician/core/api/api_consumer.dart';
import 'package:technician/core/api/end_points.dart';
import 'package:technician/feature/my_attendance/data/data_sources/my_attendance_data_source.dart';

class MyAttendanceDataSourceImpl extends MyAttendanceDataSource{

  ApiConsumer consumer;


  MyAttendanceDataSourceImpl({required this.consumer});

  @override
  Future<Map<String, dynamic>> getAttendance() async{
    final res = await consumer.get(EndPoints.myAttendance);
    return res;
  }


}