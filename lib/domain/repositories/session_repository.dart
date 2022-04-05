import 'package:mp3_mobile_app/domain/entities/session.dart';

abstract class SessionRepository {
  Future<String?> get sessionId;
  Future<Session?> get session;
}