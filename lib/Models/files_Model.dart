import 'package:cloud_firestore/cloud_firestore.dart';

class FilesModel {
  late String id;
  late String url;
  late String name;
  late Timestamp? dateUploaded;
  late String fileType;
  late String fileExtension;
  late String foldername;
  late int size;

  FilesModel(this.id, this.url, this.name, this.fileType, this.fileExtension,
      this.foldername, this.size, this.dateUploaded);
  FilesModel.fromQuerySnapShort(QueryDocumentSnapshot<Object?> query) {
    id = query.id;
    name = query['filename'];
    //dateUploaded=query['date'];
    fileExtension = query['fileExtension'];
    url = query['fileUrl'];
    dateUploaded = query['date'];
    fileType = query['filetype'];
    foldername = query['folder'];
    size = query['size'];
  }
}
