import 'package:flutter/material.dart';
import 'package:learn_management_system/features/auth/domain/entity/auth_entity.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final String? imageName;
  final bool? showMessage;
  final AuthEntity currentUser;

  AuthState({
    required this.isLoading,
    this.error,
    this.imageName,
    this.showMessage,
    required this.currentUser,
  });

  factory AuthState.initial() {
    return AuthState(
      isLoading: false,
      error: null,
      imageName: null,
      showMessage: false,
      currentUser: AuthEntity(
        fullName: null,
        email: null,
        userName: null,
        phoneNumber: null,
        password: null,
        selectedCourse: [],
        image: null,
      ),
    );
  }

  AuthState copyWith({
    bool? isLoading,
    String? error,
    String? imageName,
    bool? showMessage,
    AuthEntity? currentUser,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      imageName: imageName ?? this.imageName,
      showMessage: showMessage ?? this.showMessage,
      currentUser: currentUser ?? this.currentUser,
    );
  }

  @override
  String toString() =>
      'AuthState(isLoading: $isLoading, error: $error, currentUser: $currentUser)';
}
