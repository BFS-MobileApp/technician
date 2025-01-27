// lib/features/dialog/presentation/cubit/dialog_state.dart
part of 'dialog_cubit.dart';

abstract class DialogState {}

class DialogInitial extends DialogState {}

class DialogVisible extends DialogState {}

class DialogHidden extends DialogState {}
