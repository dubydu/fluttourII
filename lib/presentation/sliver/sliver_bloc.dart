import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttour/domain/model/brand.dart';
import 'package:fluttour/domain/usecase/sliver/sliver_usecase.dart';

class SliverBloc extends Cubit<SliverState> {
  SliverBloc({required this.useCase}) : super(SliverInitialState());

  final SliverUseCase useCase;

  Future<void> fetchBrand() async {
    final response = await useCase.getBrand(id: 1);
    response.fold((error) {
      log('=============== $error');
    }, (response) {
      emit(state.copyWith(brand: response));
    });
  }

  void onCategoryWidgetChanged({required bool isOnTop}) {
    emit(state.copyWith(isCategoryWidgetOnTop: isOnTop));
  }
}

class SliverState extends Equatable {
  const SliverState({
    required this.brand,
    required this.isCategoryWidgetOnTop
  });

  final Brand? brand;
  final bool isCategoryWidgetOnTop;

  SliverState copyWith({
    Brand? brand,
    bool? isCategoryWidgetOnTop,
  }) {
    return SliverState(
      brand: brand ?? this.brand,
      isCategoryWidgetOnTop: isCategoryWidgetOnTop ?? this.isCategoryWidgetOnTop,
    );
  }

  @override
  List<Object?> get props => [brand, isCategoryWidgetOnTop];
}

class SliverInitialState extends SliverState {
  const SliverInitialState() : super(brand: null, isCategoryWidgetOnTop: false);
}