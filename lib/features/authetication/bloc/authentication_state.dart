part of 'authentication_bloc.dart';

enum Field { login, password }

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.initial() = _Initial;
  const factory AuthenticationState.error({
    required Field errorField,
    String? errorMessage,
  }) = _Error;
  const factory AuthenticationState.successlogin({required Session session}) =
      _SuccessLogin;
  const factory AuthenticationState.successLogout() = _SuccessLogout;
}
