import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technician/config/PrefHelper/prefs.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/feature/my_attendance/data/models/my_attendance_model.dart';
import 'package:technician/feature/my_attendance/domain/use_cases/my_attendance_use_case.dart';
import 'package:technician/feature/my_attendance/presentation/cubit/my_attendance_state.dart';

class MyAttendanceCubit extends Cubit<MyAttendanceState>{

  final MyAttendanceUseCase myAttendanceUseCase;
  MyAttendanceCubit({required this.myAttendanceUseCase}) : super(MyAttendanceInitial());

  void initLoginPage() => emit(MyAttendanceInitial());

  Future<void> getMyAttendance() async{
    emit(MyAttendanceIsLoading());
    Either<Failures , MyAttendanceModel> response = await myAttendanceUseCase(NoParams());
    emit(response.fold(
            (failures) => MyAttendanceError(msg: failures.msg),
            (info) => MyAttendanceLoaded(model: info)));
  }

  Future<void> resetMyAttendance() async{
    emit(MyAttendanceIsLoading());
    String jsonString = Prefs.getString('AttList');
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    MyAttendanceModel model = MyAttendanceModel.fromJson(jsonMap);
    emit(MyAttendanceLoaded2(model: model));
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