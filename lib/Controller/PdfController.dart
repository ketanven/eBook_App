import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfController extends GetxController {
  final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();
  TextEditingController title = TextEditingController();

  get book => null;
}
