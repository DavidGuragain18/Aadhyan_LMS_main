import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_management_system/config/common/show_snack_bar.dart';
import 'package:learn_management_system/features/auth/domain/entity/auth_entity.dart';
import 'package:learn_management_system/features/profile/data/profile_remote_datasource.dart';

import '../state/profile_state.dart';

final profileViewModelProvider =
    StateNotifierProvider<ProfileViewModel, ProfileState>(
        (ref) => ProfileViewModel(
              ref.read(profileRemoteDatasourceProvider),
            ));

class ProfileViewModel extends StateNotifier<ProfileState> {
  // final GetProfileUseCase _getProfileUseCase;
  final ProfileRemoteDatasource _profileRemoteDatasource;

  ProfileViewModel(
    this._profileRemoteDatasource,
  ) : super(ProfileState.initial()) {
    getProfile();
  }

  Future<void> getProfile() async {
    state = state.copyWith(isLoading: true);

    try {
      final result = await _profileRemoteDatasource.getProfile();

      result.fold(
        (failure) =>
            state = state.copyWith(isLoading: false, error: failure.error),
        (users) => state = state.copyWith(isLoading: false, users: users),
      );
    } catch (e) {
      state = state.copyWith(
          isLoading: false, error: 'An unexpected error occurred');
    }
  }

  Future<void> updateProfile(AuthEntity authEntity, BuildContext context)async {
    state = state.copyWith(isLoading: true);
    final result = await _profileRemoteDatasource.updateProfile(authEntity);
    result.fold((failure) {
      state = state.copyWith(isLoading: false, error: failure.error);
    }, (success) {
      state = state.copyWith(isLoading: false, showMessage: null);
      resetState();
      showSnackBar(message: 'Updated Successfuly', context: context);
    });
  }

  Future resetState() async{
    state = ProfileState.initial();
    getProfile();
}
}

