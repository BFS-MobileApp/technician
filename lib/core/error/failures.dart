import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable{

  final String msg;

  const Failures({required this.msg});

  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failures{
  const ServerFailure({required super.msg});
}

class CashFailure extends Failures{
  const CashFailure({required super.msg});
}