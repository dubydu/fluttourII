import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class CodeFailure extends Failure {
  final int code;

  const CodeFailure(this.code, String message) : super(message);
}

class NoConnection extends Failure {
  const NoConnection() : super('No connection!');
}

class NoAuthenticationFailure extends Failure {
  const NoAuthenticationFailure() : super('Please sign in');
}