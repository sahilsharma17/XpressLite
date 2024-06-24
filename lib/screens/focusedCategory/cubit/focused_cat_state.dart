import '../../../model/focusedCatModel.dart';

abstract class FocusedCategoryState {}

class FocusedCategoryInitial extends FocusedCategoryState {}

class FocusedCategoryLoading extends FocusedCategoryState {}

class FocusedCategoryLoaded extends FocusedCategoryState {
  String msg;

  List<FocusedCategoryModel>? focusedCategory;

  FocusedCategoryLoaded({
    required this.msg,
    this.focusedCategory,
  });
}

class FocusedCategoryError extends FocusedCategoryState {
  String error;

  FocusedCategoryError({required this.error});
}
