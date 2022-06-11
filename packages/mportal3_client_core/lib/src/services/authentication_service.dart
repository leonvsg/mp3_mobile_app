import '../models.dart';

abstract class AuthenticationService {
  Future<Session?> logIn({
    required String login,
    required String password,
  });
  Future<void> logOut();
}