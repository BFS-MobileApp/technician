import 'package:equatable/equatable.dart';
import 'package:technician/feature/notification/data/models/notification_model.dart';

abstract class NotificationState extends Equatable{
  const NotificationState();
}

class NotificationInitial extends NotificationState {
  @override
  List<Object> get props => [];
}

class NotificationInitialState extends NotificationInitial{}

class NotificationIsLoading extends NotificationInitial{}

class NotificationLoaded extends NotificationInitial{

  final NotificationModel model;

  NotificationLoaded({required this.model});

  @override
  List<Object> get props =>[model];

}

class NotificationError extends NotificationInitial{

  final String error;

  NotificationError({required this.error});

  @override
  List<Object> get props =>[error];
}
