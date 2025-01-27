import 'package:equatable/equatable.dart';

class AddNewClaim extends Equatable{

  final bool result;
  final String claimId;
  const AddNewClaim({required this.result , required this.claimId});

  @override
  List<Object?> get props => [result , claimId];

}