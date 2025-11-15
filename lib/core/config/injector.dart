// lib/core/config/injector.dart

import 'package:get_it/get_it.dart';
import '../../presentation/bloc/auth/auth_cubit.dart';
import '../../presentation/bloc/profile/profile_cubit.dart';

// Instance global dari GetIt
final locator = GetIt.instance;

void setupLocator() {
  // Daftarkan Cubit kita (Singleton)
  // LazySingleton berarti Cubit baru akan dibuat saat pertama kali diminta.
  locator.registerLazySingleton(() => AuthCubit());
  locator.registerLazySingleton(() => ProfileCubit());
  
  // Nanti, kita akan daftarkan Repository dan Usecase di sini juga.
}