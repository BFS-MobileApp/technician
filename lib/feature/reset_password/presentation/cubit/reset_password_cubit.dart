import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/feature/reset_password/domain/use_cases/reset_password_use_case.dart';
import 'package:technician/feature/reset_password/presentation/cubit/reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState>{

  final ResetPasswordUseCase resetPasswordUseCase;
  ResetPasswordCubit({required this.resetPasswordUseCase}) : super(ResetPasswordInitial());

  void initLoginPage() => emit(ResetPasswordInitial());

  Future<bool> resetPassword(String token , String email , String password , String confirmPassword) async{
    Either<Failures , bool> response = await resetPasswordUseCase(ResetPasswordParams(token: token, email: email, password: password, confirmPassword: confirmPassword));
    return response.fold(
          (failures) {
        emit(ResetPasswordError(msg: failures.msg));
        return false;
      },
          (result) {
        emit(ResetPasswordLoaded(result: result));
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