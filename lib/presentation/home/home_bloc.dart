import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttour/domain/model/fluttour.dart';
import 'package:fluttour/domain/usecase/home/home_usecase.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc({
    required this.useCase
  }) : super(const HomeInitialState());

  final HomeUseCase useCase;

  Future<void> getFluttourDoctor() async {
    final response = await useCase.getFluttourDoctor();
    response.fold((error) {
      log('=============== $error');
    }, (response) {
      emit(state.copyWith(fluttour: response));
    });
  }
}

class HomeState extends Equatable {
  const HomeState({required this.fluttour});
  final Fluttour? fluttour;

  HomeState copyWith({
    final Fluttour? fluttour,
  }) {
    return HomeState(
      fluttour: fluttour ?? this.fluttour,
    );
  }

  @override
  List<Object?> get props => [fluttour];
}

class HomeInitialState extends HomeState {
  const HomeInitialState(): super(fluttour: null);
}