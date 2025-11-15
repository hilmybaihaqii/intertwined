import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/config/router.dart';
import 'core/config/injector.dart';
import 'presentation/bloc/auth/auth_cubit.dart';
import 'presentation/bloc/profile/profile_cubit.dart';

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
        BlocProvider(
          create: (context) => locator<AuthCubit>(),
        ),
        BlocProvider(
          create: (context) => locator<ProfileCubit>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Find Friends App',
        theme: ThemeData(primarySwatch: Colors.blue),
        routerConfig: router,
      ),
    );
  }
}
