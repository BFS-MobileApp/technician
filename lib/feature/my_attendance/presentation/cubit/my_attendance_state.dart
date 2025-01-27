import 'package:equatable/equatable.dart';
import 'package:technician/feature/my_attendance/data/models/my_attendance_model.dart';

abstract class MyAttendanceState extends Equatable{
  const MyAttendanceState();
}

class MyAttendanceInitial extends MyAttendanceState {
  @override
  List<Object> get props => [];
}

class MyAttendanceInitialState extends MyAttendanceInitial{}

class MyAttendanceIsLoading extends MyAttendanceInitial{}

class MyAttendanceLoaded extends MyAttendanceInitial {
  final MyAttendanceModel model;

  MyAttendanceLoaded({required this.model});

  /// CopyWith method
  MyAttendanceLoaded copyWith({MyAttendanceModel? model}) {
    return MyAttendanceLoaded(
      model: model ?? this.model,
    );
  }

  @override
  List<Object> get props => [model];
}

class MyAttendanceLoaded2 extends MyAttendanceInitial {
  final MyAttendanceModel model;

  MyAttendanceLoaded2({required this.model});

  @override
  List<Object> get props => [model];
}

class MyAttendanceError extends MyAttendanceInitial{
  final String msg;
  MyAttendanceError({required this.msg});

  @override
  List<Object> get props =>[msg];
}