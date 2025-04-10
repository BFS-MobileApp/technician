import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/PrefHelper/helper.dart';

import 'package:technician/config/PrefHelper/prefs.dart';
import 'package:technician/config/arguments/routes_arguments.dart';
import 'package:technician/config/routes/app_routes.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/widgets/logo_widget.dart';
import 'package:technician/widgets/text_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  double _opacity = 0.0;
  double _scale = 0.5;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Helper.getDefaultLanguage(); // Ensures Get.updateLocale runs after build
    });
    Helper.getCurrentLocal();
    _handleDeepLink();
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _opacity = 1.0;
        _scale = 1.0;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  Future<void> _handleDeepLink() async {
    try {
      print('here0');
      final initialLink = await AppLinks().getInitialLinkString();
      if (initialLink != null) {
        print('here1');
        _navigateFromDeepLink(initialLink);
        return;
      } else {
        startTimer();
      }
      AppLinks().stringLinkStream.listen((String? link) {
        if (link != null) {
          _navigateFromDeepLink(link);
        }
      });
    } catch (e) {
      print('here1 with error ');
      print("Error handling deep link: $e");
    }
  }

  void _navigateFromDeepLink(String link) {
    print('here2');
    final Uri deepLinkUri = Uri.parse(link);
    String token = '';
    String email = '';
    final pathSegments = deepLinkUri.pathSegments;
    if (pathSegments.length > 2 && pathSegments[1] == 'reset') {
      token = pathSegments[2];
    }
    email = deepLinkUri.queryParameters['email'].toString();
    print('Token: $token');
    print('Email: $email');
    if (deepLinkUri.path.contains('/password/reset')) {
      print('here3');
      Navigator.pushReplacementNamed(context, Routes.resetPassword,
          arguments: ResetPasswordArguments(token: token, email: email));
    }
  }

  void startTimer() {
    _timer = Timer(const Duration(milliseconds: 800), () {
      moveToNextScreen();
    });
  }

  void moveToHomeScreen() {
    Future.delayed(const Duration(milliseconds: 800), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.main,
        (Route<dynamic> route) => false,
      );
    });
  }

  void moveToLoginScreen() {
    Future.delayed(const Duration(milliseconds: 800), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.login,
        (Route<dynamic> route) => false,
      );
    });
  }

  void moveToNextScreen() {
    Prefs.getBool(AppStrings.login) ? moveToHomeScreen() : moveToLoginScreen();
  }

  Widget buildLogo(BuildContext context) {
    return Center(
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(seconds: 1),
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.5, end: _scale),
          duration: const Duration(seconds: 1),
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AssetsManager.logo,
                        width: 150.w,
                        height: 150.h,
                      ),
                      SizedBox(height: 10.h),
                      TextWidget(
                        text: 'claimFixer'.tr,
                        fontSize: 25.fSize,
                        fontWeight: FontWeight.w600,
                        fontColor: AppColors.primaryColor,
                      ),
                      SizedBox(height: 10.h),
                      TextWidget(
                        text: 'techniciansAndStaff'.tr,
                        fontSize: 20.fSize,
                        fontWeight: FontWeight.w500,
                        fontColor: AppColors.primaryColor,
                      ),
                    ],
                  ),
                  const Spacer(),
                  const LogoWidget()
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildLogo(context),
    );
  }
}
