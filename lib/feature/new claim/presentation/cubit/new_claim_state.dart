import 'package:equatable/equatable.dart';
import 'package:technician/feature/new%20claim/data/models/avaliable_time_model.dart';
import 'package:technician/feature/new%20claim/data/models/building_model.dart';
import 'package:technician/feature/new%20claim/data/models/category_model.dart';
import 'package:technician/feature/new%20claim/data/models/claim_type_model.dart';
import 'package:technician/feature/new%20claim/data/models/unit_model.dart';
import 'package:technician/feature/new%20claim/domain/entities/add_new_claim.dart';

abstract class NewClaimState extends Equatable{
  const NewClaimState();
}

class NewClaimInitial extends NewClaimState {
  @override
  List<Object> get props => [];
}

class NewClaimInitialState extends NewClaimInitial{}

class NewClaimIsLoading extends NewClaimInitial{}

class NewClaimLoaded extends NewClaimInitial{}

class BuildingsLoaded extends NewClaimInitial{

  final BuildingModel buildingModel;

  BuildingsLoaded({required this.buildingModel});

  @override
  List<Object> get props =>[buildingModel];
}

class UnitLoaded extends NewClaimInitial{

  final UnitModel unitModel;

  UnitLoaded({required this.unitModel});

  @override
  List<Object> get props =>[unitModel];
}

class CategoryLoaded extends NewClaimInitial{

  final CategoryModel categoryModel;

  CategoryLoaded({required this.categoryModel});

  @override
  List<Object> get props =>[categoryModel];
}

class ClaimsTypeLoaded extends NewClaimInitial{

  final ClaimsTypeModel claimsTypeModel;

  ClaimsTypeLoaded({required this.claimsTypeModel});

  @override
  List<Object> get props =>[claimsTypeModel];
}

class AddNewClaimsError extends NewClaimInitial{

  final String error;

  AddNewClaimsError({required this.error});

  @override
  List<Object> get props =>[error];
}

class AvailableTimesLoaded extends NewClaimInitial{

  final AvailableTimeModel availableTimeModel;

  AvailableTimesLoaded({required this.availableTimeModel});

  @override
  List<Object> get props =>[availableTimeModel];
}

class AddNewClaimLoaded extends NewClaimInitial{

  final AddNewClaim addNewClaim;

  AddNewClaimLoaded({required this.addNewClaim});

  @override
  List<Object> get props =>[addNewClaim];
}

class NewClaimError extends NewClaimInitial{
  final String msg;
  NewClaimError({required this.msg});

  @override
  List<Object> get props =>[msg];
}