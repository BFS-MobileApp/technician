abstract class AddAttendanceDataSource{

    Future<Map<String , dynamic>> checkIn(String longitude , String latitude , String note);

    Future<Map<String , dynamic>> checkOut(String longitude , String latitude , String note);
}