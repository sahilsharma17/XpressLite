part of 'all_ratings_cubit.dart';

@immutable
sealed class AllRatingsState {}

class AllRatingsInitial extends AllRatingsState {}

class AllRatingsLoaded extends AllRatingsState {
  String msg;
  List<AllRatingModel>? allRaters;

  AllRatingsLoaded({required this.msg, this.allRaters});
}

class AllRatingsLoading extends AllRatingsState {}

class AllRatingsError extends AllRatingsState {
  String error;

  AllRatingsError({required this.error});
}
