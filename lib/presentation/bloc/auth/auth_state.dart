// lib/presentation/bloc/auth/auth_state.dart

import 'package:equatable/equatable.dart';

// Equatable digunakan untuk membandingkan state object agar tidak terjadi rebuild berlebihan.
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

// 1. Initial State (Saat aplikasi pertama kali dibuka)
class AuthInitial extends AuthState {}

// 2. Loading State (Saat proses login/register sedang berjalan)
class AuthLoading extends AuthState {}

// 3. Success State (Saat login/register berhasil)
class AuthSuccess extends AuthState {
  final String userId;
  const AuthSuccess(this.userId);

  @override
  List<Object> get props => [userId];
}

// 4. Failure State (Saat terjadi kesalahan)
class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message);

  @override
  List<Object> get props => [message];
}
