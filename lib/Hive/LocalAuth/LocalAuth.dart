import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

class LocalAuth {
  static final auth = LocalAuthentication();

  static Future<bool> canAuthenticate() async =>
      await auth.canCheckBiometrics || await auth.isDeviceSupported();

  static Future<bool> authenticate() async {
    try {
      if (!await canAuthenticate()) return false;
      //List<BiometricType> availableBio = await auth.getAvailableBiometrics();

      return await auth.authenticate(
        localizedReason: 'Please authenticate to show account balance',
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
            biometricSuccess: 'done',
            signInTitle: 'Oops! Biometric authentication required!',
          ),
          IOSAuthMessages(),
        ],
        options: const AuthenticationOptions(
          biometricOnly: true,
          useErrorDialogs: false,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      print('Authentication failed: $e');
      return false;
    }
  }

  Future<List<BiometricType>> getAvailable() async {
    List<BiometricType> availableBio = await auth.getAvailableBiometrics();
    return availableBio;
  }
}

class BiometricAuth {
  static final _auth = LocalAuthentication();

  Future<bool> authenticateWithFaceID(BuildContext context) async {
    try {
      if (!await _auth.canCheckBiometrics) {
        // Biometrics is not available on this device
        return false;
      }

      List<BiometricType> availableBiometrics =
          await _auth.getAvailableBiometrics();

      if (availableBiometrics.contains(BiometricType.face)) {
        // Face ID is available
        bool authenticated = await _auth.authenticate(
            localizedReason: 'Authenticate using Face ID to access the app',
            options: const AuthenticationOptions(
              useErrorDialogs: true,
              stickyAuth: true,
            ));

        if (authenticated) {
          // User has been successfully authenticated
          return true;
        } else {
          // Authentication failed or user canceled
          return false;
        }
      } else {
        // Face ID is not available on this device
        return false;
      }
    } catch (e) {
      // Handle any exceptions that might occur during authentication
      print('Error during Face ID authentication: $e');
      return false;
    }
  }
}
