import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/home/data/models/home_model.dart';
import 'package:technician/feature/home/domain/repositories/home_repository.dart';

class ClaimsUseCase implements UseCase<HomeModel , NoParams>{

  final HomeRepository homeRepository;
  ClaimsUseCase({required this.homeRepository});

  @override
  Future<Either<Failures, HomeModel>> call(NoParams params) => homeRepository.getClaimsCount();

}