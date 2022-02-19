import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabatcom_driver/app/constants.dart';
import 'package:talabatcom_driver/app/validations.dart';

// ignore: use_key_in_widget_constructors
class TxtFieldWidget extends StatefulWidget {
  final String? labelTxt;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final bool isHasNextFocus;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? pass;
  final String? type;
  final FocusNode? focusNode;

  const TxtFieldWidget(
      {Key? key,
      this.labelTxt,
      required this.textEditingController,
      required this.textInputType,
      required this.isHasNextFocus,
      this.prefixIcon,
      this.suffixIcon,
      this.pass,
      this.type,
      this.focusNode})
      : super(key: key);

  @override
  State<TxtFieldWidget> createState() => _TxtFieldWidgetState();
}

class _TxtFieldWidgetState extends State<TxtFieldWidget> {
  final focusNode = FocusNode();
  bool obscure = true;

  bool edited = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          onChanged: (value) {
            setState(() {
              edited = true;
            });
          },
          controller: widget.textEditingController,
          keyboardType: widget.textInputType,
          obscureText: (widget.labelTxt == "Password" ||
                  widget.labelTxt == "Confirm Password" ||
                  widget.labelTxt == "*************" ||
                  widget.labelTxt == '***************')
              ? obscure
              : false,
          textInputAction: (widget.isHasNextFocus == true)
              ? TextInputAction.next
              : TextInputAction.done,
          focusNode: focusNode,
          onFieldSubmitted: ((widget.labelTxt == "Password" ||
                      widget.labelTxt == "Confirm Password" ||
                      widget.labelTxt == "*************" ||
                      widget.labelTxt == '***************') &&
                  widget.isHasNextFocus == true)
              ? (_) => focusNode.nextFocus()
              : (_) {
                  FocusScope.of(context).requestFocus(widget.focusNode);
                },
          obscuringCharacter: "*",
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
            alignLabelWithHint: false,
            suffixIcon: (widget.labelTxt == "Password" ||
                    widget.labelTxt == "Confirm Password" ||
                    widget.labelTxt == "*************" ||
                    widget.labelTxt == '***************')
                ? Container(
                    height: 60.0,
                    width: 50.0,
                    padding: const EdgeInsets.only(top: 20.0),
                    child: InkWell(
                        onTap: () {
                          onPressEye();
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8, right: 8, left: 8),
                              child: obscure
                                  ? Icon(
                                      CupertinoIcons.eye,
                                      color: Colors.grey.withOpacity(0.7),
                                      size: 25,
                                    )
                                  : Icon(
                                      CupertinoIcons.eye_slash,
                                      color: Colors.grey.withOpacity(0.7),
                                      size: 25.0,
                                    ),
                            ),
                          ],
                        )),
                  )
                : widget.suffixIcon,
            prefixIcon: widget.prefixIcon,
            labelStyle: TextStyle(
                fontSize: widget.labelTxt == "+966" ||
                        widget.labelTxt == "*************"
                    ? 14
                    : 12,
                color: Constants.HINT.withOpacity(0.5)),
            hintText: widget.labelTxt,
            hintStyle: TextStyle(
                fontSize: widget.labelTxt == "+966" ||
                        widget.labelTxt == "*************"
                    ? 14
                    : 12,
                color: Constants.HINT.withOpacity(0.5)),
          ),
          validator: (String? value) {
            if (widget.labelTxt == "First Name") {
              String? validationString =
                  Validations.validateName(value!, context);
              return validationString;
            } else if (widget.labelTxt == "Email") {
              String? validationString =
                  Validations.validateEmail(value!, context);
              return validationString;
            } else if (widget.labelTxt == "Phone Number" ||
                widget.textInputType == TextInputType.phone) {
              String? validationString =
                  Validations.validatePhone(value!, context);
              return validationString;
            } else if (widget.labelTxt == "Password" ||
                widget.labelTxt == "*************") {
              String? validationString =
                  Validations.validatePassword(value!, context);
              return validationString;
            } else if (widget.labelTxt == "Confirm Password" ||
                widget.labelTxt == '***************') {
              String? validationString = Validations.validateconPassword(
                  widget.pass!, context, value!);
              return validationString;
            } else if(widget.labelTxt == "National ID") {
              String? validationString =
                  Validations.validateNationalId(value!, context);
              return validationString;
            }
            else  {
              String? validationString =
              Validations.validateField(value!, context);
              return validationString;
            }
          },
        ),
        SizedBox(
            height: widget.labelTxt == "Confirm Password" ||
                    widget.labelTxt == "*************"
                ? 10
                : 5),
        widget.type == "signup"
            ? Visibility(
                visible: edited,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Container(
                        width: widget.textEditingController.text
                                    .toString()
                                    .length <
                                6
                            ? 50
                            : widget.textEditingController.text
                                        .toString()
                                        .length <
                                    8
                                ? 70
                                : 100,
                        height: 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.0),
                          color: widget.textEditingController.text
                                      .toString()
                                      .length <
                                  6
                              ? const Color(0xffe44544)
                              : widget.textEditingController.text
                                          .toString()
                                          .length <
                                      8
                                  ? const Color(0xffEB8115)
                                  : const Color(0xff80AF50),
                        ),
                      ),
                      SizedBox(
                        width: widget.textEditingController.text
                                    .toString()
                                    .length <
                                6
                            ? 50
                            : widget.textEditingController.text
                                        .toString()
                                        .length <
                                    8
                                ? 70
                                : 100,
                        child: Center(
                            child: Text(
                          widget.textEditingController.text.toString().length <
                                  6
                              ? "weak"
                              : widget.textEditingController.text
                                          .toString()
                                          .length <
                                      8
                                  ? "meduim"
                                  : "strong",
                          style:
                              TextStyle(color: Constants.HINT.withOpacity(0.5)),
                        )),
                      )
                    ],
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }

  onPressEye() {
    setState(() {
      obscure = !obscure;
    });
  }
}
