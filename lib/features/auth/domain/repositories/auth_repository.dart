import 'package:dartz/dartz.dart';
import 'package:fap/core/error/failures.dart';
import 'package:fap/features/auth/data/models/auth_response_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponseModel>> requestOtp(String phoneNumber);
  Future<Either<Failure, AuthResponseModel>> verifyOtp(
    String phoneNumber,
    String otp,
  );
}
