import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpresslite/model/allPdfModel.dart';
import 'package:xpresslite/network_configs/networkRequest.dart';

import '../../../helper/app_utilities/method_utils.dart';
import '../../../helper/constant/appMessages.dart';
import '../../../model/reposeCallBack.dart';
import '../repo/allpdfs_repo.dart';
import 'allpdfs_state.dart';

class PdfsCubit extends Cubit<AllPdfState> {
  PdfsCubit() : super(AllPdfInitial());

  AllPdfsRepo allPdfRepo = AllPdfsRepo(networkRequest: NetworkRequest());
  late ApiResponse<List<AllPdfModel>> pdfModel;

  void getAllPdfs(
    int? DirId,
    int? CatId,
  ) async {
    try {
      emit(AllPdfLoading());
      if (await MethodUtils.isInternetPresent()) {
        if (DirId != null) {
          pdfModel = await allPdfRepo.getAllPdfs(directorId: DirId);
        } else {
          pdfModel = await allPdfRepo.getAllPdfs(categoryId: CatId);
        }
        if (pdfModel.isSuccess) {
          emit(AllPdfLoaded(msg: "Got pdfs", pdfsModel: pdfModel.resObject));
        } else {
          emit(AllPdfError(error: pdfModel.errorCause));
        }
      } else {
        emit(AllPdfError(error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      emit(AllPdfError(error: e.toString()));
    }
  }

  void refresh() {
    emit(AllPdfInitial());
  }
}
