import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:technician/config/theme/app_theme.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/core/utils/local_strings.dart';
import 'package:technician/feature/add%20attendance/presentation/cubit/add_attendance_cubit.dart';
import 'package:technician/feature/claim%20details/presentation/cubit/claim_details_cubit.dart';
import 'package:technician/feature/claims/presentation/cubit/claims_cubit.dart';
import 'package:technician/feature/claims/presentation/cubit/technicial_cubit.dart';
import 'package:technician/feature/dialog/presentation/cubit/dialog_cubit.dart';
import 'package:technician/feature/edit%20profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:technician/feature/forgot%20password/presentation/cubit/forgot_password_cubit.dart';
import 'package:technician/feature/home/presentation/cubit/home_cubit.dart';
import 'package:technician/feature/login/presentation/cubit/login_cubit.dart';
import 'package:technician/feature/my_attendance/presentation/cubit/my_attendance_cubit.dart';
import 'package:technician/feature/new%20claim/presentation/cubit/new_claim_cubit.dart';
import 'package:technician/feature/notification/presentation/cubit/notification_cubit.dart';
import 'package:technician/feature/notification_details/presentation/cubit/notification_details_cubit.dart';
import 'package:technician/feature/reset_password/presentation/cubit/reset_password_cubit.dart';
import 'package:technician/feature/settings/presentation/cubit/settings_cubit.dart';
import 'package:technician/feature/splash/presentation/cubit/splash_cubit.dart';
import 'config/routes/app_routes.dart';
import 'injection_container.dart' as di;
import 'widgets/message_widget.dart';

class MyApp extends StatefulWidget {
  final Uri? initialUri;

  const MyApp({super.key, this.initialUri});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    // Handle the initial deep link if provided
    if (widget.initialUri != null) {
      _handleDeepLink(widget.initialUri!);
    }

    // Listen for future deep links (when app is already running)
    AppLinks().uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleDeepLink(uri);
      }
    });
  }

  void _handleDeepLink(Uri uri) {
    // Example: Check if the deep link is a password reset link
    if (uri.path.startsWith("/password/reset")) {
      final email = uri.queryParameters["email"];
      final token = uri.pathSegments.last;

      // Navigate to the Reset Password Screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<SplashCubit>()),
        BlocProvider(create: (context) => di.sl<LoginCubit>()),
        BlocProvider(create: (context) => di.sl<HomeCubit>()),
        BlocProvider(create: (context) => di.sl<SettingsCubit>()),
        BlocProvider(create: (context) => di.sl<EditProfileCubit>()),
        BlocProvider(create: (context) => di.sl<DialogCubit>()),
        BlocProvider(create: (context) => di.sl<ClaimDetailsCubit>()),
        BlocProvider(create: (context) => di.sl<ClaimsCubit>()),
        BlocProvider(create: (context) => di.sl<NewClaimCubit>()),
        BlocProvider(create: (context) => di.sl<TechnicalCubit>()),
        BlocProvider(create: (context) => di.sl<ForgotPasswordCubit>()),
        BlocProvider(create: (context) => di.sl<NotificationCubit>()),
        BlocProvider(create: (context) => di.sl<NotificationDetailsCubit>()),
        BlocProvider(create: (context) => di.sl<ResetPasswordCubit>()),
        BlocProvider(create: (context) => di.sl<MyAttendanceCubit>()),
        BlocProvider(create: (context) => di.sl<AddAttendanceCubit>()),
      ],
      child: GetMaterialApp(
        translations: LocalStrings(),
        locale: const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),
        theme: appTheme(),
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        scaffoldMessengerKey: MessageWidget.scaffoldMessengerKey,
      ),
    );
  }
}
