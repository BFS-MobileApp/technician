import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/dialog/presentation/cubit/dialog_cubit.dart';

class DialogScreen extends StatelessWidget {
  const DialogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<DialogCubit, DialogState>(
        listener: (context, state) {
          if (state is DialogVisible) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return Dialog(
                  backgroundColor: Colors.transparent,
                  child: Container(
                    height: 50.h,
                    alignment: Alignment.center,
                    child: Lottie.asset(AssetsManager.loadingImage, width: 30.w),
                  ),
                );
              },
            );
          } else if (state is DialogHidden) {
            if (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }
          }
        },
        child: const SizedBox(),
      ),
    );
  }
}
