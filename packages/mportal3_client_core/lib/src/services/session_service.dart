import '../models.dart';

abstract class SessionService {
  Future<String?> get sessionId;
  Future<Session> get session;
}
