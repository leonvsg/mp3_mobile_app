import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mportal3_core/mportal3_core.dart';

part 'session_event.dart';
part 'session_state.dart';
part 'session_bloc.freezed.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final SessionService sessionService;

  SessionBloc({
    required Session session,
    required this.sessionService,
  }) : super(SessionState(
          session: session,
          active: true,
        )) {
    on<_Set>(_onSet);
    on<_Invalidate>(_onInvalidate);
    on<_Update>(_onUpdate);
  }

  FutureOr<void> _onSet(_Set event, Emitter<SessionState> emit) {
    emit(state.copyWith(session: event.session));
  }

  FutureOr<void> _onInvalidate(_, Emitter<SessionState> emit) {
    emit(state.copyWith(active: false));
  }

  FutureOr<void> _onUpdate(_, Emitter<SessionState> emit) async {
    final session = await sessionService.session;
    emit(state.copyWith(session: session));
  }
}
