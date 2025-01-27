import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/add%20attendance/domain/repositories/add_attendance_repository.dart';

class CheckInUseCase implements UseCase<bool , AddAttendanceParams>{

  final AddAttendanceRepository addAttendanceRepository;
  CheckInUseCase({required this.addAttendanceRepository});

  @override
  Future<Either<Failures, bool>> call(AddAttendanceParams params) => addAttendanceRepository.checkIn(params.longitude, params.latitude, params.note);

}