import 'package:mp3_mobile_app/domain/models.dart';

abstract class SessionDao {
  Future<Session> getSession(String sessionId);
  Future<void> saveOrUpdateSession(Session session);
  Future<void> deleteSession(String sessionId);
  Future<void> deleteAllSessions();
}
