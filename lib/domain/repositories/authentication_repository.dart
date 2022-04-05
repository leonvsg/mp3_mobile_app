import 'package:mp3_mobile_app/domain/entities/session.dart';

abstract class AuthenticationRepository {
  Future<Session?> logIn({
    required String login,
    required String password,
  });
  Future<void> logOut();
}