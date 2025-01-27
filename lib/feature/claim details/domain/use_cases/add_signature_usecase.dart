import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/claim%20details/domain/repositories/claims_details_repository.dart';

class AddSignatureUseCase implements UseCase<bool , AddSignatureParams>{

  final ClaimsDetailsRepository claimsDetailsRepository;
  AddSignatureUseCase({required this.claimsDetailsRepository});

  @override
  Future<Either<Failures, bool>> call(AddSignatureParams params) => claimsDetailsRepository.addSignature(params.claimId , params.signatureFile , params.comment);

}