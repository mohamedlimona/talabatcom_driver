// ignore_for_file: avoid_print
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:talabatcom_driver/helpers/utils/myApplication.dart';
import 'package:talabatcom_driver/models/list_orders_model.dart';
import '../app/constants.dart';
import '../cubit/changestatus_cubit/changestatus_cubit.dart';
import '../screens/tracking_map_screen.dart';

class AssignedOrdersCard extends StatefulWidget {
  final Data listOrdersModel;
  const AssignedOrdersCard({Key? key, required this.listOrdersModel})
      : super(key: key);

  @override
  State<AssignedOrdersCard> createState() => _AssignedOrdersCardState();
}

class _AssignedOrdersCardState extends State<AssignedOrdersCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .3,
      width: (size.width * .5) - 30,
      child: Stack(
        children: [
          Positioned(
            top: size.height * .04,
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                // height: size.height * .2,
                width: (size.width * .5) - 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: const Color(0xFFFFFFFF),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x29000000),
                      offset: Offset(0, 6),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * .04,
                    ),
                    Text(
                      widget.listOrdersModel.user.name.toString(),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Color(0xff43494b),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .01,
                    ),
                    RatingBar.builder(
                      itemSize: 12,
                      initialRating:
                          widget.listOrdersModel.user.rate.toDouble(),
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 2.5),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    SizedBox(
                      height: size.height * .01,
                    ),
                    Text(
                      widget.listOrdersModel.address != null
                          ? widget.listOrdersModel.address.street.toString()
                          : "null",
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Color(0x7843494b),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: size.height * .01,
                    ),
                    Text.rich(TextSpan(
                        text: widget.listOrdersModel.timing.toString(),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: Color(0x7843494b),
                        ),
                        children: const [TextSpan(text: " Minutes")])),
                    SizedBox(
                      height: size.height * .01,
                    ),
                    Text.rich(
                      TextSpan(
                          text: widget.listOrdersModel.payment.price.toString(),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: Color(0xffe44544),
                          ),
                          children: const [TextSpan(text: " SAR")]),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: size.height * .01,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: InkWell(
                          onTap: () async {
                            (widget.listOrdersModel.orderStatusId == 3 ||
                                    widget.listOrdersModel.orderStatusId == 4)
                                ? MyApplication.navigateTo(
                                    context,
                                    TrackingMapScreen(
                                      order_id: widget.listOrdersModel.id,
                                      order_status_id:
                                          widget.listOrdersModel.orderStatusId,
                                    ))
                                : widget.listOrdersModel.disable == 1
                                    ? null
                                    : MyApplication.navigateTo(
                                        context,
                                        TrackingMapScreen(
                                          order_id: widget.listOrdersModel.id,
                                          order_status_id: widget
                                              .listOrdersModel.orderStatusId,
                                        ));
                          },
                          child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  // horizontal: 10,
                                  vertical: 5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color:
                                      (widget.listOrdersModel.orderStatusId ==
                                                  3 ||
                                              widget.listOrdersModel
                                                      .orderStatusId ==
                                                  4)
                                          ? const Color(0xFF80AF50)
                                          : widget.listOrdersModel.disable == 0
                                              ? const Color(0xFF80AF50)
                                              : const Color(0xFF8A8F93),
                                  borderRadius: BorderRadius.circular(24.0)),
                              child: Text(
                                (widget.listOrdersModel.orderStatusId == 3 ||
                                        widget.listOrdersModel.orderStatusId ==
                                            4)
                                    ? "In Progress"
                                    : "Start",
                                style: const TextStyle(color: Colors.white),
                              )),
                        ))
                  ],
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: size.height * .08,
                  width: size.height * .08,
                  margin: const EdgeInsets.only(bottom: 10.0, right: 8.0),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: const Color(0xFFE44544), width: 1.5)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: CachedNetworkImage(
                      imageUrl: widget.listOrdersModel.user.hasMedia != false
                          ? widget.listOrdersModel.user.media[0].url.toString()
                          : "assets/images/no-profile.jpg",
                      height: 50,
                      width: 50,
                      fit: BoxFit.fitWidth,
                      placeholder: (context, str) {
                        return const SpinKitThreeBounce(
                          color: Constants.primaryAppColor,
                          size: 10,
                        );
                      },
                      errorWidget: (context, url, error) => Image.asset(
                        "assets/images/no-profile.jpg",
                        width: size.width,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ), //     height: 250,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
