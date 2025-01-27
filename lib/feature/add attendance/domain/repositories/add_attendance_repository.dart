import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';

abstract class AddAttendanceRepository{

  Future<Either<Failures , bool>> checkIn(String longitude, String latitude, String note);

  Future<Either<Failures , bool>> checkOut(String longitude, String latitude, String note);
}