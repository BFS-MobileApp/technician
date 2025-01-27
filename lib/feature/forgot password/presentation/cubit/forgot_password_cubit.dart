import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/feature/forgot%20password/domain/use_cases/forgot_password_use_case.dart';
import 'package:technician/feature/forgot%20password/presentation/cubit/forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState>{

  final ForgotPasswordUseCase forgotPasswordUseCase;
  ForgotPasswordCubit({required this.forgotPasswordUseCase}) : super(ForgotPasswordInitial());

  void initLoginPage() => emit(ForgotPasswordInitial());

  Future<void> forgotPassword(String email) async{
    Either<Failures , bool> response = await forgotPasswordUseCase(ForgotPasswordParams(email: email));
    emit(response.fold(
            (failures) => ForgotPasswordError(msg: failures.msg),
            (info) => ForgotPasswordLoaded()));
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