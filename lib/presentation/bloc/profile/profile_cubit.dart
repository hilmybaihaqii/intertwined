// lib/presentation/bloc/profile/profile_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile_state.dart';
import 'dart:developer' as developer;


class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  void updateProfileData(String key, dynamic value) {
    final updatedData = Map<String, dynamic>.from(state.profileData);
    updatedData[key] = value;
    
    emit(state.copyWith(profileData: updatedData));
    developer.log('Data diperbarui: $updatedData', name: 'ProfileCubit');
  }

  Future<void> submitProfile() async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      
      // 1. SIMULASI KIRIM DATA KE API
      await Future.delayed(const Duration(seconds: 2));
      
      if (state.profileData.length >= 10) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('profile_completed', true);
        
        emit(state.copyWith(
          isLoading: false, 
          isCompleted: true, 
          errorMessage: null,
        ));
      } else {
         emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Harap lengkapi semua 10 pertanyaan.',
        ));
      }

    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Gagal mengirim data profil: $e',
      ));
    }
  }
}