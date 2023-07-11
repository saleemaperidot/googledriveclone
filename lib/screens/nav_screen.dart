import 'package:drive/screens/storage.dart';
import 'package:drive/utilit/utilities.dart';
import 'package:drive/screens/files.dart';
// import 'package:drive/screens/storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NavScreen extends StatelessWidget {
  const NavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: Icon(
              Icons.menu,
              color: Colors.grey,
            ),
            title: Text(
              "D-Drive",
              style: textStyle(18, Colors.grey, FontWeight.w500),
            ),
            actions: [
              Icon(
                Icons.search,
                color: Colors.grey,
              )
            ],
            backgroundColor: Colors.white,
            elevation: 0,
            bottom: TabBar(
                unselectedLabelColor: Colors.redAccent,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.redAccent, Colors.orangeAccent]),
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.redAccent),
                tabs: [
                  Tab(
                    child: Text(
                      "Files",
                      style: textStyle(20, Colors.grey, FontWeight.w400),
                    ),
                  ),
                  Container(
                    child: Tab(
                      iconMargin: EdgeInsetsGeometry.infinity,
                      child: Text(
                        "Storage",
                        style: textStyle(20, Colors.grey, FontWeight.w400),
                      ),
                    ),
                  )
                ]),
          ),
          body: TabBarView(children: [
            Files(),
            StorageScreen(),
          ]),
        ),
      ),
    );
  }
}
