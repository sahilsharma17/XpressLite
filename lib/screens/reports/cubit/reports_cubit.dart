import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:xpresslite/model/reposeCallBack.dart';
import 'package:xpresslite/network_configs/networkRequest.dart';
import 'package:xpresslite/screens/reports/repo/reports_repo.dart';

import '../../../helper/app_utilities/method_utils.dart';
import '../../../helper/constant/appMessages.dart';
import '../../../model/reportModel.dart';

part 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit() : super(ReportsInitial());

  ReportsRepo reportsRepo = ReportsRepo(networkRequest: NetworkRequest());

  late ApiResponse<List<ReportModel>> reports;

  Future<void> getCeoReports(String? month, String? date) async {
    try {
      emit(ReportsLoading());
      if (await MethodUtils.isInternetPresent()) {
        reports = await reportsRepo.ceoReports(month: month, date: date);
        if (reports.isSuccess) {
          emit(ReportsLoaded(
              msg: 'Got reports', reportModel: reports.resObject ?? []));
        } else {
          emit(ReportsError(error: reports.errorCause));
        }
      } else {
        emit(ReportsError(error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      emit(ReportsError(error: e.toString()));
    }
  }

  Future<void> getOtherReports(String? month, String? date) async {
    try {
      emit(ReportsLoading());
      if (await MethodUtils.isInternetPresent()) {
        reports = await reportsRepo.otherReports(month: month, date: date);
        if (reports.isSuccess) {
          emit(ReportsLoaded(
              msg: 'Got reports', reportModel: reports.resObject ?? []));
        } else {
          emit(ReportsError(error: reports.errorCause));
        }
      } else {
        emit(ReportsError(error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      emit(ReportsError(error: e.toString()));
    }
  }

  void refresh() {
    emit(ReportsInitial());
  }
}
