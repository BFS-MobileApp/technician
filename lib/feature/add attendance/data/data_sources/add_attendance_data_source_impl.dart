import 'package:technician/core/api/api_consumer.dart';
import 'package:technician/core/api/end_points.dart';
import 'package:technician/feature/add%20attendance/data/data_sources/add_attendance_data_source.dart';

class AddAttendanceDataSourceImpl extends AddAttendanceDataSource{

  ApiConsumer consumer;

  AddAttendanceDataSourceImpl({required this.consumer});

  @override
  Future<Map<String, dynamic>> checkIn(String longitude, String latitude, String note) async{
    final data = {
      "longitude":longitude,
      "latitude":latitude,
      "note":note,
      "type":"in"
    };
    final res = await consumer.post(EndPoints.addAttendance , body: data);
    return res;
  }

  @override
  Future<Map<String, dynamic>> checkOut(String longitude, String latitude, String note) async{
    final data = {
      "longitude":longitude,
      "latitude":latitude,
      "note":note,
      "type":"out"
    };
    final res = await consumer.post(EndPoints.addAttendance , body: data);
    return res;
  }
}