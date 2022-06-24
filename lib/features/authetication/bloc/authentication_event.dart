part of 'authentication_bloc.dart';

@freezed
class AuthenticationEvent with _$AuthenticationEvent {
  const factory AuthenticationEvent.login({
    required String login,
    required String password,
  }) = _Login;
  const factory AuthenticationEvent.logout() = _Logout;
}
