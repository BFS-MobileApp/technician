import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../error/failures.dart';

abstract class UseCase<Type, Params> {

  Future<Either<Failures , Type>> call(Params params);
}


class NoParams extends Equatable{

  @override
  List<Object?> get props => [];
}

class SplashParams extends Equatable{

  final BuildContext context;

  const SplashParams({required this.context});
  @override
  List<Object?> get props => [context];
}

class LoginParams extends Equatable{

  final String email;
  final String password;
  final bool rememberMe;

  const LoginParams({required this.email,required this.password , required this.rememberMe});
  @override
  List<Object?> get props => [email , password , rememberMe];
}

class SignatureParams extends Equatable{

  GlobalKey<SfSignaturePadState> signaturePadKey;

  SignatureParams({required this.signaturePadKey});
  @override
  List<Object?> get props => [signaturePadKey];
}

class ClaimsParams extends Equatable{

  Map<String, dynamic> data;

  ClaimsParams({required this.data});

  @override
  List<Object?> get props => [data];
}

class ClaimsDetailsParams {
  final String referenceId;
  final int page;
  final String? search;

  ClaimsDetailsParams({required this.referenceId, required this.page, this.search});
}

class AddMaterialParams {
  final int claimId;
  final List<ProductItem> products;

  AddMaterialParams({required this.claimId, required this.products});

  Map<String, dynamic> toJson() {
    return {
      "claim_id": claimId,
      "products": products.map((e) => e.toJson()).toList(),
    };
  }
}

class ProductItem {
  final int id;
  final int qty;

  ProductItem({required this.id, required this.qty});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "qty": qty,
    };
  }
}

class EditMaterialParams {
  final String id;
  final int quantity;

  EditMaterialParams({required this.id, required this.quantity});
}


class UnitParams extends Equatable{

  String buildingId;

  UnitParams({required this.buildingId});

  @override
  List<Object?> get props => [buildingId];
}


class CategoryParams extends Equatable{

  String unitId;

  CategoryParams({required this.unitId});

  @override
  List<Object?> get props => [unitId];
}

class ClaimsTypeParams extends Equatable{

  String subCategoryId;

  ClaimsTypeParams({required this.subCategoryId});

  @override
  List<Object?> get props => [subCategoryId];
}
class DeleteFileParams extends Equatable{

  String claimId;
  String fileId;

  DeleteFileParams({required this.claimId,required this.fileId});

  @override
  List<Object?> get props => [fileId,claimId];
}

class AvailableTimesParams extends Equatable{

  String companyId;

  AvailableTimesParams({required this.companyId});

  @override
  List<Object?> get props => [companyId];
}

class TechniciansParams extends Equatable{

  String claimId;

  TechniciansParams({required this.claimId});

  @override
  List<Object?> get props => [claimId];
}

class AddNewClaimParams extends Equatable{

  String unitId;
  String categoryId;
  String subCategoryId;
  String claimTypeId;
  String description;
  String availableTime;
  String availableDate;
  List<File> file;

  AddNewClaimParams({required this.unitId, required this.categoryId,required this.subCategoryId, required this.claimTypeId, required this.description, required this.availableTime, required this.availableDate,required this.file});

  @override
  List<Object?> get props => [unitId , categoryId , subCategoryId , claimTypeId , description , availableTime , availableDate];

}
class UpdateClaimParams extends Equatable{

  String categoryId;
  String subCategoryId;
  String claimTypeId;
  String description;
  String availableTime;
  String availableDate;
  // List<File> file;
  String claimId;
  String priority;

  UpdateClaimParams({required this.claimId, required this.priority,required this.categoryId,required this.subCategoryId, required this.claimTypeId, required this.description, required this.availableTime, required this.availableDate,
    // required this.file
  });

  @override
  List<Object?> get props => [categoryId , subCategoryId , claimTypeId , description , availableTime , availableDate];

}

class AssignClaimParams extends Equatable{

  String claimId;
  String employeeId;
  String startDate;
  String endDate;

  AssignClaimParams({required this.claimId, required this.employeeId,required this.startDate, required this.endDate});

  @override
  List<Object?> get props => [claimId , employeeId , startDate , endDate];

}

class AddCommentParams extends Equatable{

  String claimId;
  String comment;
  String status;

  AddCommentParams({required this.claimId, required this.comment , required this.status});

  @override
  List<Object?> get props => [claimId , comment];

}

class ForgotPasswordParams extends Equatable{

  String email;

  ForgotPasswordParams({required this.email});

  @override
  List<Object?> get props => [email];

}

class ResetPasswordParams extends Equatable{

  String token;
  String email;
  String password;
  String confirmPassword;

  ResetPasswordParams({required this.token , required this.email , required this.password , required this.confirmPassword});

  @override
  List<Object?> get props => [email];

}

class ChangeClaimStatusParams extends Equatable{

  String claimId;
  String status;

  ChangeClaimStatusParams({required this.claimId, required this.status});

  @override
  List<Object?> get props => [claimId , status];

}

class AddSignatureParams extends Equatable{

  String claimId;
  File signatureFile;
  String comment;

  AddSignatureParams({required this.claimId, required this.signatureFile , required this.comment});

  @override
  List<Object?> get props => [claimId , signatureFile];

}

class ChangePriorityParams extends Equatable{

  int claimId;
  String priority;

  ChangePriorityParams({required this.claimId, required this.priority});

  @override
  List<Object?> get props => [claimId , priority];
}

class ChangePasswordParams extends Equatable{

  String oldPassword;
  String password;
  String confirmPassword;

  ChangePasswordParams({required this.oldPassword, required this.password , required this.confirmPassword});

  @override
  List<Object?> get props => [oldPassword , password , confirmPassword];
}

class UpdateProfileParams extends Equatable{

  String name;
  String mobile;
  File imageFile;
  int emailNotification;

  UpdateProfileParams({required this.name, required this.mobile , required this.imageFile , required this.emailNotification});

  @override
  List<Object?> get props => [name , mobile , imageFile , emailNotification];
}

class StartAndEndWorkParams extends Equatable{

  String claimId;

  StartAndEndWorkParams({required this.claimId});

  @override
  List<Object?> get props => [claimId];
}

class AddAttendanceParams extends Equatable{

  final String longitude;
  final String latitude;
  final String note;

  const AddAttendanceParams({required this.longitude , required this.latitude , required this.note});

  @override
  List<Object?> get props => [longitude , latitude , note];
}