// lib/presentation/bloc/profile/profile_state.dart

import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  final Map<String, dynamic> profileData;
  final bool isLoading;
  final String? errorMessage;
  final bool isCompleted;

  const ProfileState({
    required this.profileData,
    this.isLoading = false,
    this.errorMessage,
    this.isCompleted = false,
  });

  ProfileState copyWith({
    Map<String, dynamic>? profileData,
    bool? isLoading,
    String? errorMessage,
    bool? isCompleted,
  }) {
    return ProfileState(
      profileData: profileData ?? this.profileData,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [profileData, isLoading, errorMessage, isCompleted];
}

class ProfileInitial extends ProfileState {
  ProfileInitial() : super(profileData: {});
}