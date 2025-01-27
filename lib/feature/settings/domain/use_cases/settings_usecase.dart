import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/settings/domain/entities/settings_user_info.dart';
import 'package:technician/feature/settings/domain/repositories/setting_repository.dart';

class SettingsUseCase implements UseCase<SettingsUserInfo , NoParams>{

  final SettingRepository settingRepository;
  SettingsUseCase({required this.settingRepository});

  @override
  Future<Either<Failures, SettingsUserInfo>> call(NoParams params) => settingRepository.getUserInfo();

}