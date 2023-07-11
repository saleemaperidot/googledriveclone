import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:drive/Models/files_Model.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:path_provider/path_provider.dart';

class ShowPdf extends StatefulWidget {
  ShowPdf({super.key, required this.files});
  FilesModel files;

  @override
  State<ShowPdf> createState() => _ShowPdfState();
}

class _ShowPdfState extends State<ShowPdf> {
  late File pdfFile;
  bool initilize = false;
  loadPdfFile(FilesModel file) async {
    final response = await http.get(Uri.parse(file.url));
    final bytes = response.bodyBytes;
    return storeFile(file, bytes);
  }

  storeFile(FilesModel file, List<int> bytes) async {
    final dir = await getApplicationDocumentsDirectory();
    final filename = File("${dir.path}/${file.name}");
    await filename.writeAsBytes(bytes, flush: true);
    return filename;
  }

  initilizePDF() async {
    pdfFile = await loadPdfFile(widget.files);

    initilize = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initilizePDF();
  }

  @override
  Widget build(BuildContext context) {
    print(pdfFile.path);
    return Scaffold(
      body: initilize
          ?
          // SfPdfViewer.network(
          //     "https://firebasestorage.googleapis.com/v0/b/driveclone-88c97.appspot.com/o/files%2FFiles6?alt=media&token=09db36e5-edd2-44f2-845a-db18902ed407")
          PDFView(
              filePath: pdfFile.path,
              fitEachPage: false,
            )
          : CircularProgressIndicator(),
    );
  }
}
