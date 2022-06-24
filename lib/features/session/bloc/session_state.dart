part of 'session_bloc.dart';

@freezed
class SessionState with _$SessionState {
  const factory SessionState({
    required Session session,
    required bool active,
  }) = _SessionState;
}
