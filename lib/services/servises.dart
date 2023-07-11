import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:drive/Models/files_Model.dart';
import 'package:drive/utilit/utilities.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

class FirebaseServices {
  Uuid uuid = Uuid();

  Future<File> compressfile(File file, String filetype) async {
    if (filetype == "image") {
      Directory directory = await getTemporaryDirectory();
      String targetPath = directory.path + "/${uuid.v4().substring(0, 8)}.jpg";
      var result = await FlutterImageCompress.compressAndGetFile(
          file.path, targetPath,
          quality: 75);
      return File(result!.path);
    } else if (filetype == "video") {
      MediaInfo? info = await VideoCompress.compressVideo(file.path,
          quality: VideoQuality.MediumQuality,
          deleteOrigin: false,
          includeAudio: true);
      return File(info!.path!);
    } else {
      return file;
    }
  }

  //delete file
  deleteFile(FilesModel file) async {
    await firebasecollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('files')
        .doc(file.id)
        .delete();
  }

//
  Downloadfile(FilesModel file) async {
    try {
      final downloadFile = await downloadpath();
      final path = "$downloadFile/${file.name.replaceAll(" ", "")}";
      var status = await Permission.storage.status;
      if (status.isGranted) {
        await Permission.storage.request();
      }
      await Dio().download(file.url, path);
      print("success");
    } catch (e) {
      print("error");
    }
  }

  uploadFolder(String foldername) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      for (File file in files) {
        String? filetype = lookupMimeType(file.path);
        print(filetype!.split('/'));
        List<String> filetypename = filetype.split('/');
        print(filetypename[0]);
        // String = filetypename[0];
        // String fileExtension = filetypename[1];
        String filename = file.path.split('/').last;
        String fileExtension = filename.split('.').last;
        File compressedFile = await compressfile(file, filetypename[0]);
        print("compressed file${compressedFile}");
        //get length of file
        int length = await firebasecollection
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('files')
            .get()
            .then((value) => value.docs.length);
        print("length${length}");
        //uploading files to firebase storage
        UploadTask uploadTask = FirebaseStorage.instance
            .ref()
            .child('files')
            .child('Files${length}')
            .putFile(compressedFile);

        print("Uploadtask${uploadTask}");
        TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
        print("snapshort${snapshot}");
        String fileUrl = await snapshot.ref.getDownloadURL();

        print("snap short and file url${snapshot} ////${fileUrl}");
        //saving data in firebase document
        firebasecollection
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('files')
            .add({
          "filename": filename,
          "fileUrl": fileUrl,
          "filetype": filetypename[0],
          "fileExtension": fileExtension,
          "date": DateTime.now(),
          "folder": foldername,
          "size":
              (compressedFile.readAsBytesSync().lengthInBytes / 1024).round(),
        });
      }
      if (foldername == "") {
        Get.back();
      } else {
        print("cancel");
      }
    }
  }

  Future<String?> downloadpath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      }
    } catch (e) {
      print("cannot download");
    }
    return directory?.path;
  }
}
