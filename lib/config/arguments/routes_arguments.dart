import 'package:flutter/material.dart';
import 'package:technician/feature/claim%20details/data/models/claim_details_model.dart';

class RoutesArgument{}

class ClaimsArguments extends RoutesArgument{

  final int screenId;

  ClaimsArguments({required this.screenId});
}

class FullScreenImageArguments extends RoutesArgument{

  final String image;

  FullScreenImageArguments({required this.image});
}

class ViewAttendanceArguments extends RoutesArgument{

  final String longitude;
  final String latitude;
  final String remMarks;
  final String date;
  final String time;
  final String checkType;
  final Color color;

  ViewAttendanceArguments({required this.longitude , required this.checkType , required this.color , required this.latitude , required this.remMarks , required this.date , required this.time});
}

class ClaimDetailsArguments extends RoutesArgument{

  final String claimId;
  final String referenceId;

  ClaimDetailsArguments({required this.claimId , required this.referenceId});
}

class TechnicianHistoryArguments extends RoutesArgument{

  final List<Employee> employeesList;
  final List<Log> logList;
  final List<Time> timeList;

  TechnicianHistoryArguments({required this.logList , required this.employeesList , required this.timeList});
}

class ResetPasswordArguments extends RoutesArgument{

  final String token;
  final String email;

  ResetPasswordArguments({required this.token , required this.email});
}



