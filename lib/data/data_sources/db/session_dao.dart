import 'package:mp3_client_core/mp3_client_core.dart';

abstract class SessionDao {
  Future<Session> getSession(String sessionId);
  Future<void> saveOrUpdateSession(Session session);
  Future<void> deleteSession(String sessionId);
  Future<void> deleteAllSessions();
  Future<void> clearOldSessions(DateTime before);
}
