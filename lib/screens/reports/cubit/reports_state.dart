part of 'reports_cubit.dart';

@immutable
abstract class ReportsState {}

class ReportsInitial extends ReportsState {}

class ReportsLoaded extends ReportsState {
  String msg;
  List<ReportModel>? reportModel;
  ReportsLoaded({required this.msg, required this.reportModel});
}

class ReportsLoading extends ReportsState {}

class ReportsError extends ReportsState {
  String error;
  ReportsError({required this.error});
}
