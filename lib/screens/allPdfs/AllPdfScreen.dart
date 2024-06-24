import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpresslite/Widget/Pdf_widget.dart';
import 'package:xpresslite/model/allPdfModel.dart';
import 'package:xpresslite/screens/allPdfs/cubit/allpdfs_cubit.dart';

import '../../helper/app_utilities/method_utils.dart';
import '../../helper/custom_widgets/accessDenied/accessDenied.dart';
import '../../helper/custom_widgets/app_circular_loader.dart';
import 'cubit/allpdfs_state.dart';

class AllPdfScreen extends StatefulWidget {
  String? appBarTitle;
  int? id;

  AllPdfScreen({super.key, this.appBarTitle, this.id});

  @override
  State<AllPdfScreen> createState() => _AllPdfScreenState();
}

class _AllPdfScreenState extends State<AllPdfScreen> {
  late PdfsCubit _cubit;
  List<AllPdfModel>? allPdfs = [];


  @override
  void initState() {
    _cubit = BlocProvider.of<PdfsCubit>(context);
    _cubit.getAllPdfs(widget.id ?? 5);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PdfsCubit, AllPdfState>(
        builder: (BuildContext context, state) {
      if (state is AllPdfLoaded) {
        allPdfs = state.pdfsModel ?? [];
        return body();
      } else if (state is AllPdfInitial) {
        return body();
      } else if (state is AllPdfLoading) {
        return Stack(
          children: [const AppLoaderProgress()],
        );
      } else if (state is AllPdfError) {
        return body();
      }
      return AccessDeniedScreen(
        onPressed: () {
          _cubit.refresh();
        },
      );
    }, listener: (BuildContext context, state) {
      if (state is AllPdfError) {
        if (state.error.isNotEmpty) {
          MethodUtils.toast(state.error);
        }
      } else if (state is AllPdfLoaded) {}
    });
  }

  body() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.appBarTitle.toString().toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 3,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: allPdfs?.length,
              itemBuilder: (context, i) {
                return PdfWidget(pdfData: allPdfs![i],);
              }),
        ),
      ),
    );
  }
}
