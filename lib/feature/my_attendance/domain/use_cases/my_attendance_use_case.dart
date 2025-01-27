import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/my_attendance/data/models/my_attendance_model.dart';
import 'package:technician/feature/my_attendance/domain/repositories/my_attendance_repository.dart';

class MyAttendanceUseCase implements UseCase<MyAttendanceModel , NoParams>{

  final MyAttendanceRepository myAttendanceRepository;
  MyAttendanceUseCase({required this.myAttendanceRepository});

  @override
  Future<Either<Failures , MyAttendanceModel>> call(NoParams params) => myAttendanceRepository.getAttendance();

}