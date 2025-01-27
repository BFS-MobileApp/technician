import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/home/domain/entities/profile.dart';
import 'package:technician/feature/home/domain/repositories/home_repository.dart';

class HomeUseCase implements UseCase<UserInfo , NoParams>{

  final HomeRepository homeRepository;
  HomeUseCase({required this.homeRepository});

  @override
  Future<Either<Failures, UserInfo>> call(NoParams params) => homeRepository.getUserInfo();

}