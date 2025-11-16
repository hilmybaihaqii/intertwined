import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_state.dart';
// import 'package:my_app/data/services/api_service.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());

      // --- Simulasi Panggilan API ---
      await Future.delayed(const Duration(seconds: 1));
      final bool isProfileCompleteFromApi;
      final String tokenFromApi;
      final String userIdFromApi;

      if (email == 'user@example.com') {
        isProfileCompleteFromApi = true;
        tokenFromApi = 'real_token_from_be_123';
        userIdFromApi = 'user-uuid-123';
      } else if (email == 'new@example.com') {
        isProfileCompleteFromApi = false;
        tokenFromApi = 'real_token_from_be_456';
        userIdFromApi = 'user-uuid-456';
      } else {
        throw Exception('Email atau password salah.');
      }
      // --- Akhir Simulasi ---

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', tokenFromApi);
      await prefs.setBool('profile_completed', isProfileCompleteFromApi);

      emit(AuthSuccess(userIdFromApi));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> register(String email, String password) async {
    try {
      emit(AuthLoading());

      await Future.delayed(const Duration(seconds: 1));
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', 'real_token_from_register_789');
      await prefs.setBool('profile_completed', false);

      emit(AuthSuccess('new-user-uuid-789'));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.remove('auth_token');
      await prefs.remove('profile_completed');
      await prefs.remove('onboarding_completed');

      emit(AuthInitial());
    } catch (e) {
      emit(AuthInitial());
    }
  }
}
