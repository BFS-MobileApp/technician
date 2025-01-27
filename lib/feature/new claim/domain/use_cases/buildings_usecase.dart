import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/new%20claim/data/models/building_model.dart';
import 'package:technician/feature/new%20claim/domain/repositories/new_claim_repository.dart';

class BuildingsUseCase implements UseCase<BuildingModel , NoParams>{

  final NewClaimRepository newClaimRepository;
  BuildingsUseCase({required this.newClaimRepository});

  @override
  Future<Either<Failures, BuildingModel>> call(NoParams params) => newClaimRepository.getBuildings();

}