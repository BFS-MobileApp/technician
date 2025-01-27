import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/settings/domain/entities/settings_user_info.dart';

abstract class SettingRepository {

  Future<Either<Failures , SettingsUserInfo>>  getUserInfo();

  Future<Either<Failures , NoParams>>  changeLanguage();

}