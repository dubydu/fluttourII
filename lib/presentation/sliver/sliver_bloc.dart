import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttour/domain/model/brand.dart';
import 'package:fluttour/domain/model/dish.dart';
import 'package:fluttour/domain/usecase/sliver/sliver_usecase_type.dart';

class SliverBloc extends Cubit<SliverState> {
  SliverBloc({required this.useCase}) : super(const SliverInitialState());

  final SliverUseCaseType useCase;

  Future<void> fetchBrand() async {
    final response = await useCase.getBrand(id: 1);
    response.fold((error) {
      log('=============== $error');
    }, (response) {
      // Emit brand and dish categories
      emit(state.copyWith(brand: response.value1, categories: response.value2));
    });
  }

  void onCategoryWidgetChanged({required bool isOnTop}) {
    emit(state.copyWith(isCategoryWidgetOnTop: isOnTop));
  }

  void onCategorySelected({required DishCategory dishCategory}) {
    final dishCategories = List<DishCategory>
        .from(state.categories ?? [])
        .map((category) => category.copyWith(isSelected: false))
        .toList()
        .map((category) {
      if (category.id == dishCategory.id) {
        return category.copyWith(isSelected: true);
      }
      return category;
    }).toList();
    // Emit new dish categories
    emit(state.copyWith(categories: dishCategories));
  }
}

class SliverState extends Equatable {
  const SliverState({
    required this.brand,
    required this.categories,
    required this.isCategoryWidgetOnTop
  });

  final Brand? brand;
  final List<DishCategory>? categories;
  final bool isCategoryWidgetOnTop;

  SliverState copyWith({
    Brand? brand,
    List<DishCategory>? categories,
    bool? isCategoryWidgetOnTop,
  }) {
    return SliverState(
      brand: brand ?? this.brand,
      categories: categories ?? this.categories,
      isCategoryWidgetOnTop: isCategoryWidgetOnTop ?? this.isCategoryWidgetOnTop,
    );
  }

  @override
  List<Object?> get props => [brand, categories, isCategoryWidgetOnTop];
}

class SliverInitialState extends SliverState {
  const SliverInitialState()
      : super(brand: null, categories: null, isCategoryWidgetOnTop: false);
}