import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/claim%20details/domain/repositories/claims_details_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../widgets/message_widget.dart';

class AddCommentUseCase implements UseCase<bool , AddCommentParams>{

  final ClaimsDetailsRepository claimsDetailsRepository;
  AddCommentUseCase({required this.claimsDetailsRepository});

  @override
  Future<Either<Failures, bool>> call(AddCommentParams params) => claimsDetailsRepository.addComment(params.claimId , params.comment , params.status);

}