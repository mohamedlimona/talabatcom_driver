// ignore_for_file: file_names, prefer_typing_uninitialized_variables
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApplication {
  static Future<bool> checkConnection() async {
    var connectivityResult;

    connectivityResult = await (Connectivity().checkConnectivity());

    {
      return connectivityResult == ConnectivityResult.none ? false : true;
    }
  }

  static void navigateToReplace(BuildContext context, Widget page) async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => page));
  }

  static void navigateToReplaceWithoutAnim(BuildContext context, Widget page) async {
    Navigator.of(context)
        .pushReplacement(PageRouteBuilder(
      pageBuilder: (context, anim, seconAnim) {
        return page;
      },
    ));
  }

  static void navigateTo(BuildContext context, Widget page) async {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  static void navigateToWithoutAnim(BuildContext context, Widget page) async {
    Navigator.of(context)
        .push(PageRouteBuilder(
      pageBuilder: (context, anim, seconAnim) {
        return page;
      },
    ));
  }
}
