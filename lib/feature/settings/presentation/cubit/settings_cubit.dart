import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/feature/settings/domain/entities/settings_user_info.dart';
import 'package:technician/feature/settings/domain/use_cases/settings_change_lang_usecase.dart';
import 'package:technician/feature/settings/domain/use_cases/settings_usecase.dart';
import 'package:technician/feature/settings/presentation/cubit/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState>{

  final SettingsUseCase settingsUseCase;
  final SettingsChangeLangUseCase settingsChangeLangUseCase;
  SettingsCubit({required this.settingsUseCase  , required this.settingsChangeLangUseCase}) : super(SettingsInitial());

  void initLoginPage() => emit(SettingsInitial());

  Future<void> getUserInfo() async{
    emit(SettingsIsLoading());
    Either<Failures , SettingsUserInfo> response = await settingsUseCase(NoParams());
    emit(response.fold(
            (failures) => SettingsError(msg: failures.msg),
            (info) => SettingsLoaded(userInfo: info)));
  }

  Future<void> changeLang() async{
    emit(SettingsIsLoading());
    Either<Failures , NoParams> response = await settingsChangeLangUseCase(NoParams());
    emit(response.fold(
            (failures) => SettingsError(msg: failures.msg),
            (_) => SettingsLoadedWithoutData()));
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