import 'package:technician/feature/settings/domain/entities/settings_user_info.dart';

abstract class SettingsLocalDataSource {

  Future<SettingsUserInfo> getUserInfo();

  Future<void> changeLanguage();

}