import 'package:equatable/equatable.dart';
import 'package:technician/feature/claims/data/models/technician_model.dart';


abstract class TechnicalState extends Equatable{
  const TechnicalState();
}

class TechnicalInitial extends TechnicalState {
  @override
  List<Object> get props => [];
}

class TechnicalInitialState extends TechnicalInitial{}

class TechnicianIsLoading extends TechnicalInitial{}

class TechnicianLoaded extends TechnicalInitial{

  final TechnicianModel model;

  TechnicianLoaded({required this.model});

  @override
  List<Object> get props =>[model];
}

class TechnicianError extends TechnicalInitial{
  final String msg;
  TechnicianError({required this.msg});

  @override
  List<Object> get props =>[msg];
}