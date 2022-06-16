import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttour/domain/model/fluttour_doctor.dart';
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
      emit(state.copyWith(fluttourDoctor: response));
    });
  }
}

class HomeState extends Equatable {
  const HomeState({required this.fluttourDoctor});
  final FluttourDoctor? fluttourDoctor;

  HomeState copyWith({
    final FluttourDoctor? fluttourDoctor,
  }) {
    return HomeState(
      fluttourDoctor: fluttourDoctor ?? this.fluttourDoctor,
    );
  }

  @override
  List<Object?> get props => [fluttourDoctor];
}

class HomeInitialState extends HomeState {
  const HomeInitialState(): super(fluttourDoctor: null);
}