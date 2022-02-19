// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:talabatcom_driver/app/constants.dart';
import 'package:talabatcom_driver/app/silvergrid_ratio.dart';
import 'package:talabatcom_driver/cubit/list_orders_cubit/list_orders_cubit.dart';
import 'package:talabatcom_driver/cubit/list_orders_cubit/list_orders_state.dart';
import 'package:talabatcom_driver/widgets/assigned_orders_card.dart';

import '../helpers/utils/myApplication.dart';
import '../helpers/utils/sharedPreferenceClass.dart';

class AssignedOrdersScreen extends StatefulWidget {
  @override
  _AssignedOrdersScreenState createState() => _AssignedOrdersScreenState();
}

class _AssignedOrdersScreenState extends State<AssignedOrdersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MyApplication.checkConnection().then((value) {
      if (!value) {
        Fluttertoast.showToast(
            msg: 'No Internet Connection',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        BlocProvider.of<ListOrdersCubit>(context)
            .listOrders(token: sharedPrefs.token, context: context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.whiteAppColor,
      body: SizedBox(
        height: size.height,
        child: Column(
          children: [
            Container(
              height: size.height * .22,
              width: size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60.0),
                  bottomRight: Radius.circular(60.0),
                ),
                color: Color(0xffe44544),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      "assets/images/menu3.svg",
                      color: Colors.white,
                      height: size.height * 0.05,
                      width: size.height * 0.05,
                      fit: BoxFit.contain,
                    ),
                    const Text(
                      'Order Requests',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        color: Color(0xffffffff),
                      ),
                    ),
                    Container(width: 25),
                  ],
                ),
              ),
            ),
            RefreshIndicator(
              color: Constants.primaryAppColor,
              onRefresh: () async {
                BlocProvider.of<ListOrdersCubit>(context)
                    .listOrders(token: sharedPrefs.token, context: context);
              },
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .78,
                    child: ListView(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Text.rich(
                                TextSpan(
                                    text: "Hello ",
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 17,
                                      color: Color(0xe543494b),
                                    ),
                                    children: [
                                      TextSpan(
                                          text:
                                              "${sharedPrefs.name.toString()},")
                                    ]),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * .015,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: const [
                              Text(
                                'Our customers wait their orders quickly ',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  color: Color(0x9943494b),
                                ),
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * .035,
                        ),
                        BlocBuilder<ListOrdersCubit, ListOrdersState>(
                            bloc: BlocProvider.of<ListOrdersCubit>(context),
                            builder: (context, state) {
                              if (state is ListOrdersLoading) {
                                return SpinKitThreeBounce(
                                  color: Constants.primaryAppColor,
                                  size: size.width * .08,
                                );
                              }
                              else if (state is ListOrdersLoaded) {
                                if (state.listOrdersModel.data.isEmpty){
                                  return const Center(
                                      child: Text(
                                        "no orders",
                                        style: TextStyle(color: Colors.black),
                                      ));
                                } else {
                                  return GridView.builder(
                                    padding: const EdgeInsets.only(
                                        right: 15, left: 15, bottom: 10),
                                    shrinkWrap: true,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    itemCount:
                                    state.listOrdersModel.data.length.toInt(),
                                    gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      height: size.height * .3,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return AssignedOrdersCard(
                                          listOrdersModel: state.listOrdersModel.data[index]);
                                    },
                                  );
                                }

                              } else {
                                return const Center(
                                    child: Text(
                                  "no orders",
                                  style: TextStyle(color: Colors.black),
                                ));
                              }
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
