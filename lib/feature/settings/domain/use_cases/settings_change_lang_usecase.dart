import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/settings/domain/repositories/setting_repository.dart';

class SettingsChangeLangUseCase implements UseCase<NoParams , NoParams>{

  final SettingRepository settingRepository;
  SettingsChangeLangUseCase({required this.settingRepository});

  @override
  Future<Either<Failures, NoParams>> call(NoParams params) => settingRepository.changeLanguage();

}