import 'package:equatable/equatable.dart';

class Login extends Equatable{

  final String name;
  final String token;
  final String msg;
  const Login({required this.name,required this.token , required this.msg});

  @override
  List<Object?> get props => [name , token , msg];

}