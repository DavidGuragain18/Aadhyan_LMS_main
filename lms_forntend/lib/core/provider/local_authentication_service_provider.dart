import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

final localAuthenticationServiceProvider = StateNotifierProvider<LocalAuthenticationService, bool>((ref) {
  return LocalAuthenticationService();
});

class LocalAuthenticationService extends StateNotifier<bool> {
  LocalAuthenticationService() : super(false);

  Future<bool> authWithBiometric(bool isEnabled) async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

    bool isAuthenticated = false;

    if (isBiometricSupported && canCheckBiometrics) {
      try {
        isAuthenticated = await localAuthentication.authenticate(
          localizedReason: "Verify the biometric",
          options: const AuthenticationOptions(biometricOnly: true),
        );
      } catch (e) {
        print("Error in biometric is $e");
      }
    }

    if (isAuthenticated) {
      state = isEnabled;
    }

    return isAuthenticated;
  }
}
