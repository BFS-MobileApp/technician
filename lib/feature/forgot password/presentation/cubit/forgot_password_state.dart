import 'package:equatable/equatable.dart';
import 'package:technician/feature/edit%20profile/domain/entities/edit_profile_user_info.dart';

abstract class ForgotPasswordState extends Equatable{
  const ForgotPasswordState();
}

class ForgotPasswordInitial extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

class ForgotPasswordInitialState extends ForgotPasswordInitial{}

class ForgotPasswordIsLoading extends ForgotPasswordInitial{}

class ForgotPasswordLoaded extends ForgotPasswordInitial{}


class ForgotPasswordError extends ForgotPasswordInitial{
  final String msg;
  ForgotPasswordError({required this.msg});

  @override
  List<Object> get props =>[msg];
}