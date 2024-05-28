part of 'getCategoryWiseNewsDetails_cubit.dart';

abstract class GetCategoryWiseNewsDetailsState {}

class GetCategoryWiseNewsDetailsInitial extends GetCategoryWiseNewsDetailsState {}

class GetCategoryWiseNewsDetailsLoaded extends GetCategoryWiseNewsDetailsState {
  String msg;
  List<CategorisedNewsDetailsModel>? newsDetailsModel;
  GetCategoryWiseNewsDetailsLoaded({required this.msg, this.newsDetailsModel});
}

class GetCategoryWiseNewsDetailsLoading extends GetCategoryWiseNewsDetailsState {}

class GetCategoryWiseNewsDetailsError extends GetCategoryWiseNewsDetailsState {
  String error;
  GetCategoryWiseNewsDetailsError({required this.error});
}
