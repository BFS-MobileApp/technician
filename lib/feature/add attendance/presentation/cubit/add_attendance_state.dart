import 'package:equatable/equatable.dart';

abstract class AddAttendanceState extends Equatable{
  const AddAttendanceState();
}

class AddAttendanceInitial extends AddAttendanceState {
  @override
  List<Object> get props => [];
}

class AddAttendanceInitialState extends AddAttendanceInitial{}

class AddAttendanceIsLoading extends AddAttendanceInitial{}

class AddAttendanceLoaded extends AddAttendanceInitial{

  final bool result;

  AddAttendanceLoaded({required this.result});

  @override
  List<Object> get props =>[result];

}

class AddAttendanceError extends AddAttendanceInitial{

  final String error;

  AddAttendanceError({required this.error});

  @override
  List<Object> get props =>[error];
}
