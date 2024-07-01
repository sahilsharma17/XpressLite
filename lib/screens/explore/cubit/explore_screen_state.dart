part of 'explore_screen_cubit.dart';

@immutable
abstract class ExploreScreenState {}

class ExploreScreenInitial extends ExploreScreenState {}

class ExploreScreenLoaded extends ExploreScreenState {
  String msg;
  List<SearchModel>? searchedNewsModel;
  ExploreScreenLoaded({required this.msg, this.searchedNewsModel});
}

class ExploreScreenLoading extends ExploreScreenState {}

class ExploreScreenError extends ExploreScreenState {
  String error;
  ExploreScreenError({required this.error});
}
