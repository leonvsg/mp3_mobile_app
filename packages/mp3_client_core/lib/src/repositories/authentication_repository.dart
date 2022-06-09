import 'package:mp3_client_core/mp3_client_core.dart';

abstract class AuthenticationRepository {
  Future<Session?> logIn({
    required String login,
    required String password,
  });
  Future<void> logOut();
}