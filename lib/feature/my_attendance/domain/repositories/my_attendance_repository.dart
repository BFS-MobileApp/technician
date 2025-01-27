import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/feature/my_attendance/data/models/my_attendance_model.dart';

abstract class MyAttendanceRepository {

  Future<Either<Failures , MyAttendanceModel>> getAttendance();

}