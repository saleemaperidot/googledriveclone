import 'package:drive/controllers/storage_controller.dart';
import 'package:drive/utilit/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class StorageWidget extends StatelessWidget {
  const StorageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    StorageController storagecontroller = Get.put(StorageController());
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.03),
              offset: Offset(10, 10),
              blurRadius: 10,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              offset: Offset(-10, 10),
              blurRadius: 10,
            ),
          ]),
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5), blurRadius: 10)
                  ]),
              child: Container(
                padding: EdgeInsets.all(35),
                child: ListTile(
                  title: Text(
                    "${((storagecontroller.size.value / 1000000) * 100).round().toString()}%",
                    style: textStyle(20, Colors.black, FontWeight.bold),
                  ),
                  subtitle: Text("used"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150,
                    height: 400,
                    child: ListTile(
                      style: ListTileStyle.list,
                      isThreeLine: true,
                      leading: Icon(
                        Icons.square,
                        color: Colors.orange,
                      ),
                      title: Text("used"),
                      subtitle: Text(
                          getstorage(storagecontroller.size.value.toInt())),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 150,
                    height: 400,
                    child: ListTile(
                      isThreeLine: true,
                      leading: Icon(
                        Icons.square,
                        color: Colors.grey,
                      ),
                      title: Text("free"),
                      subtitle: Text(" 1 GB"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String getstorage(int size) {
  if (size < 1000) {
    return "$size KB";
  } else if (size < 1000000) {
    double sizet = (size * 0.001).roundToDouble();
    return "$sizet MB ";
  } else {
    double sizegb = (size * 0.001).roundToDouble();
    return "$sizegb GB ";
  }
}
