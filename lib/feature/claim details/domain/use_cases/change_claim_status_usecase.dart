import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/claim%20details/domain/repositories/claims_details_repository.dart';

class ChangeClaimStatusUseCase implements UseCase<bool , ChangeClaimStatusParams>{

  final ClaimsDetailsRepository claimsDetailsRepository;
  ChangeClaimStatusUseCase({required this.claimsDetailsRepository});

  @override
  Future<Either<Failures, bool>> call(ChangeClaimStatusParams params) => claimsDetailsRepository.changeClaimStatus(params.claimId , params.status);

}