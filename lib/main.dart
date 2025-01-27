import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'app.dart';
import 'bloc_observer.dart';
import 'config/PrefHelper/prefs.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(milliseconds: 150));
  await Prefs.init();
  await di.init();
  Bloc.observer = AppBlocObserver();
  final Uri? initialUri = await AppLinks().getInitialLink();
  PackageInfo.fromPlatform();
  runApp(MyApp(initialUri: initialUri));
}
