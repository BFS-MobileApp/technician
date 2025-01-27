import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/add%20attendance/domain/repositories/add_attendance_repository.dart';

class CheckOutUseCase implements UseCase<bool , AddAttendanceParams>{

  final AddAttendanceRepository addAttendanceRepository;
  CheckOutUseCase({required this.addAttendanceRepository});

  @override
  Future<Either<Failures, bool>> call(AddAttendanceParams params) => addAttendanceRepository.checkOut(params.longitude, params.latitude, params.note);

}