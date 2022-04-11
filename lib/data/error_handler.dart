import 'package:mp3_mobile_app/data/data_sources/rbs_mp3_api/dto.dart';

abstract class ErrorHandler {
  void handleError(ErrorResponse error);
}