import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/feature/claim%20details/data/models/claim_details_model.dart';
import 'package:technician/feature/claim%20details/domain/use_cases/add_comment_usecase.dart';
import 'package:technician/feature/claim%20details/domain/use_cases/add_signature_usecase.dart';
import 'package:technician/feature/claim%20details/domain/use_cases/assign_claim_usecase.dart';
import 'package:technician/feature/claim%20details/domain/use_cases/change_claim_status_usecase.dart';
import 'package:technician/feature/claim%20details/domain/use_cases/change_priority_usecase.dart';
import 'package:technician/feature/claim%20details/domain/use_cases/download_signature_usecase.dart';
import 'package:technician/feature/claim%20details/domain/use_cases/start_and_end_work_usecase.dart';
import 'package:technician/feature/claims/domain/use_cases/claim_details_usecase.dart';

part 'claim_details_state.dart';

class ClaimDetailsCubit extends Cubit<ClaimDetailsState> {

  final DownloadSignatureUseCase downloadSignatureUseCase;
  final AssignClaimUseCase assignClaimUseCase;
  final ChangePriorityUseCase changePriorityUseCase;
  final ClaimDetailsUseCase claimDetailsUseCase;
  final StartAndEndWorkUseCase startAndEndWorkUseCase;
  final AddCommentUseCase addCommentUseCase;
  final AddSignatureUseCase addSignatureUseCase;
  final ChangeClaimStatusUseCase changeClaimStatusUseCase;
  ClaimDetailsCubit({required this.changeClaimStatusUseCase , required this.addSignatureUseCase , required this.addCommentUseCase , required this.downloadSignatureUseCase , required this.assignClaimUseCase , required this.changePriorityUseCase , required this.claimDetailsUseCase , required this.startAndEndWorkUseCase}) : super(ClaimDetailsInitial());

  void initLoginPage() => emit(ClaimDetailsInitial());


  Future<void> downloadSignature(GlobalKey<SfSignaturePadState> _signaturePadKey) async{
    Either<Failures , bool> response = await downloadSignatureUseCase(SignatureParams(signaturePadKey: _signaturePadKey));
    emit(response.fold(
            (failures) => AssignedClaimError(msg: failures.msg),
            (params) => AssignedClaimLoaded()));
  }

  Future<void> getClaimDetails(String referenceId) async{
    emit(ClaimDetailsIsLoading());
    Either<Failures , ClaimDetailsModel> response = await claimDetailsUseCase(ClaimsDetailsParams(referenceId: referenceId));
    emit(response.fold(
            (failures) => ClaimDetailsError(msg: failures.msg),
            (params) => ClaimDetailsLoaded(model: params)));
  }

  Future<bool> assignClaim(String claimId, String employeeId, String startDate, String endDate) async {
    Either<Failures, bool> response = await assignClaimUseCase(
        AssignClaimParams(claimId: claimId, employeeId: employeeId, startDate: startDate, endDate: endDate)
    );
    return response.fold(
          (failures) {
        emit(AssignedClaimError(msg: failures.msg));
        return false;
      },
          (isAssigned) {
        emit(AssignClaimLoaded(isClaimAssigned: isAssigned));
        return true;
      },
    );
  }

  Future<bool> addComment(String claimId, String comment , String status) async {
    Either<Failures, bool> response = await addCommentUseCase(
        AddCommentParams(claimId: claimId, comment: comment , status: status)
    );
    return response.fold(
          (failures) {
        emit(AssignedClaimError(msg: failures.msg));
        return false;
      },
          (isAssigned) {
        emit(AssignClaimLoaded(isClaimAssigned: isAssigned));
        return true;
      },
    );
  }

  Future<bool> addSignature(String claimId, File signatureFile , String comment) async {
    Either<Failures, bool> response = await addSignatureUseCase(
        AddSignatureParams(claimId: claimId, signatureFile: signatureFile , comment: comment)
    );
    return response.fold(
          (failures) {
        emit(AssignedClaimError(msg: failures.msg));
        return false;
      },
          (isAssigned) {
        emit(AssignClaimLoaded(isClaimAssigned: isAssigned));
        return true;
      },
    );
  }

  Future<bool> startAndEndWork(String claimId) async {
    Either<Failures, bool> response = await startAndEndWorkUseCase(
        StartAndEndWorkParams(claimId: claimId)
    );
    return response.fold(
          (failures) {
        emit(ClaimDetailsError(msg: failures.msg));
        return false;
      },
          (isAssigned) {
        emit(StartAndEndWorkLoaded(isButtonClicked: isAssigned));
        return true;
      },
    );
  }

  Future<bool> changePriority(int claimId, String priority) async {
    Either<Failures, bool> response = await changePriorityUseCase(
        ChangePriorityParams(claimId: claimId, priority: priority)
    );
    return response.fold(
          (failures) {
        emit(AssignedClaimError(msg: failures.msg));
        return false;
      },
          (isAssigned) {
        emit(ChangePriorityLoaded(isPriorityChanged: isAssigned));
        return true;
      },
    );
  }

  Future<bool> changeClaimStatus(String claimId, String status) async {
    Either<Failures, bool> response = await changeClaimStatusUseCase(
        ChangeClaimStatusParams(claimId: claimId, status: status)
    );
    return response.fold(
          (failures) {
        emit(AssignedClaimError(msg: failures.msg));
        return false;
      },
          (isAssigned) {
        emit(ChangePriorityLoaded(isPriorityChanged: isAssigned));
        return true;
      },
    );
  }



  String mapFailureToMsg(Failures failures){
    switch (failures.runtimeType){
      case const (ServerFailure):
        return AppStrings.serverError;
      case const (CashFailure):
        return AppStrings.cacheError;
      default:
        return AppStrings.unexpectedError;
    }
  }
}
