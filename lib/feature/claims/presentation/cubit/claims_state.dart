import 'package:equatable/equatable.dart';
import 'package:technician/feature/claims/data/models/claims_model.dart';
import 'package:technician/feature/claims/data/models/technician_model.dart';


abstract class ClaimsState extends Equatable{
  const ClaimsState();
}

class ClaimsInitial extends ClaimsState {
  @override
  List<Object> get props => [];
}

class ClaimsInitialState extends ClaimsInitial{}

class ClaimsIsLoading extends ClaimsInitial{}

class ClaimsLoaded extends ClaimsInitial{

  final ClaimsModel model;

  ClaimsLoaded({required this.model});

  @override
  List<Object> get props =>[model];
}


class ClaimsError extends ClaimsInitial{
  final String msg;
  ClaimsError({required this.msg});

  @override
  List<Object> get props =>[msg];
}