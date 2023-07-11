import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive/utilit/utilities.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class StorageController extends GetxController {
  RxDouble size = 0.0.obs;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  void onInit() {
    super.onInit();
    getstorage();
  }

  void getstorage() {
    size.bindStream(firebasecollection
        .doc(uid)
        .collection('files')
        .snapshots()
        .map((QuerySnapshot query) {
      double size = 0;
      query.docs.forEach((element) {
        size = size + extractSize(element);
      });
      print("size${size}");
      return size;
    }));
  }

  int extractSize(QueryDocumentSnapshot<Object?> element) {
    print(element['size'].toString());
    return element['size'];
  }
}
