// lib/presentation/bloc/auth/auth_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 2));
      final prefs = await SharedPreferences.getInstance();
      if (email == 'test@example.com' && password == 'password') {
        await prefs.setString('auth_token', 'simulated_token_user_123');

        emit(AuthSuccess('user_123'));
      } else {

        emit(AuthFailure('Email atau password salah.'));
      }
    } catch (e) {

      emit(AuthFailure('Terjadi kesalahan jaringan.'));
    }
  }

  Future<void> register(String email, String password) async {
    try {
      emit(AuthLoading());

      await Future.delayed(const Duration(seconds: 2));
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('profile_completed', false);

      emit(AuthSuccess('new_user_id'));
    } catch (e) {
      emit(AuthFailure('Gagal mendaftar: $e'));
    }
  }
}
