import '../../../../model/directorsCatModel.dart';

abstract class DirectorsCategoryState {}

class DirectorsCategoryInitial extends DirectorsCategoryState {}

class DirectorsCategoryLoading extends DirectorsCategoryState {}

class DirectorsCategoryLoaded extends DirectorsCategoryState {
  String msg;
  List<DirectorCatModel>? directorCatModel;

  DirectorsCategoryLoaded({
    required this.msg,
    this.directorCatModel,
  });
}

class DirectorsCategoryError extends DirectorsCategoryState {
  String error;
  DirectorsCategoryError({required this.error});
}
