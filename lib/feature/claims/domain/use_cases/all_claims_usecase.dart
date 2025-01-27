import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/claims/data/models/claims_model.dart';
import 'package:technician/feature/claims/domain/repositories/claims_repository.dart';

class AllClaimsUseCase implements UseCase<ClaimsModel , ClaimsParams> {

  final ClaimsRepository claimsRepository;

  AllClaimsUseCase({required this.claimsRepository});

  @override
  Future<Either<Failures, ClaimsModel>> call(ClaimsParams params) =>
      claimsRepository.getAllClaims(params.data);
}