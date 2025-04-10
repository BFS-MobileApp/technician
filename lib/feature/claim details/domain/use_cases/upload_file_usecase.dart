import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/feature/claim%20details/domain/repositories/claims_details_repository.dart';

import '../../../../core/usecase/use_case.dart';

class UploadCommentFileUseCase implements UseCase<bool, UploadCommentFileParams> {
  final ClaimsDetailsRepository repository;

  UploadCommentFileUseCase(this.repository);

  @override
  Future<Either<Failures, bool>> call(UploadCommentFileParams params) {
    return repository.uploadCommentFile(params.claimId, params.commentId, params.file, params.status);
  }
}

class UploadCommentFileParams {
  final String claimId;
  final String commentId;
  final List<File> file;
  final String status;

  UploadCommentFileParams({required this.claimId, required this.commentId, required this.file, required this.status});
}
