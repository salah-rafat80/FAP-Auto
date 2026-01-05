import 'package:dartz/dartz.dart';
import 'package:fap/core/error/failures.dart';
import 'package:fap/features/auth/domain/repositories/auth_repository.dart';
import 'package:fap/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:fap/features/auth/data/models/auth_response_model.dart';
import 'package:fap/features/auth/data/models/otp_request_model.dart';
import 'package:fap/features/auth/data/models/verify_otp_request_model.dart';

import 'package:dio/dio.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, AuthResponseModel>> requestOtp(
    String phoneNumber,
  ) async {
    try {
      final response = await remoteDataSource.requestOtp(
        OtpRequestModel(phoneNumber: phoneNumber),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          message:
              e.response?.data['messageAr'] ?? e.message ?? 'Unknown error',
        ),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponseModel>> verifyOtp(
    String phoneNumber,
    String otp,
  ) async {
    try {
      final response = await remoteDataSource.verifyOtp(
        VerifyOtpRequestModel(phoneNumber: phoneNumber, otp: otp),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          message:
              e.response?.data['messageAr'] ?? e.message ?? 'Unknown error',
        ),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
