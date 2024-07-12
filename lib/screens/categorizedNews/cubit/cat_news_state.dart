import '../../../model/PaginatedNewsModel.dart';

abstract class CatNewsScreenState {}

class CatNewsScreenInitial extends CatNewsScreenState {}

class CatNewsScreenLoading extends CatNewsScreenState {}

class CatNewsScreenLoaded extends CatNewsScreenState {
  String msg;

  List<PaginatedNewsModel>? newsByCategory;

  CatNewsScreenLoaded({
    required this.msg,
    this.newsByCategory,
  });
}

class CatNewsScreenError extends CatNewsScreenState {
  String error;

  CatNewsScreenError({required this.error});
}
