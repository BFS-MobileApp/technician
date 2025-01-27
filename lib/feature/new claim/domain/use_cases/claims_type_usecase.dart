import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/new%20claim/data/models/claim_type_model.dart';
import '../repositories/new_claim_repository.dart';

class ClaimsTypeUseCase implements UseCase<ClaimsTypeModel , ClaimsTypeParams>{

  final NewClaimRepository newClaimRepository;
  ClaimsTypeUseCase({required this.newClaimRepository});

  @override
  Future<Either<Failures, ClaimsTypeModel>> call(ClaimsTypeParams params) => newClaimRepository.getClaimsType(params.subCategoryId);

}