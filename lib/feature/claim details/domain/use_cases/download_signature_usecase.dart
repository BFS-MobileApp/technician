import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/claim%20details/domain/repositories/claims_details_repository.dart';

class DownloadSignatureUseCase implements UseCase<bool , SignatureParams>{

  final ClaimsDetailsRepository assignedClaimsRepository;
  DownloadSignatureUseCase({required this.assignedClaimsRepository});

  @override
  Future<Either<Failures, bool>> call(SignatureParams params) => assignedClaimsRepository.downloadSignature(params.signaturePadKey);

}