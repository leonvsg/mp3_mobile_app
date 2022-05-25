import 'package:mp3_mobile_app/domain/models/session.dart';

abstract class AuthenticationRepository {
  Future<Session?> logIn({
    required String login,
    required String password,
  });
  Future<void> logOut();
}