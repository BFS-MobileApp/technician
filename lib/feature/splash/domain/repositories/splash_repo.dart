import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';

abstract class SplashRepository{

  Future<Either<Failures , NoParams>> setSettings(BuildContext context);
}