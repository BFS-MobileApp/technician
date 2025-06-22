import 'package:dio/dio.dart';
import 'package:technician/feature/add%20attendance/data/data_sources/add_attendance_data_source.dart';
import 'package:technician/feature/add%20attendance/data/data_sources/add_attendance_data_source_impl.dart';
import 'package:technician/feature/add%20attendance/data/repositories/add_attendance_repository_impl.dart';
import 'package:technician/feature/add%20attendance/domain/repositories/add_attendance_repository.dart';
import 'package:technician/feature/add%20attendance/domain/use_cases/check_in_use_case.dart';
import 'package:technician/feature/add%20attendance/domain/use_cases/check_out_use_case.dart';
import 'package:technician/feature/add%20attendance/presentation/cubit/add_attendance_cubit.dart';
import 'package:technician/feature/claim%20details/data/data_sources/claims_details_data_source.dart';
import 'package:technician/feature/claim%20details/data/data_sources/claims_details_data_source_impl.dart';
import 'package:technician/feature/claim%20details/data/repositories/claims_details_repository_impl.dart';
import 'package:technician/feature/claim%20details/domain/repositories/claims_details_repository.dart';
import 'package:technician/feature/claim%20details/domain/use_cases/add_comment_usecase.dart';
import 'package:technician/feature/claim%20details/domain/use_cases/add_signature_usecase.dart';
import 'package:technician/feature/claim%20details/domain/use_cases/assign_claim_usecase.dart';
import 'package:technician/feature/claim%20details/domain/use_cases/change_claim_status_usecase.dart';
import 'package:technician/feature/claim%20details/domain/use_cases/change_priority_usecase.dart';
import 'package:technician/feature/claim%20details/domain/use_cases/download_signature_usecase.dart';
import 'package:technician/feature/claim%20details/domain/use_cases/material_usecase.dart';
import 'package:technician/feature/claim%20details/domain/use_cases/start_and_end_work_usecase.dart';
import 'package:technician/feature/claim%20details/presentation/cubit/claim_details_cubit.dart';
import 'package:technician/feature/claims/data/data_sources/claims_data_source.dart';
import 'package:technician/feature/claims/data/data_sources/claims_data_source_impl.dart';
import 'package:technician/feature/claims/data/repositories/claims_repository_impl.dart';
import 'package:technician/feature/claims/domain/repositories/claims_repository.dart';
import 'package:technician/feature/claims/domain/use_cases/all_claims_usecase.dart';
import 'package:technician/feature/claims/domain/use_cases/claim_details_usecase.dart';
import 'package:technician/feature/claims/domain/use_cases/technician_usecase.dart';
import 'package:technician/feature/claims/presentation/cubit/claims_cubit.dart';
import 'package:technician/feature/claims/presentation/cubit/technicial_cubit.dart';
import 'package:technician/feature/dialog/presentation/cubit/dialog_cubit.dart';
import 'package:technician/feature/edit%20profile/data/data_sources/edit_profile_local_data_source.dart';
import 'package:technician/feature/edit%20profile/data/data_sources/edit_profile_local_data_source_impl.dart';
import 'package:technician/feature/edit%20profile/data/repositories/edit_profile_repository_impl.dart';
import 'package:technician/feature/edit%20profile/domain/repositories/edit_profile_repository.dart';
import 'package:technician/feature/edit%20profile/domain/use_cases/change_password_usecase.dart';
import 'package:technician/feature/edit%20profile/domain/use_cases/edit_profile_usecase.dart';
import 'package:technician/feature/edit%20profile/domain/use_cases/update_profile_usecase.dart';
import 'package:technician/feature/edit%20profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:technician/feature/forgot%20password/data/data_sources/forgot_password_remote_data_source.dart';
import 'package:technician/feature/forgot%20password/data/data_sources/forgot_password_remote_data_source_impl.dart';
import 'package:technician/feature/forgot%20password/data/repositories/forgot_password_repository_impl.dart';
import 'package:technician/feature/forgot%20password/domain/repositories/forgot_password_repository.dart';
import 'package:technician/feature/forgot%20password/domain/use_cases/forgot_password_use_case.dart';
import 'package:technician/feature/forgot%20password/presentation/cubit/forgot_password_cubit.dart';
import 'package:technician/feature/home/data/data_sources/home_remote_data_source.dart';
import 'package:technician/feature/home/data/data_sources/home_remote_data_source_impl.dart';
import 'package:technician/feature/home/data/repositories/home_repository_impl.dart';
import 'package:technician/feature/home/domain/repositories/home_repository.dart';
import 'package:technician/feature/home/domain/use_cases/claims_usecase.dart';
import 'package:technician/feature/home/domain/use_cases/home_usecase.dart';
import 'package:technician/feature/home/presentation/cubit/home_cubit.dart';
import 'package:technician/feature/login/data/datasources/login_remote_data_source.dart';
import 'package:technician/feature/login/data/datasources/login_remote_data_source_impl.dart';
import 'package:technician/feature/login/data/repositories/login_repository_impl.dart';
import 'package:technician/feature/login/domain/repositories/login_repository.dart';
import 'package:technician/feature/login/domain/usecases/login_usecase.dart';
import 'package:technician/feature/login/presentation/cubit/login_cubit.dart';
import 'package:technician/feature/my_attendance/data/data_sources/my_attendance_data_source.dart';
import 'package:technician/feature/my_attendance/data/data_sources/my_attendance_data_source_impl.dart';
import 'package:technician/feature/my_attendance/data/repositories/my_attendace_repository_impl.dart';
import 'package:technician/feature/my_attendance/domain/repositories/my_attendance_repository.dart';
import 'package:technician/feature/my_attendance/domain/use_cases/my_attendance_use_case.dart';
import 'package:technician/feature/my_attendance/presentation/cubit/my_attendance_cubit.dart';
import 'package:technician/feature/new%20claim/data/data_sources/new_claim_data_source.dart';
import 'package:technician/feature/new%20claim/data/data_sources/new_claim_data_source_impl.dart';
import 'package:technician/feature/new%20claim/data/repositories/new_claim_repository_impl.dart';
import 'package:technician/feature/new%20claim/domain/repositories/new_claim_repository.dart';
import 'package:technician/feature/new%20claim/domain/use_cases/add_new_claim_usecase.dart';
import 'package:technician/feature/new%20claim/domain/use_cases/available_times_usecase.dart';
import 'package:technician/feature/new%20claim/domain/use_cases/buildings_usecase.dart';
import 'package:technician/feature/new%20claim/domain/use_cases/category_usecase.dart';
import 'package:technician/feature/new%20claim/domain/use_cases/claims_type_usecase.dart';
import 'package:technician/feature/new%20claim/domain/use_cases/unit_usecase.dart';
import 'package:technician/feature/new%20claim/presentation/cubit/new_claim_cubit.dart';
import 'package:technician/feature/notification/data/data_sources/notification_remote_data_source.dart';
import 'package:technician/feature/notification/data/data_sources/notification_remote_data_source_impl.dart';
import 'package:technician/feature/notification/data/repositories/notification_repository_impl.dart';
import 'package:technician/feature/notification/domain/repositories/notification_repository.dart';
import 'package:technician/feature/notification/domain/use_cases/notificaion_use_case.dart';
import 'package:technician/feature/notification/presentation/cubit/notification_cubit.dart';
import 'package:technician/feature/notification_details/data/data_sources/notification_details_remote_data_source.dart';
import 'package:technician/feature/notification_details/data/data_sources/notification_details_remote_data_source_impl.dart';
import 'package:technician/feature/notification_details/data/repositories/notification_details_repository_impl.dart';
import 'package:technician/feature/notification_details/domain/repositories/notification_details_repository.dart';
import 'package:technician/feature/notification_details/domain/use_cases/notification_details_use_case.dart';
import 'package:technician/feature/notification_details/presentation/cubit/notification_details_cubit.dart';
import 'package:technician/feature/reset_password/data/data_sources/reset_password_remote_data_source.dart';
import 'package:technician/feature/reset_password/data/data_sources/reset_password_remote_data_source_impl.dart';
import 'package:technician/feature/reset_password/data/repositories/reset_password_repository_impl.dart';
import 'package:technician/feature/reset_password/domain/repositories/reset_password_repository.dart';
import 'package:technician/feature/reset_password/domain/use_cases/reset_password_use_case.dart';
import 'package:technician/feature/reset_password/presentation/cubit/reset_password_cubit.dart';
import 'package:technician/feature/settings/data/data_sources/settings_local_data_source.dart';
import 'package:technician/feature/settings/data/data_sources/settings_local_data_source_impl.dart';
import 'package:technician/feature/settings/data/repositories/setting_repository_impl.dart';
import 'package:technician/feature/settings/domain/repositories/setting_repository.dart';
import 'package:technician/feature/settings/domain/use_cases/settings_change_lang_usecase.dart';
import 'package:technician/feature/settings/domain/use_cases/settings_usecase.dart';
import 'package:technician/feature/settings/presentation/cubit/settings_cubit.dart';
import 'package:technician/feature/splash/data/data_sources/splash_local_data_source.dart';
import 'package:technician/feature/splash/data/data_sources/splash_local_data_source_imp.dart';
import 'package:technician/feature/splash/data/repositories/splash_repo_impl.dart';
import 'package:technician/feature/splash/domain/repositories/splash_repo.dart';
import 'package:technician/feature/splash/domain/use_cases/splash_usecase.dart';
import 'package:technician/feature/splash/presentation/cubit/splash_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/api/api_consumer.dart';
import 'core/api/app_interceptor.dart';
import 'core/api/dio_consumer.dart';
import 'core/network/network_info.dart';
import 'feature/claim details/domain/use_cases/upload_file_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async{

  //Blocs
  sl.registerFactory(() => SplashCubit(splashUseCase: sl()));
  sl.registerFactory(() => LoginCubit(loginUseCase: sl()));
  sl.registerFactory(() => HomeCubit(homeUseCase: sl() , claimsUseCase: sl() , allClaimsUseCase: sl()));
  sl.registerFactory(() => SettingsCubit(settingsUseCase: sl() , settingsChangeLangUseCase: sl()));
  sl.registerFactory(() => EditProfileCubit(updateProfileUseCase: sl() , editProfileUseCase: sl() , changePasswordUseCase: sl()));
  sl.registerFactory(() => DialogCubit());
  sl.registerFactory(() => ClaimDetailsCubit(changeClaimStatusUseCase: sl() , addSignatureUseCase: sl() ,
      addCommentUseCase: sl() , startAndEndWorkUseCase: sl() , downloadSignatureUseCase: sl() ,
      assignClaimUseCase: sl() , changePriorityUseCase: sl() , claimDetailsUseCase: sl(),
      uploadCommentFileUseCase: sl(),materialUseCase: sl(), deleteMaterialUseCase: sl(),
      editMaterialQuantityUseCase: sl(),
      addMaterialUseCase: sl(),
      deleteClaimUseCase: sl(), uploadFileUseCase: sl(), deleteCommentUseCase: sl()));
  sl.registerFactory(() => ClaimsCubit(allClaimsUseCase: sl() , technicianUseCase: sl()));
  sl.registerFactory(() => TechnicalCubit(technicianUseCase: sl()));
  sl.registerFactory(() => ForgotPasswordCubit(forgotPasswordUseCase: sl()));
  sl.registerFactory(() => NotificationCubit(notificaionUseCase: sl()));
  sl.registerFactory(() => NotificationDetailsCubit(notificationDetailsUseCase: sl()));
  sl.registerFactory(() => ResetPasswordCubit(resetPasswordUseCase: sl()));
  sl.registerFactory(() => MyAttendanceCubit(myAttendanceUseCase: sl()));
  sl.registerFactory(() => AddAttendanceCubit(checkOutUseCase: sl() , checkInUseCase: sl()));
  sl.registerFactory(() => NewClaimCubit(buildingsUseCase: sl() ,
      unitUseCase: sl() , categoryUseCase: sl() , claimsTypeUseCase: sl()
      , availableTimesUseCase: sl() , addNewClaimUseCase: sl(), updateClaimUseCase: sl(), deleteFileUseCase: sl()));

  //UseCase
  sl.registerLazySingleton(() => SplashUseCase(splashRepository: sl()));
  sl.registerLazySingleton(() => LoginUseCase(loginRepository: sl()));
  sl.registerLazySingleton(() => UploadCommentFileUseCase(sl()));
  sl.registerLazySingleton(() => HomeUseCase(homeRepository: sl()));
  sl.registerLazySingleton(() => MaterialUseCase(claimsDetailsRepository: sl()));
  sl.registerLazySingleton(() => DeleteMaterialUseCase(claimsDetailsRepository: sl()));
  sl.registerLazySingleton(() => DeleteClaimUseCase(claimsDetailsRepository: sl()));
  sl.registerLazySingleton(() => DeleteCommentUseCase(claimsDetailsRepository: sl()));
  sl.registerLazySingleton(() => EditMaterialQuantityUseCase(claimsDetailsRepository: sl()));
  sl.registerLazySingleton(() => AddMaterialUseCase(claimsDetailsRepository: sl()));
  sl.registerLazySingleton(() => SettingsUseCase(settingRepository: sl()));
  sl.registerLazySingleton(() => SettingsChangeLangUseCase(settingRepository: sl()));
  sl.registerLazySingleton(() => EditProfileUseCase(editProfileRepository: sl()));
  sl.registerLazySingleton(() => DownloadSignatureUseCase(assignedClaimsRepository: sl()));
  sl.registerLazySingleton(() => AllClaimsUseCase(claimsRepository: sl()));
  sl.registerLazySingleton(() => ClaimsUseCase(homeRepository: sl()));
  sl.registerLazySingleton(() => BuildingsUseCase(newClaimRepository: sl()));
  sl.registerLazySingleton(() => UnitUseCase(newClaimRepository: sl()));
  sl.registerLazySingleton(() => CategoryUseCase(newClaimRepository: sl()));
  sl.registerLazySingleton(() => ClaimsTypeUseCase(newClaimRepository: sl()));
  sl.registerLazySingleton(() => DeleteFileUseCase( deleteFileRepository: sl()));
  sl.registerLazySingleton(() => AvailableTimesUseCase(newClaimRepository: sl()));
  sl.registerLazySingleton(() => AddNewClaimUseCase(newClaimRepository: sl()));
  sl.registerLazySingleton(() => UpdateClaimUseCase(newClaimRepository: sl()));
  sl.registerLazySingleton(() => TechnicianUseCase(claimsRepository: sl()));
  sl.registerLazySingleton(() => AssignClaimUseCase(claimsDetailsRepository: sl()));
  sl.registerLazySingleton(() => ChangePriorityUseCase(claimsDetailsRepository: sl()));
  sl.registerLazySingleton(() => ChangePasswordUseCase(editProfileRepository: sl()));
  sl.registerLazySingleton(() => ClaimDetailsUseCase(claimsDetailsRepository: sl()));
  sl.registerLazySingleton(() => StartAndEndWorkUseCase(claimsDetailsRepository: sl()));
  sl.registerLazySingleton(() => UpdateProfileUseCase(editProfileRepository: sl()));
  sl.registerLazySingleton(() => AddCommentUseCase(claimsDetailsRepository: sl()));
  sl.registerLazySingleton(() => UploadFileUseCase(repository:sl()));
  sl.registerLazySingleton(() => AddSignatureUseCase(claimsDetailsRepository: sl()));
  sl.registerLazySingleton(() => ChangeClaimStatusUseCase(claimsDetailsRepository: sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(forgotPasswordRepository: sl()));
  sl.registerLazySingleton(() => NotificaionUseCase(notificationRepository: sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(resetPasswordRepository: sl()));
  sl.registerLazySingleton(() => MyAttendanceUseCase(myAttendanceRepository: sl()));
  sl.registerLazySingleton(() => CheckInUseCase(addAttendanceRepository: sl()));
  sl.registerLazySingleton(() => CheckOutUseCase(addAttendanceRepository: sl()));
  sl.registerLazySingleton(() => NotificationDetailsUseCase(notificationDetailsRepository: sl()));

  //Repository
  sl.registerLazySingleton<SplashRepository>(() => SplashRepositoryImplementation(splashLocalDataSource: sl()));
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(loginRemoteDataSource: sl() , networkInfo: sl()));
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(homeRemoteDataSource: sl() , networkInfo: sl()));
  sl.registerLazySingleton<SettingRepository>(() => SettingsRepositoryImpl(settingsLocalDataSource: sl()));
  sl.registerLazySingleton<EditProfileRepository>(() => EditProfileRepositoryImpl(editProfileLocalDataSource: sl() , networkInfo: sl()));
  sl.registerLazySingleton<ClaimsDetailsRepository>(() => ClaimsDetailsRepositoryImpl(claimsDetailsDataSource: sl() , networkInfo: sl()));
  sl.registerLazySingleton<ClaimsRepository>(() => ClaimsRepositoryImpl(claimsDataSource: sl() , networkInfo: sl()));
  sl.registerLazySingleton<ForgotPasswordRepository>(() => ForgotPasswordRepositoryImpl(forgotPasswordRemoteDataSource: sl() , networkInfo: sl()));
  sl.registerLazySingleton<NewClaimRepository>(() => NewClaimRepositoryImpl(newClaimDataSource: sl() , networkInfo: sl()));
  sl.registerLazySingleton<ResetPasswordRepository>(() => ResetPasswordRepositoryImpl(resetPasswordRemoteDataSource: sl() , networkInfo: sl()));
  sl.registerLazySingleton<NotificationRepository>(() => NotificationRepositoryImpl(notificationRemoteDataSource: sl() , networkInfo: sl()));
  sl.registerLazySingleton<MyAttendanceRepository>(() => MyAttendanceRepositoryImpl(myAttendanceDataSource: sl() , networkInfo: sl()));
  sl.registerLazySingleton<AddAttendanceRepository>(() => AddAttendanceRepositoryImpl(addAttendanceDataSource: sl() , networkInfo: sl()));
  sl.registerLazySingleton<NotificationDetailsRepository>(() => NotificationDetailsRepositoryImpl(notificationDetailsRemoteDataSource: sl() , networkInfo: sl()));

  //DataSource
  sl.registerLazySingleton<SplashLocalDataSource>(() => SplashLocalDataSourceImplementation());
  sl.registerLazySingleton<LoginRemoteDataSource>(() => LoginRemoteDataSourceImpl(consumer: sl()));
  sl.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl(consumer: sl()));
  sl.registerLazySingleton<SettingsLocalDataSource>(() => SettingsLocalDataSourceImpl());
  sl.registerLazySingleton<EditProfileLocalDataSource>(() => EditProfileLocalDataSourceImpl(consumer: sl()));
  sl.registerLazySingleton<ClaimsDetailsDataSource>(() => ClaimsDetailsDataSourceImpl(consumer: sl()));
  sl.registerLazySingleton<ClaimsDataSource>(() => ClaimsDataSourceImpl(consumer: sl()));
  sl.registerLazySingleton<NewClaimDataSource>(() => NewClaimDataSourceImpl(consumer: sl()));
  sl.registerLazySingleton<ForgotPasswordRemoteDataSource>(() => ForgotPasswordRemoteDataSourceImpl(consumer: sl()));
  sl.registerLazySingleton<NotificationRemoteDataSource>(() => NotificationRemoteDataSourceImpl(consumer: sl()));
  sl.registerLazySingleton<ResetPasswordRemoteDataSource>(() => ResetPasswordRemoteDataSourceImpl(consumer: sl()));
  sl.registerLazySingleton<MyAttendanceDataSource>(() => MyAttendanceDataSourceImpl(consumer: sl()));
  sl.registerLazySingleton<AddAttendanceDataSource>(() => AddAttendanceDataSourceImpl(consumer: sl()));
  sl.registerLazySingleton<NotificationDetailsRemoteDataSource>(() => NotificationDetailsRemoteDataSourceImpl(consumer: sl()));

  //Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));


  //External
  final sharedPreference = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreference);
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => AppInterceptor());
  sl.registerLazySingleton(() => Dio());
}