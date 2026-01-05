import 'package:dartz/dartz.dart';
import 'package:fap/core/error/failures.dart';
import 'package:fap/features/auth/data/models/auth_response_model.dart';
import 'package:fap/features/auth/domain/repositories/auth_repository.dart';

/// Use case for verifying OTP
class VerifyOtp {
  final AuthRepository repository;

  VerifyOtp(this.repository);

  /// Execute the use case
  Future<Either<Failure, AuthResponseModel>> call(
    String mobileNumber,
    String otp,
  ) async {
    return await repository.verifyOtp(mobileNumber, otp);
  }
}
