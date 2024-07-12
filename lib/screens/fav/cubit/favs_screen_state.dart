part of 'favs_screen_cubit.dart';

@immutable
sealed class FavsScreenState {}

final class FavsScreenInitial extends FavsScreenState {}


class FavsScreenLoaded extends FavsScreenState {
  String msg;
  List<PaginatedNewsModel> newsModel;
  FavsScreenLoaded({required this.msg, required this.newsModel});
}

class FavsScreenLoading extends FavsScreenState {}

class FavsScreenError extends FavsScreenState {
  String error;
  FavsScreenError({required this.error});
}