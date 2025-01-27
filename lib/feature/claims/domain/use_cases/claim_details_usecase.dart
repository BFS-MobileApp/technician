import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/claim%20details/data/models/claim_details_model.dart';
import 'package:technician/feature/claim%20details/domain/repositories/claims_details_repository.dart';

class ClaimDetailsUseCase implements UseCase<ClaimDetailsModel , ClaimsDetailsParams> {

  final ClaimsDetailsRepository claimsDetailsRepository;

  ClaimDetailsUseCase({required this.claimsDetailsRepository});

  @override
  Future<Either<Failures, ClaimDetailsModel>> call(ClaimsDetailsParams params) =>
      claimsDetailsRepository.getClaimDetails(params.referenceId);
}