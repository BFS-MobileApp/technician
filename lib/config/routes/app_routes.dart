import 'package:flutter/material.dart';
import 'package:technician/config/arguments/routes_arguments.dart';
import 'package:technician/feature/add%20attendance/presentation/screen/add_attendance_screen.dart';
import 'package:technician/feature/claim%20details/presentation/screen/assigned_claims_screen.dart';
import 'package:technician/feature/claim%20details/presentation/screen/cancelled_claims_screen.dart';
import 'package:technician/feature/claim%20details/presentation/screen/closed_claims_screen.dart';
import 'package:technician/feature/claim%20details/presentation/screen/completed_claims_screen.dart';
import 'package:technician/feature/claim%20details/presentation/screen/new_claims_screen.dart';
import 'package:technician/feature/claim%20details/presentation/screen/started_claims_screen.dart';
import 'package:technician/feature/claims/presentation/screen/claims_screen.dart';
import 'package:technician/feature/edit%20profile/presentation/screen/edit_profile_screen.dart';
import 'package:technician/feature/forgot%20password/presentation/screen/forgot_password_screen.dart';
import 'package:technician/feature/home/presentation/screen/home_screen.dart';
import 'package:technician/feature/login/presentation/screen/login_screen.dart';
import 'package:technician/feature/main/presentation/screen/main_screen.dart';
import 'package:technician/feature/my_attendance/presentation/screen/my_attendance_screen.dart';
import 'package:technician/feature/notification/presentation/screen/notification_screen.dart';
import 'package:technician/feature/notification_details/presentation/screen/notification_details_screen.dart';
import 'package:technician/feature/reset_password/presentation/screen/reset_password_screen.dart';
import 'package:technician/feature/settings/presentation/screen/settings_screen.dart';
import 'package:technician/feature/splash/presentation/screen/splash_screen.dart';
import 'package:technician/feature/technician_time_history/presentation/screen/technician_history.dart';
import 'package:technician/feature/view%20attendance/presentation/screen/view_attendance_screen.dart';
import 'package:technician/widgets/full_screen_image.dart';

import '../../feature/new claim/presentation/screen/new_claim_screen.dart';

class Routes{

  static const String initialRoutes = '/';

  static const String login = 'Login';

  static const String forgotPassword = 'Forgot Password';

  static const String main = 'Main';

  static const String home = 'Home';

  static const String claims = 'Claims';

  static const String cancelledClaims = 'Cancelled Claims';

  static const String completedClaims = 'Completed Claims';

  static const String newClaims = 'New Claims';

  static const String assignedClaims = 'Assigned Claims';

  static const String closedClaims = 'Closed Claims';

  static const String startedClaims = 'Started Claims';

  static const String settings = 'Settings';

  static const String editProfile = 'Edit Profile';

  static const String  addNewClaim = 'Add New Claim';

  static const String  notification = 'Notification';

  static const String  fullScreenImage = 'Full Screen Image';

  static const String technicianHistory = 'Technician History';

  static const String notificationDetailsScreen = 'Notification Details Screen';

  static const String resetPassword = "Reset Password Screen";

  static const String myAttendance = "My Attendance";

  static const String addAttendance = "Add Attendance";

  static const String viewAttendance = "View Attendance";

}

class AppRoutes{

  static Route? onGenerateRoute(RouteSettings routeSettings){
    switch (routeSettings.name){
      case Routes.initialRoutes:
        return MaterialPageRoute(builder: (context) {
          return const SplashScreen();
        });
      case Routes.login:
        return MaterialPageRoute(builder: (context) {
          return const LoginScreen();
        });
      case Routes.forgotPassword:
        return MaterialPageRoute(builder: (context) {
          return const ForgotPasswordScreen();
        });
      case Routes.main:
        return MaterialPageRoute(builder: (context) {
          return const MainScreen();
        });
      case Routes.home:
        return MaterialPageRoute(builder: (context) {
          return const HomeScreen();
        });
      case Routes.resetPassword:
        return MaterialPageRoute(builder: (context) {
          final args = routeSettings.arguments as ResetPasswordArguments;
          return ResetPasswordScreen(email: args.email,token: args.token,);
        });
      case Routes.claims:
        return MaterialPageRoute(builder: (context) {
          final args = routeSettings.arguments as ClaimsArguments;
          return ClaimScreen(screenId: args.screenId,);
        });
      case Routes.cancelledClaims:
        return MaterialPageRoute(builder: (context) {
          final args = routeSettings.arguments as ClaimDetailsArguments;
          return CancelledClaimsScreen(referenceId: args.referenceId,claimId: args.claimId,);
        });
      case Routes.completedClaims:
        return MaterialPageRoute(builder: (context) {
          final args = routeSettings.arguments as ClaimDetailsArguments;
          return CompletedClaimsScreen(referenceId: args.referenceId,claimId: args.claimId);
        });
      case Routes.newClaims:
        return MaterialPageRoute(builder: (context) {
          final args = routeSettings.arguments as ClaimDetailsArguments;
          return NewClaims(claimId: args.claimId,referenceId: args.referenceId,);
        });
      case Routes.assignedClaims:
        return MaterialPageRoute(builder: (context) {
          final args = routeSettings.arguments as ClaimDetailsArguments;
          return AssignedClaimsScreen(claimId: args.claimId, referenceId: args.referenceId,);
        });
      case Routes.closedClaims:
        return MaterialPageRoute(builder: (context) {
          final args = routeSettings.arguments as ClaimDetailsArguments;
          return ClosedClaimsScreen(referenceId: args.referenceId,claimId: args.claimId);
        });
      case Routes.startedClaims:
        return MaterialPageRoute(builder: (context) {
          final args = routeSettings.arguments as ClaimDetailsArguments;
          return  StartedClaimsScreen(claimId: args.claimId, referenceId: args.referenceId,);
        });
      case Routes.settings:
        return MaterialPageRoute(builder: (context) {
          return const SettingsScreen();
        });
      case Routes.editProfile:
        return MaterialPageRoute(builder: (context) {
          return const EditProfileScreen();
        });
      case Routes.addNewClaim:
        return MaterialPageRoute(builder: (context) {
          return const NewClaimScreen();
        });
      case Routes.notification:
        return MaterialPageRoute(builder: (context) {
          return const NotificationScreen();
        });
      case Routes.notificationDetailsScreen:
        final args = routeSettings.arguments as ClaimDetailsArguments;
        return MaterialPageRoute(builder: (context) {
          return  NotificationDetailsScreen(referenceId: args.referenceId, claimId: args.claimId);
        });
      case Routes.technicianHistory:
        return MaterialPageRoute(builder: (context) {
          final args = routeSettings.arguments as TechnicianHistoryArguments;
          return TechnicianHistory(employeeList: args.employeesList, logList: args.logList,timeList: args.timeList,);
        });
      case Routes.fullScreenImage:
        return MaterialPageRoute(builder: (context) {
          final args = routeSettings.arguments as FullScreenImageArguments;
          return FullScreenImage(imageUrl: args.image);
        });
      case Routes.myAttendance:
        return MaterialPageRoute(builder: (context) {
          return const MyAttendanceScreen();
        });
      case Routes.addAttendance:
        return MaterialPageRoute(builder: (context) {
          return const AddAttendanceScreen();
        });
      case Routes.viewAttendance:
        return MaterialPageRoute(builder: (context) {
          final args = routeSettings.arguments as ViewAttendanceArguments;
          return ViewAttendanceScreen(color: args.color , checkType: args.checkType , longitude: args.longitude, latitude:  args.latitude , remMarks: args.remMarks, date: args.date, time: args.time,);
        });
      default:
        return null;
    }
  }
}