import 'package:flutter/material.dart';
import 'package:talabatcom_driver/app/constants.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class BtnWidget2 extends StatelessWidget {
  final Widget child;
  VoidCallback onClicked;
  Color color;
  BtnWidget2(
      {Key? key,
      required this.child,
      required this.onClicked,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(80.0)),
      child: SizedBox(
        height: size.height * 0.072,
        width: size.width * 0.76,
        child: ElevatedButton(
          onPressed: onClicked,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(color),
              elevation: MaterialStateProperty.all(0.0)),
          child: Center(child: child)
        ),
      ),
    );
  }
}
