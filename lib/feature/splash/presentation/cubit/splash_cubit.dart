import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/feature/splash/domain/use_cases/splash_usecase.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {

  final SplashUseCase splashUseCase;
  SplashCubit({required this.splashUseCase }) : super(SplashInitial());

  void initLoginPage() => emit(SplashInitial());


  Future<void> setSettings(BuildContext context) async{
    Either<Failures , NoParams> response = await splashUseCase(SplashParams(context: context));
    emit(response.fold(
            (failures) => SplashError(msg: failures.msg),
            (login) => SplashLoaded()));
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
