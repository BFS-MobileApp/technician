import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/splash/domain/repositories/splash_repo.dart';

class SplashUseCase implements UseCase<NoParams , SplashParams>{

  final SplashRepository splashRepository;
  SplashUseCase({required this.splashRepository});

  @override
  Future<Either<Failures, NoParams>> call(SplashParams params) => splashRepository.setSettings(params.context);

}