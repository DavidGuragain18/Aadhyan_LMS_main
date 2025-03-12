import 'package:flutter/src/widgets/basic.dart';
import 'package:learn_management_system/features/auth/domain/entity/auth_entity.dart';

class ProfileState {
  final bool isLoading;
  final String? error;
  final bool? showMessage;
  final List<AuthEntity>? users;

  ProfileState(
      {required this.isLoading,
      required this.error,
      required this.showMessage,
      this.users});

  factory ProfileState.initial() {
    return ProfileState(
      isLoading: false,
      error: null,
      showMessage: false,
      users: null,
    );
  }

  ProfileState copyWith({
    bool? isLoading,
    String? error,
    bool? showMessage,
    List<AuthEntity>? users,
  }) {
    return ProfileState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        showMessage: showMessage ?? this.showMessage,
        users: users ?? this.users);
  }

  @override
  String toString() {
    return 'ProfileState(isLoading: $isLoading, error: $error, showMessage: $showMessage, users: $users)';
  }

  when({required Column Function(dynamic profiles) data, required Center Function() loading, required Center Function(dynamic error, dynamic stack) error}) {}
}
