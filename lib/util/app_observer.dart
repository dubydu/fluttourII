import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppObserver extends BlocObserver {
  const AppObserver();

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    if (kDebugMode) {
      print('onCreate -- bloc: ${bloc.runtimeType}');
    }
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      print('onEvent -- bloc: ${bloc.runtimeType}, event: $event');
    }
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      print('onChange -- bloc: ${bloc.runtimeType}, change: $change');
    }
  }

  @override
  void onTransition(
      Bloc<dynamic, dynamic> bloc,
      Transition<dynamic, dynamic> transition,
      ) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      print('onTransition -- bloc: ${bloc.runtimeType}, transition: $transition');
    }
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      print('onError -- bloc: ${bloc.runtimeType}, error: $error');
    }
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    if (kDebugMode) {
      print('onClose -- bloc: ${bloc.runtimeType}');
    }
  }
}