part of 'claim_details_cubit.dart';

abstract class ClaimDetailsState extends Equatable {
  const ClaimDetailsState();
}

class ClaimDetailsInitial extends ClaimDetailsState {
  @override
  List<Object> get props => [];
}


class AssignedClaimInitialState extends ClaimDetailsInitial{}

class ClaimDetailsIsLoading extends ClaimDetailsInitial{}

class ClaimDetailsLoaded extends ClaimDetailsInitial{

  final ClaimDetailsModel model;

  ClaimDetailsLoaded({required this.model});
  @override
  List<Object> get props =>[model];
}

class ClaimDetailsError extends ClaimDetailsInitial{
  final String msg;
  ClaimDetailsError({required this.msg});

  @override
  List<Object> get props =>[msg];
}

class AssignedClaimIsLoading extends ClaimDetailsInitial{}

class AssignedClaimLoaded extends ClaimDetailsInitial{}

class AssignClaimLoaded extends ClaimDetailsInitial{
  final bool isClaimAssigned;

  AssignClaimLoaded({required this.isClaimAssigned});
  @override
  List<Object> get props =>[isClaimAssigned];
}

class StartAndEndWorkLoaded extends ClaimDetailsInitial{
  final bool isButtonClicked;

  StartAndEndWorkLoaded({required this.isButtonClicked});
  @override
  List<Object> get props =>[isButtonClicked];
}

class ChangePriorityLoaded extends ClaimDetailsInitial{
  final bool isPriorityChanged;

  ChangePriorityLoaded({required this.isPriorityChanged});
  @override
  List<Object> get props =>[isPriorityChanged];
}


class AssignedClaimError extends ClaimDetailsInitial {

  final String msg;
  AssignedClaimError({required this.msg});

  @override
  List<Object> get props =>[msg];
}