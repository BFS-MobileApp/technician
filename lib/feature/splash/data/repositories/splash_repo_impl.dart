import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:technician/core/error/exceptions.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/splash/data/data_sources/splash_local_data_source.dart';
import 'package:technician/feature/splash/domain/repositories/splash_repo.dart';

class SplashRepositoryImplementation extends SplashRepository{

  final SplashLocalDataSource splashLocalDataSource;


  SplashRepositoryImplementation({required this.splashLocalDataSource});

  @override
  Future<Either<Failures , NoParams>> setSettings(BuildContext context) async{
    try{

      splashLocalDataSource.initializeSettings(context);
      return Right(NoParams());
    } on ServerException{
      return Left(ServerFailure(msg: 'error'.tr));
    }
  }
}