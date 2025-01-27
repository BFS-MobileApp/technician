import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';

class LoadingItem extends StatefulWidget {
  const LoadingItem({super.key});

  @override
  _LoadingItemState createState() => _LoadingItemState();
}

class _LoadingItemState extends State<LoadingItem> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    controller.addStatusListener(statusListener);
    controller.forward();
  }

  statusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      controller.value = 0.0;
      controller.forward();
    }
  }

  @override
  void dispose() {
    controller.removeStatusListener(statusListener);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
            height: 50.h,
            alignment: Alignment.center,
            child: Lottie.asset(AssetsManager.loadingImage, width: 30.w),
          )
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    Path path = Path();
    path.moveTo(w / 2, 0);
    path.lineTo(w / 2 - 20, 55);
    path.lineTo(w / 2, 55);
    path.lineTo(w / 2 - 20, h);
    path.lineTo(w / 2 + 20, 45);
    path.lineTo(w / 2, 45);
    path.lineTo(w / 2 + 20, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}

class MyCustomPainter extends CustomPainter {
  final double percentage;

  MyCustomPainter(this.percentage);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.mainColor
      ..style = PaintingStyle.fill;

    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height * percentage);

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

