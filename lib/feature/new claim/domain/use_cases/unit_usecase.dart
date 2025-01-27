import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/new%20claim/data/models/unit_model.dart';
import 'package:technician/feature/new%20claim/domain/repositories/new_claim_repository.dart';

class UnitUseCase implements UseCase<UnitModel , UnitParams>{

  final NewClaimRepository newClaimRepository;
  UnitUseCase({required this.newClaimRepository});

  @override
  Future<Either<Failures, UnitModel>> call(UnitParams params) => newClaimRepository.getUnits(params.buildingId);

}