import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttour/domain/model/brand.dart';
import 'package:fluttour/domain/model/dish.dart';
import 'package:fluttour/domain/usecase/sliver/sliver_usecase_type.dart';
import 'package:fluttour/util/util.dart';

class SliverBloc extends Cubit<SliverState> {
  SliverBloc({required this.useCase}) : super(const SliverInitialState());

  final SliverUseCaseType useCase;

  Future<void> fetchBrand() async {
    final response = await Future.wait([
      useCase.getBrand(id: 1),
      useCase.getRecommendDishes(id: 1),
    ]);
    // Handle recommend dishes response
    response[1].fold((error) {
      log('=============== $error');
    }, (response) {
      response as List<Dish>;
      emit(state.copyWith(recommendDishes: response));
    });
    // Handle brand response
    response[0].fold((error) {
      log('=============== $error');
    }, (response) {
      response as Tuple2<Brand, List<DishCategory>>;
      // Emit brand and dish categories
      emit(state.copyWith(
          brand: response.value1,
          categories: response.value2,
          categoryGlobalKeys:
              response.value2.map((_) => GlobalKey()).toList()));
    });
  }

  void onCategoryChanged({required bool isOnTop}) {
    if (isOnTop) {
      if (!state.isCategoryWidgetOnTop) {
        moveCategoryOnTop();
      }
    } else {
      if (state.isCategoryWidgetOnTop) {
        dontMoveCategoryOnTop();
      }
    }
  }

  void moveCategoryOnTop() {
    emit(state.copyWith(isCategoryWidgetOnTop: true));
  }

  void dontMoveCategoryOnTop() {
    emit(state.copyWith(isCategoryWidgetOnTop: false));
  }

  void onCategorySelected({required DishCategory dishCategory}) {
    final dishCategories = List<DishCategory>.from(state.categories ?? [])
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

  int onSectionChanged(bool isDeviceHasNotch) {
    final sectionPositions = state.sectionPositions;
    final sectionWidgetHeight =
        state.extentHeight(isDeviceHasNotch: isDeviceHasNotch);
    final sectionIndex = sectionPositions.indexWhere((offset) =>
        (((offset - sectionWidgetHeight) < 0) &&
            ((offset - sectionWidgetHeight) > -sectionWidgetHeight)));
    if (sectionIndex != -1) {
      onCategorySelected(dishCategory: state.categories![sectionIndex]);
    }
    return sectionIndex;
  }

  void dispose() {
    emit(const SliverInitialState());
  }
}

class SliverState extends Equatable {
  const SliverState(
      {required this.brand,
      required this.categories,
      required this.isCategoryWidgetOnTop,
      required this.categoryGlobalKeys,
      required this.recommendDishes});

  final Brand? brand;
  final List<DishCategory>? categories;
  final List<Dish>? recommendDishes;
  final List<GlobalKey>? categoryGlobalKeys;
  final bool isCategoryWidgetOnTop;

  SliverState copyWith(
      {Brand? brand,
      List<DishCategory>? categories,
      List<GlobalKey>? categoryGlobalKeys,
      bool? isCategoryWidgetOnTop,
      List<Dish>? recommendDishes}) {
    return SliverState(
        brand: brand ?? this.brand,
        categories: categories ?? this.categories,
        categoryGlobalKeys: categoryGlobalKeys ?? this.categoryGlobalKeys,
        isCategoryWidgetOnTop:
            isCategoryWidgetOnTop ?? this.isCategoryWidgetOnTop,
        recommendDishes: recommendDishes ?? this.recommendDishes);
  }

  List<double> get sectionPositions {
    return (categoryGlobalKeys ?? [])
        .map((key) => AppDevice.detectWidgetPosition(globalKey: key).dy)
        .toList();
  }

  double extentHeight({required bool isDeviceHasNotch}) {
    return isDeviceHasNotch ? 90 : 80;
  }

  @override
  List<Object?> get props => [
        brand,
        categories,
        categoryGlobalKeys,
        isCategoryWidgetOnTop,
        recommendDishes
      ];
}

class SliverInitialState extends SliverState {
  const SliverInitialState()
      : super(
            brand: null,
            categories: null,
            categoryGlobalKeys: null,
            isCategoryWidgetOnTop: false,
            recommendDishes: null);
}
