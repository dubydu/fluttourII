import 'package:fluttour/data/error_response.dart';
import 'package:fluttour/domain/model/failure.dart';

class BaseTranslator {
  static Failure noData() {
    return Failure(message: const NoDataErrorResponse().message);
  }

  static Failure noInternet() {
    return Failure(message: const NoConnectionErrorResponse().message);
  }

  static Failure toFailure(String message) {
    return Failure(message: message);
  }
}
