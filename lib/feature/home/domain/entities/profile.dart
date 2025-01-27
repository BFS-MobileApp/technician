import 'package:equatable/equatable.dart';

class UserInfo extends Equatable{

  final int id;
  final String name;
  final String email;
  final String image;
  final String mobile;
  final int emailNotification;
  final List<String> permissions;
  const UserInfo({required this.name,required this.email , required this.image , required this.mobile , required this.permissions , required this.id , required this.emailNotification});

  @override
  List<Object?> get props => [name , email , image , mobile , permissions , id];

}