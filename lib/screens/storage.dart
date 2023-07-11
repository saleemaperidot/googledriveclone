import 'package:drive/controllers/storage_controller.dart';
import 'package:drive/widgets/storage_widget.dart';
import 'package:drive/widgets/upload_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class StorageScreen extends StatelessWidget {
  StorageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        SizedBox(
          height: 30,
        ),
        StorageWidget(),
        SizedBox(
          height: 30,
        ),
        Expanded(child: UploadWidget()),
      ]),
    );
  }
}
