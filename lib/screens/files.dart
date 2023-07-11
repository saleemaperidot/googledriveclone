import 'dart:developer';

import 'package:drive/controllers/file_folder_controller.dart';
import 'package:drive/controllers/files_controller.dart';
import 'package:drive/screens/displayfiles_screen.dart';
import 'package:drive/screens/nav_screen.dart';
import 'package:drive/services/servises.dart';
import 'package:drive/utilit/utilities.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class Files extends StatelessWidget {
  Files({super.key});
  FilesController filesController = Get.put(FilesController());

  TextEditingController _txtController = TextEditingController();
  Widget modifiedContainer(BuildContext _ctx, String name, int itemCount) {
    return Container(
      width: MediaQuery.of(_ctx).size.width * 0.4,
      height: MediaQuery.of(_ctx).size.width * 0.6,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(10, 10))
      ], borderRadius: BorderRadius.circular(10), color: Colors.grey.shade100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder,
            size: 100,
            color: Colors.orangeAccent,
          ),
          Text(name),
          Text(
            "25 files",
            style: textStyle(10, Colors.grey, FontWeight.w700),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "Recent files",
              style: textStyle(12, Colors.grey, FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            height: 120,
            child: GetX<FilesController>(
                builder: (FilesController filesController) {
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                separatorBuilder: (context, index) => SizedBox(
                  width: 10,
                ),
                itemCount: filesController.recentfilesList.length,
                itemBuilder: (context, index) {
                  final url = filesController.recentfilesList[index].url;
                  final imagename = filesController.recentfilesList[index].name;
                  return Column(
                    children: [
                      filesController.recentfilesList[index].fileType == 'image'
                          ? Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(url)),
                              ))
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: 100,
                                color: Colors.grey.shade200,
                                height: 100,
                                child: Center(
                                  child: Image(
                                      width: 70,
                                      height: 70,
                                      image: AssetImage(
                                          "assets/images/${filesController.recentfilesList[index].fileExtension}.png")),
                                ),
                              ),
                            ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 100,
                        child: Center(
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            imagename,
                            style: textStyle(12, Colors.grey, FontWeight.w500),
                          ),
                        ),
                      )
                    ],
                  );
                },
              );
            }),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
              trailing: Icon(Icons.menu),
              leading: Text(
                "Modified",
                style: textStyle(12, Colors.grey, FontWeight.w600),
              )),
          Expanded(
            child: GetX<FilesController>(
                builder: (FilesController foldersController) {
              return foldersController != null &&
                      foldersController.foldersList != null
                  ? GridView.builder(
                      itemCount: foldersController.foldersList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        String name = foldersController.foldersList[index].name;
                        int itemCount = 0;
                        return InkWell(
                            onTap: () {
                              Get.to(
                                  () => DisplayFilesScreen(
                                      title: name, type: "folder"),
                                  binding: FileBinding("Folders", name, name));
                            },
                            child: modifiedContainer(context, name, itemCount));
                      },
                      scrollDirection: Axis.horizontal,
                    )
                  : CircularProgressIndicator();
            }),
          )
        ],
      ),
      floatingActionButton: SizedBox(
        height: 40,
        width: 30,
        child: FloatingActionButton(
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: Colors.orange.shade900,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  child: Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Container(
                      padding: EdgeInsets.only(left: 15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          child: AlertDialog(
                                            title: Text("Add Folder"),
                                            content: TextFormField(
                                              controller: _txtController,
                                              decoration: InputDecoration(
                                                  hintText: "Untitled document",
                                                  hintStyle: textStyle(
                                                      16,
                                                      Colors.grey,
                                                      FontWeight.w600)),
                                            ),
                                            actions: [
                                              InkWell(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: Text(
                                                  "Cancel",
                                                  style: textStyle(
                                                      12,
                                                      Colors.grey,
                                                      FontWeight.w600),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  firebasecollection
                                                      .doc(FirebaseAuth.instance
                                                          .currentUser!.uid)
                                                      .collection('folders')
                                                      .add({
                                                    "name": _txtController.text,
                                                    "time": DateTime.now()
                                                  });
                                                  Get.offAll(NavScreen());
                                                },
                                                child: Text(
                                                  "Add Folder",
                                                  style: textStyle(
                                                      12,
                                                      Colors.grey,
                                                      FontWeight.w600),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Icon(
                                    EvaIcons.folderAdd,
                                    color: Colors.grey,
                                    size: 32,
                                  ),
                                ),
                                Text("Folder"),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    EvaIcons.upload,
                                    color: Colors.grey,
                                    size: 32,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        FirebaseServices().uploadFolder('');
                                      },
                                      child: Text("Upload"))
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ),
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
