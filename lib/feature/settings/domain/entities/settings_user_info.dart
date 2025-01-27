import 'package:equatable/equatable.dart';

class SettingsUserInfo extends Equatable{
  @override
  String name;
  String email;
  String image;

  SettingsUserInfo({required this.name , required this.email , required this.image});
  List<Object?> get props => [name , email , image];

}