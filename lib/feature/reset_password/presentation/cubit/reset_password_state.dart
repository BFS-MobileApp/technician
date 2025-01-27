import 'package:equatable/equatable.dart';

abstract class ResetPasswordState extends Equatable{
  const ResetPasswordState();
}

class ResetPasswordInitial extends ResetPasswordState {
  @override
  List<Object> get props => [];
}

class ResetPasswordInitialState extends ResetPasswordInitial{}

class ResetPasswordIsLoading extends ResetPasswordInitial{}

class ResetPasswordLoaded extends ResetPasswordInitial{

  final bool result;
  ResetPasswordLoaded({required this.result});
  @override
  List<Object> get props =>[result];
}


class ResetPasswordError extends ResetPasswordInitial{
  final String msg;
  ResetPasswordError({required this.msg});

  @override
  List<Object> get props =>[msg];
}