import 'package:flutter_bloc/flutter_bloc.dart';

class SliverBloc extends Cubit<SliverState> {
  SliverBloc() : super(SliverInitialState());

  void onCategoryWidgetChanged({required bool pinned}) {
    emit(state.copyWith(isCategoryWidgetOnTop: pinned));
  }
}

class SliverState {
  SliverState({required this.isCategoryWidgetOnTop});
  bool isCategoryWidgetOnTop;

  SliverState copyWith({
    bool? isCategoryWidgetOnTop,
  }) {
    return SliverState(
      isCategoryWidgetOnTop: isCategoryWidgetOnTop ?? this.isCategoryWidgetOnTop,
    );
  }
}

class SliverInitialState extends SliverState {
  SliverInitialState() : super(isCategoryWidgetOnTop: false);
}