import 'package:equatable/equatable.dart';
import 'package:technician/feature/home/data/models/home_model.dart';
import 'package:technician/feature/home/domain/entities/profile.dart';

abstract class HomeState extends Equatable{
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeInitialState extends HomeInitial{}

class HomeIsLoading extends HomeInitial{}

class HomeLoaded extends HomeInitial{

  final UserInfo userInfo;

  HomeLoaded({required this.userInfo});

  @override
  List<Object> get props =>[userInfo];
}

class ClaimsLoaded extends HomeInitial{

  final HomeModel homeModel;

  ClaimsLoaded({required this.homeModel});

  @override
  List<Object> get props =>[homeModel];
}

class HomeError extends HomeInitial{
  final String msg;
  HomeError({required this.msg});

  @override
  List<Object> get props =>[msg];
}