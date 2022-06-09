import 'package:mp3_client_core/mp3_client_core.dart';

abstract class SessionRepository {
  Future<String?> get sessionId;
  Future<Session> get session;
}
