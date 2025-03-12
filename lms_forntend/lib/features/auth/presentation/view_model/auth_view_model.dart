import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_management_system/config/common/show_snack_bar.dart';
import 'package:learn_management_system/core/app_routes.dart';
import 'package:learn_management_system/features/auth/domain/entity/auth_entity.dart';
import 'package:learn_management_system/features/auth/domain/usecases/login_usercase.dart';
import 'package:learn_management_system/features/auth/domain/usecases/register_usecase.dart';
import 'package:learn_management_system/features/auth/presentation/state/auth_state.dart';

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  return AuthViewModel(
      ref.read(registerUsecaseProvider), ref.read(loginUseCaseProvider));
});

class AuthViewModel extends StateNotifier<AuthState> {
  final RegisterUsecase registerUsecase;
  final LoginUseCase loginUsecase;

  AuthViewModel(this.registerUsecase, this.loginUsecase)
      : super(AuthState.initial());

  Future<void> register(AuthEntity authEntity, BuildContext context) async {
    state = state.copyWith(isLoading: false);
    final result = await registerUsecase.register(authEntity);

    result.fold((failure) {
      state = state.copyWith(
        error: failure.error,
        showMessage: true,
      );
      showSnackBar(message: failure.error, context: context, color: Colors.red);
    }, (success) {
      state = state.copyWith(
        isLoading: false,
        error: null,
        showMessage: true,
      );
      EasyLoading.show(status: 'Please Wait...', maskType: EasyLoadingMaskType.black);
       Future.delayed(const Duration(seconds: 2), () {
      EasyLoading.showSuccess( 'Register Successfully');
        Navigator.pushNamed(context, AppRoute.loginViewRoute);
        EasyLoading.dismiss();
      });
    });
  }

  Future<void> login(
      String userName, String password, BuildContext context) async {
    state = state.copyWith(isLoading: false);
    final result = await loginUsecase.login(userName, password);
    result.fold((failure) {
      state = state.copyWith(
        error: failure.error.toString(),
        showMessage: true,
      );
      showSnackBar(
          message: failure.error.toString(),
          context: context,
          color: Colors.red);
    }, (success) {
      state = state.copyWith(
        isLoading: false,
        error: null,
        showMessage: true,
        currentUser: success
      );
            EasyLoading.show(status: 'Please Wait...', maskType: EasyLoadingMaskType.black);

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, AppRoute.bottomViewRoute);
      EasyLoading.showSuccess('Loggedin in',);
        EasyLoading.dismiss();
      });
    });
  }


}
