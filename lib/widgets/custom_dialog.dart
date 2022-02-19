// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabatcom_driver/app/constants.dart';
import 'package:talabatcom_driver/cubit/changestatus_cubit/changestatus_cubit.dart';

class CustomAlert extends StatefulWidget {
  final int? orderID;
  const CustomAlert({Key? key, required this.orderID}) : super(key: key);

  @override
  State<CustomAlert> createState() => _CustomAlertState();
}

class _CustomAlertState extends State<CustomAlert> {
  final TextEditingController noteTextEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: Builder(
        builder: (BuildContext context) {
          return Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text("Please write reason for cancellation:",
                          style:
                              TextStyle(fontSize: 17, color: Constants.HINT)),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      maxLength: 100,
                      maxLines: 3,
                      controller: noteTextEditingController,
                      decoration: InputDecoration(
                        hintText: "Client didn't receive the order",
                        hintStyle: TextStyle(
                            fontSize: 13,
                            color: Constants.HINT.withOpacity(0.6)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                                color: Constants.bord.withOpacity(0.6),
                                width: 1.0)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                                color: Constants.bord.withOpacity(0.6),
                                width: 1.0)),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<ChangestatusCubit>(context)
                                .getChangestatus(
                                    status_id: 6,
                                    order_id: widget.orderID,
                                    note: noteTextEditingController.text.toString(),
                                   );
                          },
                          child: const Text("Done",
                              style: TextStyle(
                                  color: Constants.primaryAppColor,
                                  fontSize: 17)),
                        )),
                  ],
                ),
              ),
              Positioned(
                right: 16,
                child: InkWell(
                  onTap: () {
                    BlocProvider.of<ChangestatusCubit>(context)
                        .getChangestatus(status_id: 4);
                    Navigator.pop(context);
                  },
                  child: const CircleAvatar(
                    radius: 13,
                    backgroundColor: Constants.primaryAppColor,
                    child: Center(
                        child:
                            Text("x", style: TextStyle(color: Colors.white))),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
