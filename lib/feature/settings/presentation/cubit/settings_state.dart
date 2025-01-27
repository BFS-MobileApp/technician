import 'package:equatable/equatable.dart';
import 'package:technician/feature/settings/domain/entities/settings_user_info.dart';

abstract class SettingsState extends Equatable{
  const SettingsState();
}

class SettingsInitial extends SettingsState {
  @override
  List<Object> get props => [];
}

class SettingsInitialState extends SettingsInitial{}

class SettingsIsLoading extends SettingsInitial{}

class SettingsLoaded extends SettingsInitial{

  final SettingsUserInfo userInfo;

  SettingsLoaded({required this.userInfo});

  @override
  List<Object> get props =>[userInfo];
}

class SettingsLoadedWithoutData extends SettingsInitial{


  @override
  List<Object> get props =>[];
}

class SettingsError extends SettingsInitial{
  final String msg;
  SettingsError({required this.msg});

  @override
  List<Object> get props =>[msg];
}