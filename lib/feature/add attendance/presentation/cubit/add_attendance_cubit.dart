import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/feature/add%20attendance/domain/use_cases/check_in_use_case.dart';
import 'package:technician/feature/add%20attendance/domain/use_cases/check_out_use_case.dart';
import 'package:technician/feature/add%20attendance/presentation/cubit/add_attendance_state.dart';

class AddAttendanceCubit extends Cubit<AddAttendanceState>{

  final CheckInUseCase checkInUseCase;
  final CheckOutUseCase checkOutUseCase;

  AddAttendanceCubit({required this.checkInUseCase , required this.checkOutUseCase}) : super(AddAttendanceInitial());

  void initLoginPage() => emit(AddAttendanceInitial());

  Future<bool> checkIn(String longitude , String latitude , String note) async {
    Either<Failures, bool> response = await checkInUseCase(
        AddAttendanceParams(longitude: longitude, latitude: latitude, note: note)
    );
    return response.fold(
          (failures) {
        emit(AddAttendanceError(error: failures.msg));
        return false;
      },
          (result) {
        emit(AddAttendanceLoaded(result: result));
        return true;
      },
    );
  }

  Future<bool> checkOut(String longitude , String latitude , String note) async {
    Either<Failures, bool> response = await checkOutUseCase(
        AddAttendanceParams(longitude: longitude, latitude: latitude, note: note)
    );
    return response.fold(
          (failures) {
        emit(AddAttendanceError(error: failures.msg));
        return false;
      },
          (result) {
        emit(AddAttendanceLoaded(result: result));
        return true;
      },
    );
  }

  String mapFailureToMsg(Failures failures){
    switch (failures.runtimeType){
      case const (ServerFailure):
        return AppStrings.serverError;
      case const (CashFailure):
        return AppStrings.cacheError;
      default:
        return AppStrings.unexpectedError;
    }
  }

}