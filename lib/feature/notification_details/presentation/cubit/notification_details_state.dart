import 'package:equatable/equatable.dart';
import 'package:technician/feature/claim%20details/data/models/claim_details_model.dart';
import 'package:technician/feature/notification/data/models/notification_model.dart';

abstract class NotificationDetailsState extends Equatable{
  const NotificationDetailsState();
}

class NotificationDetailsInitial extends NotificationDetailsState {
  @override
  List<Object> get props => [];
}

class NotificationDetailsInitialState extends NotificationDetailsInitial{}

class NotificationDetailsIsLoading extends NotificationDetailsInitial{}

class NotificationDetailsLoaded extends NotificationDetailsInitial{

  final ClaimDetailsModel model;

  NotificationDetailsLoaded({required this.model});

  @override
  List<Object> get props =>[model];

}

class NotificationDetailsError extends NotificationDetailsInitial{

  final String error;

  NotificationDetailsError({required this.error});

  @override
  List<Object> get props =>[error];
}
