import 'package:drive/controllers/file_folder_controller.dart';
import 'package:drive/screens/displayfiles_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class UploadWidget extends StatelessWidget {
  const UploadWidget({super.key});
  Widget colouredContainer(
      Color _color, IconData _icon, _iconColor, String title) {
    return InkWell(
      onTap: () {
        Get.to(
            () => DisplayFilesScreen(
                  title: title,
                  type: "files",
                ),
            binding: FileBinding("files", '', title));
      },
      child: Container(
        decoration: BoxDecoration(
          color: _color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(
          _icon,
          size: 40,
          color: _iconColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200,
      ),
      child: GridView.count(
        padding: EdgeInsets.all(30),
        crossAxisCount: 4,
        shrinkWrap: true,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        children: [
          colouredContainer(Colors.pinkAccent, Icons.image,
              Color.fromARGB(255, 141, 35, 70), "image"),
          colouredContainer(
              Colors.lightBlueAccent, Icons.video_call, Colors.blue, "video"),

          colouredContainer(Colors.purpleAccent, Icons.document_scanner,
              Colors.purple, "application"),
          colouredContainer(Colors.yellowAccent, Icons.file_download_done_sharp,
              Colors.yellow, "document"),
          // colouredContainer(Colors.grey, Icons.image, Colors.amber),
          // colouredContainer(Colors.teal, Icons.image, Colors.orange),
          // colouredContainer(Colors.lightBlueAccent, Icons.image, Colors.indigo),
        ],
      ),
    );
  }
}
