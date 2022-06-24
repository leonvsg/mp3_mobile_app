import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mp3_mobile_app/common/validation/validator.dart';
import 'package:mportal3_core/mportal3_core.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';
part 'authentication_bloc.freezed.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final Validator validator;
  final AuthenticationService authenticationService;

  AuthenticationBloc({
    required this.validator,
    required this.authenticationService,
  }) : super(const _Initial()) {
    on<_Login>(_onLogin);
    on<_Logout>(_onLogout);
  }

  FutureOr<void>  _onLogin(
    _Login event,
    Emitter<AuthenticationState> emit,
  ) async {
    final login = event.login;
    final password = event.password;
    if (!validator.validateLogin(login)) {
      //TODO: translate
      emit(const _Error(
        errorField: Field.login,
        errorMessage: 'Unexpected login format',
      ));
    } else if (!validator.validatePassword(password)) {
      //TODO: translate
      emit(const _Error(
        errorField: Field.password,
        errorMessage: 'Unexpected password format',
      ));
    } else {
      final session = await authenticationService.logIn(
        login: login,
        password: password,
      );
      emit(_SuccessLogin(session: session));
    }
  }

  FutureOr<void> _onLogout(
    _,
    Emitter<AuthenticationState> emit,
  ) {
    authenticationService.logOut();
    emit(const _SuccessLogout());
  }
}
