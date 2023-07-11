import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive/Models/files_Model.dart';
import 'package:drive/Models/folder_model.dart';
import 'package:drive/utilit/utilities.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FilesController extends GetxController {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  RxList<FolderModel> foldersList = <FolderModel>[].obs;

  RxList<FilesModel> recentfilesList = <FilesModel>[].obs;
  @override
  void onInit() {
    recentfilesList.bindStream(firebasecollection
        .doc(uid)
        .collection('files')
        .orderBy('date')
        .snapshots()
        .map((query) {
      List<FilesModel> folders = [];
      query.docs.forEach((element) {
        FilesModel folder = FilesModel.fromQuerySnapShort(element);
        folders.add(folder);
      });
      return folders;
    }));

    foldersList.bindStream(firebasecollection
        .doc(uid)
        .collection('folders')
        .orderBy('time')
        .snapshots()
        .map((QuerySnapshot query) {
      List<FolderModel> folders = [];
      query.docs.forEach((element) {
        FolderModel folder = FolderModel.fromdocumentSnapShot(element);
        folders.add(folder);
      });
      return folders;
    }));
  }
}
