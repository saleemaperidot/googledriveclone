import 'package:drive/Models/files_Model.dart';
import 'package:drive/screens/show_video.dart';
import 'package:drive/services/servises.dart';
import 'package:drive/utilit/utilities.dart';
import 'package:drive/widgets/show_pdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class ViewFileScreen extends StatelessWidget {
  ViewFileScreen({super.key, required this.files});
  FilesModel files;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.grey),
          backgroundColor: Colors.white,
          title: Text(
            files.name,
            style: textStyle(12, Colors.grey, FontWeight.w600),
          ),
          actions: [
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(files.name,
                                    style: textStyle(
                                        20, Colors.black, FontWeight.w300)),
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
                                  padding: EdgeInsets.only(left: 30, right: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton.icon(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Colors.orange)),
                                        label: Text("Download"),
                                        onPressed: () {
                                          FirebaseServices()
                                              .Downloadfile(files);
                                        },
                                        icon: Icon(Icons.download),
                                      ),
                                      OutlinedButton.icon(
                                        onPressed: () {
                                          FirebaseServices().deleteFile(files);
                                        },
                                        icon: Icon(
                                            color: Colors.orange, Icons.delete),
                                        label: Text(
                                          "Remove",
                                          style: textStyle(20, Colors.orange,
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
                child: Icon(Icons.more_vert, color: Colors.grey))
          ],
        ),
        body: files.fileType == "image"
            ? showImage(files.url)
            : files.fileType == 'application'
                ? showfile(context, files)
                : files.fileType == 'video'
                    ? ShowVideofile(
                        file: files,
                      )
                    : Container());
  }

  showImage(String url) {
    return Image(fit: BoxFit.cover, image: NetworkImage(url));
  }

  ShowVideofile({required FilesModel file}) {
    if (file.fileExtension == "MOV") {
      return ShowVideo(
        url: file.url,
      );
    } else {
      return Container(
        child: Center(
          child: Text("unfortunatly this file cannot open"),
        ),
      );
    }
  }
}

showfile(BuildContext context, FilesModel file) {
  print(file.fileExtension);
  if (file.fileExtension == "pdf") {
    return ShowPdf(
      files: file,
    );
  } else {
    return Container(
      child: Center(
        child: Text("unfortunatly this file cannot open"),
      ),
    );
  }
}
