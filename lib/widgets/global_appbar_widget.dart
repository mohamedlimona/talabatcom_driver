import 'package:flutter/material.dart';
import 'package:talabatcom_driver/app/constants.dart';

class GlobalAppBar extends StatelessWidget with PreferredSizeWidget {
  final bool enableBackButton;
  final double height;
  final Widget child;
  final Widget? leading;
  final Color? color;
  const GlobalAppBar(
      {Key? key,
      required this.enableBackButton,
      required this.height,
      required this.child,
         this.leading,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: height,
      elevation: 0.0,
      backgroundColor: color ?? Constants.primaryAppColor,
      automaticallyImplyLeading: enableBackButton,
      leading:leading ?? Container() ,
      title: Padding(padding: const EdgeInsets.only(top: 20.0), child: child),
      centerTitle: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(80.0),
              bottomLeft: Radius.circular(80.0))),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.infinity, height);
}
