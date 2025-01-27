import 'package:equatable/equatable.dart';

class EditProfileUserInfo extends Equatable{
  @override
  String name;
  String email;
  String image;
  String phone;
  int emailNotification;

  EditProfileUserInfo({required this.name , required this.email , required this.image , required this.phone , required this.emailNotification});
  List<Object?> get props => [name , email , image , phone];

}