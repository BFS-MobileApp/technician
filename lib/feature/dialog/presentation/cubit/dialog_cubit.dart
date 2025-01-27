import 'package:flutter_bloc/flutter_bloc.dart';

part 'dialog_state.dart';

class DialogCubit extends Cubit<DialogState> {
  DialogCubit() : super(DialogInitial());

  void showDialog() {
    emit(DialogVisible());
  }

  void dismissDialog() {
    emit(DialogHidden());
  }
}
