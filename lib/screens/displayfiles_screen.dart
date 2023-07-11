import 'package:drive/controllers/file_folder_controller.dart';
import 'package:drive/controllers/files_controller.dart';
import 'package:drive/screens/view_file.dart';
import 'package:drive/services/servises.dart';
import 'package:drive/utilit/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class DisplayFilesScreen extends StatelessWidget {
  DisplayFilesScreen({super.key, required this.title, required this.type});
  final String title;
  final String type;

  @override
  Widget build(BuildContext context) {
    FilesFolderController filesFolderController =
        Get.find<FilesFolderController>();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text(
          title,
          style: textStyle(20, Colors.grey, FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Obx(
            () => GridView.builder(
              itemCount: filesFolderController.filelist.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => Get.to(() => ViewFileScreen(
                              files: filesFolderController.filelist[index],
                            )),
                        child: Container(
                            width: 190,
                            height: 150,
                            child: filesFolderController
                                        .filelist[index].fileType ==
                                    "image"
                                ? Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(filesFolderController
                                        .filelist[index].url))
                                : Container(
                                    child: Center(
                                        child: Image(
                                            image: AssetImage(
                                                "assets/images/${filesFolderController.filelist[index].fileExtension}.png"))),
                                  )),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(filesFolderController.filelist[index].name),
                            InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    shape: BeveledRectangleBorder(
                                        borderRadius: BorderRadius.circular(2)),
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        height: 130,
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    filesFolderController
                                                        .filelist[index].name,
                                                    style: textStyle(
                                                        20,
                                                        Colors.black,
                                                        FontWeight.w300)),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Divider(
                                                  height: 2,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: 30, right: 30),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      ElevatedButton.icon(
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStatePropertyAll(
                                                                    Colors
                                                                        .orange)),
                                                        label: Text("Download"),
                                                        onPressed: () {
                                                          FirebaseServices()
                                                              .Downloadfile(
                                                                  filesFolderController
                                                                          .filelist[
                                                                      index]);
                                                          Get.back();
                                                        },
                                                        icon: Icon(
                                                            Icons.download),
                                                      ),
                                                      OutlinedButton.icon(
                                                        onPressed: () {
                                                          FirebaseServices().deleteFile(
                                                              filesFolderController
                                                                      .filelist[
                                                                  index]);
                                                          Get.back();
                                                        },
                                                        icon: Icon(
                                                            color:
                                                                Colors.orange,
                                                            Icons.delete),
                                                        label: Text(
                                                          "Remove",
                                                          style: textStyle(
                                                              20,
                                                              Colors.orange,
                                                              FontWeight.w400),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ]),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Icon(Icons.more_vert)),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
        onPressed: () {
          type == "folder"
              ? FirebaseServices().uploadFolder(title)
              : FirebaseServices().uploadFolder("not defined");
        },
      ),
    );
  }
}
