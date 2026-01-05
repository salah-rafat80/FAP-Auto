import 'package:equatable/equatable.dart';
import 'package:fap/features/auth/data/models/auth_response_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthOtpSent extends AuthState {
  final AuthResponseModel response;

  const AuthOtpSent({required this.response});

  @override
  List<Object?> get props => [response];
}

class AuthVerified extends AuthState {
  final AuthResponseModel response;

  const AuthVerified({required this.response});

  @override
  List<Object?> get props => [response];
}

class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}

class AuthLoggedOut extends AuthState {}

