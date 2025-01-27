import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:technician/core/error/exceptions.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/settings/data/data_sources/settings_local_data_source.dart';
import 'package:technician/feature/settings/domain/entities/settings_user_info.dart';
import 'package:technician/feature/settings/domain/repositories/setting_repository.dart';

class SettingsRepositoryImpl extends SettingRepository{

  final SettingsLocalDataSource settingsLocalDataSource;


  SettingsRepositoryImpl({required this.settingsLocalDataSource});

  @override
  Future<Either<Failures, SettingsUserInfo>> getUserInfo() async{
    try {
      final data = await settingsLocalDataSource.getUserInfo();
      return Right(data);
    } on FetchDataException {
      return Left(ServerFailure(msg: 'error'.tr));
    }
  }

  @override
  Future<Either<Failures, NoParams>> changeLanguage() async{
    try {
      final data = await settingsLocalDataSource.changeLanguage();
      return Right(NoParams());
    } on FetchDataException {
      return Left(ServerFailure(msg: 'error'.tr));
    }
  }
}