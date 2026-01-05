import 'package:dio/dio.dart';
import 'package:fap/features/auth/data/models/auth_response_model.dart';
import 'package:fap/features/auth/data/models/otp_request_model.dart';

import 'package:fap/features/auth/data/models/verify_otp_request_model.dart';

abstract class AuthRemoteDataSource {
  static const String baseUrl = 'https://fapautoapps.com/ords/app';
  Future<AuthResponseModel> requestOtp(OtpRequestModel request);
  Future<AuthResponseModel> verifyOtp(VerifyOtpRequestModel request);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<AuthResponseModel> requestOtp(OtpRequestModel request) async {
    try {
      final response = await dio.post(
        'https://fapautoapps.com/ords/app/auth/requestOtp',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return AuthResponseModel.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthResponseModel> verifyOtp(VerifyOtpRequestModel request) async {
    try {
      final response = await dio.post(
        'https://fapautoapps.com/ords/app/auth/verifyOtp',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return AuthResponseModel.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
