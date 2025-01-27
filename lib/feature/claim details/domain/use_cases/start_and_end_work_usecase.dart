import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/claim%20details/domain/repositories/claims_details_repository.dart';

class StartAndEndWorkUseCase implements UseCase<bool , StartAndEndWorkParams>{

  final ClaimsDetailsRepository claimsDetailsRepository;
  StartAndEndWorkUseCase({required this.claimsDetailsRepository});

  @override
  Future<Either<Failures, bool>> call(StartAndEndWorkParams params) => claimsDetailsRepository.startAndEndWork(params.claimId);

}