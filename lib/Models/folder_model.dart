import 'package:cloud_firestore/cloud_firestore.dart';

class FolderModel {
  late String id;
  late String name;
  late Timestamp date;
  late int noOfItems;

  FolderModel(this.id, this.name, this.date, this.noOfItems);

  FolderModel.fromdocumentSnapShot(QueryDocumentSnapshot<Object?> doc) {
    id = doc.id;
    name = doc['name'];
    date = doc['time'];
  }
}
