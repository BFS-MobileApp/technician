part of 'splash_cubit.dart';

abstract class SplashState extends Equatable {
  const SplashState();
}

class SplashInitial extends SplashState {
  @override
  List<Object> get props => [];
}

class SplashInitialState extends SplashInitial{}

class SplashIsLoading extends SplashInitial{}

class SplashLoaded extends SplashInitial{}

class SplashError extends SplashInitial{
  final String msg;
  SplashError({required this.msg});

  @override
  List<Object> get props =>[msg];
}