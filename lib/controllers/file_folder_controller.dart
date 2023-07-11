import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive/Models/files_Model.dart';
import 'package:drive/utilit/utilities.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FilesFolderController extends GetxController {
  final String type;
  final String foldername;
  final String filename;
  FilesFolderController(this.filename, this.type, this.foldername);

  String uid = FirebaseAuth.instance.currentUser!.uid;
  RxList<FilesModel> filelist = <FilesModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    if (type == "files") {
      filelist.bindStream(firebasecollection
          .doc(uid)
          .collection('files')
          .where('filetype', isEqualTo: filename)
          .snapshots()
          .map((QuerySnapshot query) {
        List<FilesModel> tmpfile = [];
        query.docs.forEach((element) {
          tmpfile.add(FilesModel.fromQuerySnapShort(element));
        });
        return tmpfile;
      }));
    } else {
      filelist.bindStream(firebasecollection
          .doc(uid)
          .collection('files')
          .where('folder', isEqualTo: foldername)
          .snapshots()
          .map((QuerySnapshot query) {
        List<FilesModel> tmpfile = [];
        query.docs.forEach((element) {
          tmpfile.add(FilesModel.fromQuerySnapShort(element));
        });
        return tmpfile;
      }));
    }
  }
}

class FileBinding implements Bindings {
  final String type;
  final String foldername;
  final String filename;
  FileBinding(this.type, this.foldername, this.filename);
  @override
  void dependencies() {
    Get.lazyPut<FilesFolderController>(
        () => FilesFolderController(filename, type, foldername));
  }
}
