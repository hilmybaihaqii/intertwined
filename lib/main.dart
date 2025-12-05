// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/config/router.dart';
import 'core/config/injector.dart';
import 'presentation/bloc/auth/auth_cubit.dart';
import 'presentation/bloc/profile/profile_cubit.dart';
import 'core/constants/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => locator<AuthCubit>()),
        BlocProvider(create: (context) => locator<ProfileCubit>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Find Friends App',

        theme: ThemeData(
          primarySwatch: Colors.blue,

          primaryColor: AppColors.softTerracotta,
          scaffoldBackgroundColor: AppColors.creamyWhite,

          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.creamyWhite,
            foregroundColor: AppColors.deepBrown,
            elevation: 0,
          ),

          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.softTerracotta,
              foregroundColor: AppColors.creamyWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 3,
            ),
          ),

          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: AppColors.deepBrown),
          ),

          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.softTerracotta,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.deepBrown.withAlpha(128)),
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: AppColors.deepBrown),
            bodyMedium: TextStyle(color: AppColors.deepBrown),
            headlineLarge: TextStyle(
              color: AppColors.deepBrown,
              fontWeight: FontWeight.bold,
            ),
            headlineMedium: TextStyle(
              color: AppColors.deepBrown,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        routerConfig: router,
      ),
    );
  }
}
