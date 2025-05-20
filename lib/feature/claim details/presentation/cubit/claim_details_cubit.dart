import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/feature/claim%20details/data/models/claim_details_model.dart' hide Data;
import 'package:technician/feature/claim%20details/data/models/material_model.dart';
import 'package:technician/feature/claim%20details/domain/use_cases/add_comment_usecase.dart';
import 'package:technician/feature/claim%20details/domain/use_cases/add_signature_usecase.dart';
import 'package:technician/feature/claim%20details/domain/use_cases/assign_claim_usecase.dart';
import 'package:technician/feature/claim%20details/domain/use_cases/change_claim_status_usecase.dart';
import 'package:technician/feature/claim%20details/domain/use_cases/change_priority_usecase.dart';
import 'package:technician/feature/claim%20details/domain/use_cases/download_signature_usecase.dart';
import 'package:technician/feature/claim%20details/domain/use_cases/material_usecase.dart';
import 'package:technician/feature/claim%20details/domain/use_cases/start_and_end_work_usecase.dart';
import 'package:technician/feature/claims/domain/use_cases/claim_details_usecase.dart';

import '../../domain/use_cases/upload_file_usecase.dart';

part 'claim_details_state.dart';

class ClaimDetailsCubit extends Cubit<ClaimDetailsState> {

  final DownloadSignatureUseCase downloadSignatureUseCase;
  final AssignClaimUseCase assignClaimUseCase;
  final ChangePriorityUseCase changePriorityUseCase;
  final ClaimDetailsUseCase claimDetailsUseCase;
  final MaterialUseCase materialUseCase;
  final DeleteMaterialUseCase deleteMaterialUseCase;
  final DeleteClaimUseCase deleteClaimUseCase;
  final EditMaterialQuantityUseCase editMaterialQuantityUseCase;
  final AddMaterialUseCase addMaterialUseCase;
  final StartAndEndWorkUseCase startAndEndWorkUseCase;
  final AddCommentUseCase addCommentUseCase;
  final UploadFileUseCase uploadFileUseCase;
  final AddSignatureUseCase addSignatureUseCase;
  final ChangeClaimStatusUseCase changeClaimStatusUseCase;
  final UploadCommentFileUseCase uploadCommentFileUseCase;

  int currentPage = 1;
  bool isLoadingMore = false;
  bool hasMore = true;

  ClaimDetailsCubit( {required this.changeClaimStatusUseCase ,required this.uploadFileUseCase,required this.deleteClaimUseCase,required this.addMaterialUseCase,required this.editMaterialQuantityUseCase,required this.deleteMaterialUseCase,required this.materialUseCase, required this.addSignatureUseCase , required this.addCommentUseCase , required this.downloadSignatureUseCase , required this.assignClaimUseCase , required this.changePriorityUseCase , required this.claimDetailsUseCase , required this.startAndEndWorkUseCase, required this.uploadCommentFileUseCase}) : super(ClaimDetailsInitial());

  void initLoginPage() => emit(ClaimDetailsInitial());


  Future<void> downloadSignature(GlobalKey<SfSignaturePadState> _signaturePadKey) async{
    Either<Failures , bool> response = await downloadSignatureUseCase(SignatureParams(signaturePadKey: _signaturePadKey));
    emit(response.fold(
            (failures) => AssignedClaimError(msg: failures.msg),
            (params) => AssignedClaimLoaded()));
  }

  Future<void> getClaimDetails(String referenceId) async{
    emit(ClaimDetailsIsLoading());
    Either<Failures , ClaimDetailsModel> response = await claimDetailsUseCase(ClaimsDetailsParams(referenceId: referenceId, page: 0));
    emit(response.fold(
            (failures) => ClaimDetailsError(msg: failures.msg),
            (params) => ClaimDetailsLoaded(model: params)));
  }
  Future<void> deleteClaim(String claimId) async {
    emit(ClaimDetailsIsLoading());

    Either<Failures, bool> response = await deleteClaimUseCase(claimId);

    emit(response.fold(
          (failure) => ClaimDetailsError(msg: failure.msg),
          (success) {
        if (success) {
          print("🔥 Emitting ClaimDeleted");
          return ClaimDeleted();
        } else {
          return ClaimDetailsError(msg: "Failed to delete Claim.");
        }
      },
    ));
  }

  Future<void> getMaterial(String referenceId, {int page = 1, String? search}) async {
    emit(ClaimDetailsIsLoading());

    Either<Failures, MaterialResponse> response = await materialUseCase(
      ClaimsDetailsParams(referenceId: referenceId, page: page, search: search),
    );

    emit(response.fold(
          (failure) => ClaimDetailsError(msg: failure.msg),
          (materialResponse) {
        currentPage = page;
        hasMore = materialResponse.data.length >= 10; // Assuming 10 per page
        return MaterialLoaded(model: materialResponse);
      },
    ));
  }

  Future<void> deleteMaterial(String materialId) async {
    emit(ClaimDetailsIsLoading());

    Either<Failures, bool> response = await deleteMaterialUseCase(materialId);

    emit(response.fold(
          (failure) => ClaimDetailsError(msg: failure.msg),
          (success) {
        if (success) {
          // You might want to refresh materials after delete
          // or update your local list if you have one
          return MaterialDeleted(); // You should create this state
        } else {
          return ClaimDetailsError(msg: "Failed to delete material.");
        }
      },
    ));
  }

  Future<void> addMaterial(int claimId, List<ProductItem> products) async {
    emit(ClaimDetailsIsLoading());

    Either<Failures, bool> response = await addMaterialUseCase(
      AddMaterialParams(claimId: claimId, products: products),
    );

    emit(response.fold(
          (failure) => ClaimDetailsError(msg: failure.msg),
          (success) {
        return MaterialAdded(); // Create this state
      },
    ));
  }

  Future<void> editMaterialQuantity(String materialId, int quantity) async {
    emit(ClaimDetailsIsLoading());

    Either<Failures, bool> response = await editMaterialQuantityUseCase(
      EditMaterialParams(id: materialId, quantity: quantity),
    );

    emit(response.fold(
          (failure) => ClaimDetailsError(msg: failure.msg),
          (success) {
        return MaterialEdited();
      },
    ));
  }



  Future<void> loadMoreMaterials(String referenceId,String? currentSearch) async {
    if (isLoadingMore || !hasMore) return;

    isLoadingMore = true;
    final nextPage = currentPage + 1;

    Either<Failures, MaterialResponse> response = await materialUseCase(
      ClaimsDetailsParams(
        referenceId: referenceId,
        page: nextPage,
        search: currentSearch, // 🔥 PASS the current search text here!
      ),
    );

    response.fold(
          (failure) => null,
          (materialResponse) {
        if (state is MaterialLoaded) {
          final oldMaterials = (state as MaterialLoaded).model.data;
          final newMaterials = materialResponse.data;

          final updatedMaterials = List<Data>.from(oldMaterials)..addAll(newMaterials);

          emit(MaterialLoaded(
            model: MaterialResponse(
              data: updatedMaterials,
            ),
          ));

          currentPage = nextPage;
          hasMore = newMaterials.length >= 10;
        }
      },
    );

    isLoadingMore = false;
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

  Future<void> uploadCommentFile(BuildContext context, String claimId, String commentId, List<File> file, String status,String referenceId) async {
    emit(UploadingCommentFile());

    Either<Failures, bool> response = await uploadCommentFileUseCase(
        UploadCommentFileParams(claimId: claimId, commentId: commentId, file: file, status: status));

    response.fold(
          (failure) {
        emit(UploadCommentFileError(msg: failure.msg));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to upload file: ${failure.msg}"), backgroundColor: Colors.red),
        );
      },
          (success) {
        emit(UploadCommentFileSuccess());

        // ✅ Show success snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("File uploaded successfully!"), backgroundColor: Colors.green),
        );
        context.read<ClaimDetailsCubit>().getClaimDetails(referenceId);
      },
    );
  }

  Future<bool> uploadFile(BuildContext context, String claimId, List<File> files) async {
    try {
      emit(UploadingCommentFile());
      
      Either<Failures, bool> response = await uploadFileUseCase(UploadFileParams(claimId: claimId, files: files));
      
     return response.fold(
            (failure) {
          emit(UploadCommentFileError(msg: failure.msg));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to upload file: ${failure.msg}"), backgroundColor: Colors.red),
          );
          return false;
        },
            (success) {
          emit(UploadCommentFileSuccess());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("File uploaded successfully!"), backgroundColor: Colors.green),
      
          );
          // context.read<ClaimDetailsCubit>().getClaimDetails(claimId);
          return true;
        },
      );
    } catch (e) {
      emit(UploadCommentFileError(msg: e.toString()));
      return false;
    }
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
