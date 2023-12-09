part of 'auth_bloc.dart';

@immutable
class AuthState {}

final class AuthInitial extends AuthState {}

class SignInWithGoogleState extends AuthState {
  final User? result;
  final bool isLoading;

  SignInWithGoogleState({
    required this.result,
    required this.isLoading,
  });
}

class CheckIsUserRegisteredState extends AuthState {
  final bool isRegistered;
  final bool isLoading;

  CheckIsUserRegisteredState({
    required this.isRegistered,
    required this.isLoading,
  });
}

class CheckIsUserSignedInWithGoogleState extends AuthState {
  final bool isSignedIn;

  /// Success or not
  final bool isLoading;

  /// IF loading
  final String? errorMessage;

  /// if isSignedIn == false -> Error Message != null

  CheckIsUserSignedInWithGoogleState({
    required this.isSignedIn,
    required this.isLoading,
    this.errorMessage,
  });
}