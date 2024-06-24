
import '../../../model/allPdfModel.dart';

abstract class AllPdfState {}

class AllPdfInitial extends AllPdfState {}

class AllPdfLoaded extends AllPdfState {
  String msg;
  List<AllPdfModel>? pdfsModel;
  AllPdfLoaded({required this.msg, required this.pdfsModel});
}

class AllPdfLoading extends AllPdfState {}

class AllPdfError extends AllPdfState {
  String error;
  AllPdfError({required this.error});
}