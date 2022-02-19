import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talabatcom_driver/app/constants.dart';

// ignore: use_key_in_widget_constructors
class VerifyContainerWidget extends StatefulWidget {
  final Function(String) onChanged;
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  const VerifyContainerWidget(
      {Key? key,
        required this.onChanged,
        required this.focusNode,
        required this.textEditingController})
      : super(key: key);

  @override
  State<VerifyContainerWidget> createState() => _VerifyContainerWidgetState();
}

class _VerifyContainerWidgetState extends State<VerifyContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: RawKeyboardListener(
              focusNode: FocusNode(),
              onKey: (event) {
                if (event.logicalKey == LogicalKeyboardKey.backspace) {
                  // here you can check if textfield is focused
                  FocusScope.of(context).previousFocus();
                }
              },
              child: TextFormField(
                autofocus: true,
                controller: widget.textEditingController,
                focusNode: widget.focusNode,
                keyboardType: TextInputType.number,
                cursorColor: Constants.primaryAppColor,
                onChanged: widget.onChanged,

                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  // ignore: deprecated_member_use
                  // WhitelistingTextInputFormatter.digitsOnly,
                ],
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(

                    contentPadding: const EdgeInsets.only(left: 15),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Constants.bord)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Constants.bord))),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: 40,
            height: 2.5,
            decoration: BoxDecoration(
                color: widget.textEditingController.text.isNotEmpty
                    ? Colors.green
                    : Constants.primaryAppColor,
                borderRadius: BorderRadius.circular(20.0)),
          ),
        ],
      ),
    );
  }
}
