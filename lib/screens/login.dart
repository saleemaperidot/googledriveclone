import 'package:drive/controllers/authentication_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utilit/utilities.dart';

class Login extends StatelessWidget {
  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Color.fromARGB(255, 239, 206, 245)])),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
              // color: Colors.purple,
              width: MediaQuery.of(context).size.width * .5,
              image: AssetImage("assets/logo.png")),
          SizedBox(
            height: 25,
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                textAlign: TextAlign.center,
                style: textStyle(20, Colors.grey, FontWeight.w600),
                "Create and share your work online and access your documents from anywhere",
              )),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {},
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[300]),
                onPressed: () {
                  Get.find<AuthController>().login();
                },
                child: Text(
                  "Lets start",
                  style: textStyle(15, Colors.white, FontWeight.w900),
                )),
          )
        ],
      ),
    )));
  }
}
