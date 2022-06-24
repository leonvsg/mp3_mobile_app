part of 'session_bloc.dart';

@freezed
class SessionEvent with _$SessionEvent {
  const factory SessionEvent.set({required Session session}) = _Set;
  const factory SessionEvent.invalidate() = _Invalidate;
  const factory SessionEvent.update() = _Update;
}
