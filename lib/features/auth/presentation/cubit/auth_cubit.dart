import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fap/core/utils/auth_session.dart';
import 'package:fap/features/auth/domain/usecases/login_with_mobile.dart';
import 'package:fap/features/auth/domain/usecases/verify_otp.dart';
import 'package:fap/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginWithMobile loginWithMobile;
  final VerifyOtp verifyOtpUseCase;

  // Store phone number to use in verification
  String? _phoneNumber;

  final SharedPreferences sharedPreferences;
  final AuthSession authSession;

  AuthCubit({
    required this.loginWithMobile,
    required this.verifyOtpUseCase,
    required this.sharedPreferences,
    required this.authSession,
  }) : super(AuthInitial());

  Future<void> login(String phoneNumber) async {
    if (phoneNumber.length < 9) {
      emit(const AuthError(message: 'رقم الجوال غير صحيح'));
      return;
    }

    _phoneNumber = phoneNumber;
    emit(AuthLoading());

    final result = await loginWithMobile(phoneNumber);

    result.fold((failure) => emit(AuthError(message: failure.message)), (
      response,
    ) {
      if (response.status == 'error') {
        emit(
          AuthError(
            message:
                response.messageAr ?? response.messageEn ?? 'Unknown error',
          ),
        );
      } else {
        emit(AuthOtpSent(response: response));
      }
    });
  }

  Future<void> verifyOtp(String otp) async {
    if (_phoneNumber == null) {
      emit(const AuthError(message: 'Phone number not found'));
      return;
    }

    emit(AuthLoading());

    final result = await verifyOtpUseCase(_phoneNumber!, otp);

    result.fold((failure) => emit(AuthError(message: failure.message)), (
      response,
    ) {
      if (response.status == 'error') {
        emit(
          AuthError(
            message:
                response.messageAr ?? response.messageEn ?? 'Unknown error',
          ),
        );
      } else {
        if (response.token != null) {
          sharedPreferences.setString('auth_token', response.token!);
          // Save login session data
          authSession.saveLoginData(
            token: response.token!,
            phone: _phoneNumber!,
          );
        }
        emit(AuthVerified(response: response));
      }
    });
  }

  /// Logout and clear all session data
  Future<void> logout() async {
    await authSession.clearSession();
    emit(AuthLoggedOut());
  }

  void reset() {
    emit(AuthInitial());
  }
}
