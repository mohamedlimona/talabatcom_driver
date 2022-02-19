import 'package:flutter/material.dart';
import 'package:talabatcom_driver/app/constants.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class BtnWidget extends StatelessWidget {
  final String txt;
  VoidCallback onClicked;
  Color color;
  BtnWidget(
      {Key? key,
      required this.txt,
      required this.onClicked,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(80.0)),
      child: SizedBox(
        height: size.height * 0.06,
        width: size.width * 0.8,
        child: ElevatedButton(
          onPressed: onClicked,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(color),
              elevation: MaterialStateProperty.all(0.0)),
          child: Text(txt,
              style: TextStyle(
                  color: color == Constants.primaryAppColor
                      ? Constants.whiteAppColor
                      : color == Constants.primaryAppColor.withOpacity(0.6)
                          ? Constants.whiteAppColor
                          : Constants.HINT,
                  fontSize: 17)),
        ),
      ),
    );
  }
}
