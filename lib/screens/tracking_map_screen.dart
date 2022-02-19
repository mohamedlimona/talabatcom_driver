// ignore_for_file: use_key_in_widget_constructors, file_names, prefer_const_constructors_in_immutables
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animarker/core/ripple_marker.dart';
import 'package:flutter_animarker/widgets/animarker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:talabatcom_driver/app/constants.dart';
import 'package:talabatcom_driver/app/map_utils.dart';
import 'package:talabatcom_driver/cubit/changestatus_cubit/changestatus_cubit.dart';
import 'package:talabatcom_driver/cubit/changestatus_cubit/changestatus_state.dart';
import 'package:talabatcom_driver/cubit/trackdeatils_cuibt/orderdetails_cubit.dart';
import 'package:talabatcom_driver/cubit/trackdeatils_cuibt/orderdetails_state.dart';
import 'package:talabatcom_driver/helpers/utils/myApplication.dart';
import 'package:talabatcom_driver/repositories/map_repo.dart';
import 'package:talabatcom_driver/repositories/update_location.dart';
import 'package:location/location.dart';
import 'package:talabatcom_driver/screens/assigned_orders_screen.dart';
import 'package:talabatcom_driver/widgets/btn_widget.dart';
import 'package:talabatcom_driver/widgets/custom_dialog.dart';

class TrackingMapScreen extends StatefulWidget {
  final int order_id;
  final int order_status_id;
  TrackingMapScreen(
      {Key? key, required this.order_id, required this.order_status_id})
      : super(key: key);

  @override
  State<TrackingMapScreen> createState() => TrackingMapScreenState();
}

class TrackingMapScreenState extends State<TrackingMapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  LatLng destinationLatLng = const LatLng(31.094254, 30.739935);
  final Set<Polyline> _polyline = {};
  Set<Marker> _markers = <Marker>{};
  Location location = Location();
  MapServices api = MapServices();
  String? distance;
  String? duration;
  bool? _serviceEnabled;
  StreamSubscription<LocationData>? _locationSubscription;
  PermissionStatus? _permissionGranted;
  String pick = "pickup";
  bool? loading = false;

  _setPolyLine({LatLng? initialLatLng}) async {
    await api.getRoute(initialLatLng!, destinationLatLng).then((value) {
      if (value!.data["routes"] != []) {
        final route = value.data["routes"][0]["overview_polyline"]["points"];
        _polyline.add(Polyline(
            polylineId: const PolylineId("tripRoute"),
            width: 3,
            geodesic: true,
            points: MapUtils.convertToLatLng(MapUtils.decodePoly(route)),
            color: Theme.of(context).primaryColor));
      }
    });
  }

  UpdateLocationRepo updateLocationRepo = UpdateLocationRepo();

  getlocation() async {
    _serviceEnabled = await location.serviceEnabled();

    if (_serviceEnabled!) {
      _permissionGranted = await location.hasPermission();
      if (_serviceEnabled =
          true && _permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_serviceEnabled =
            true && _permissionGranted == PermissionStatus.granted) {
          getdata();
        } else {
          getlocation();
        }
      } else if (_serviceEnabled =
          true && _permissionGranted == PermissionStatus.granted) {
        getdata();
      }
    } else {
      _serviceEnabled = await location.requestService();
      getlocation();
    }
  }

  int firsttime = 1;
  getdata() async {
    widget.order_status_id == 2
        ? await BlocProvider.of<ChangestatusCubit>(context)
            .getChangestatus(status_id: 3, order_id: widget.order_id)
        : null;
    BlocProvider.of<TrackingCubit>(context).getTracking(1, widget.order_id);
    _locationSubscription =
        location.onLocationChanged.handleError((dynamic err) {
      if (err is PlatformException) {
        Fluttertoast.showToast(
            msg: "Please allow location for app",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 3,
            backgroundColor: Constants.primaryAppColor,
            textColor: Constants.whiteAppColor,
            fontSize: 16.0);
      }
      _locationSubscription?.cancel();
    }).listen((event) async {
      await BlocProvider.of<TrackingCubit>(context)
          .getTracking(2, widget.order_id);
      if (BlocProvider.of<TrackingCubit>(context).response != null) {
        destinationLatLng = LatLng(
            BlocProvider.of<TrackingCubit>(context).response!.data.userLatitude,
            BlocProvider.of<TrackingCubit>(context)
                .response!
                .data
                .userLongitude);
        if (firsttime == 1) {
          await api.addPolyLines(
              controlle: _controller,
              destinationLatLng: destinationLatLng,
              initial: event);

          await _setPolyLine(
              initialLatLng: LatLng(event.latitude!, event.longitude!));

          firsttime = 2;
        }
        await api.setMapPins(
            [LatLng(event.latitude!, event.longitude!), destinationLatLng],
            context).then((value) {
          _markers = value;
        });
        await api
            .gettimebetween(
                l1: LatLng(event.latitude!, event.longitude!),
                l2: destinationLatLng)
            .then((value) {
          distance = value!.rows[0].elements[0].distance.text;
          duration = value.rows[0].elements[0].duration.text;
        });
        await updateLocationRepo.updatelocation(
            latitude: event.latitude, longitude: event.longitude);
      }
      newLocationUpdate(LatLng(event.latitude!, event.longitude!));
    });
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
    super.dispose();
  }

  @override
  void initState() {
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
        getlocation();
      }
    });
  }

  void newLocationUpdate(LatLng latLng) {
    Marker marker = RippleMarker(
      draggable: true,
      markerId: MarkerId(latLng.toString()),
      position: latLng,
      ripple: true,
    );
    setState(() {
      for (var element in _markers) {
        if (element.markerId == MarkerId(latLng.toString())) {
          element = marker;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: true,
        child: Stack(
          children: [
            SizedBox(
              height: size.height,
              width: size.width,
              child: Animarker(
                duration: const Duration(milliseconds: 20),
                rippleDuration: const Duration(milliseconds: 20),
                mapId: _controller.future.then<int>((value) => value.mapId),
                child: GoogleMap(
                  compassEnabled: true,
                  mapType: MapType.normal,
                  rotateGesturesEnabled: true,
                  zoomGesturesEnabled: true,
                  trafficEnabled: false,
                  tiltGesturesEnabled: false,
                  scrollGesturesEnabled: true,
                  markers: _markers,
                  polylines: _polyline,
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(37.42796133580664, -122.085749655962),
                    zoom: 14,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    if (!_controller.isCompleted) {
                      _controller.complete(controller);
                    }
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: SizedBox(
                height: size.height,
                width: size.width,
                child: BlocBuilder<TrackingCubit, TrackingState>(
                    bloc: BlocProvider.of<TrackingCubit>(context),
                    builder: (context, state) {
                      if (state is TrackingLoading) {
                        return SpinKitThreeBounce(
                          color: Constants.primaryAppColor,
                          size: size.width * .08,
                        );
                      } else if (state is TrackingLoaded) {
                        if (state.response!.data.orderStatusId == 5) {
                          return AlertDialog(
                            insetPadding: const EdgeInsets.all(0.0),
                            backgroundColor: Colors.transparent,
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  // height: MediaQuery.of(context).size.height/2,
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text(
                                          'How Was Your Client,',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/images/rating_driver_client.svg',
                                              width: 25.0,
                                              height: 25.0,
                                            ),
                                            const SizedBox(
                                              width: 5.0,
                                            ),
                                            const Text(
                                              'Client',
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.black),
                                            ),
                                            Spacer(),
                                            RatingBar(
                                              initialRating: 5,
                                              minRating: 1,
                                              itemPadding:
                                                  const EdgeInsets.only(
                                                      left: 5.0, right: 5.0),
                                              direction: Axis.horizontal,
                                              allowHalfRating: false,
                                              itemCount: 5,
                                              itemSize: 15.0,
                                              //  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                              maxRating: 5,
                                              ratingWidget: RatingWidget(
                                                full: const Icon(
                                                  Icons.star,
                                                  size: 60.0,
                                                  color: Colors.amber,
                                                ),
                                                empty: const Icon(
                                                  Icons.star,
                                                  size: 60.0,
                                                  color: Colors.grey,
                                                ),
                                                half: const Icon(
                                                  Icons.star_half,
                                                  size: 60.0,
                                                  color: Colors.amber,
                                                ),
                                              ),
                                              onRatingUpdate: (rating) {},
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        TextField(
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              filled: true,
                                              contentPadding:
                                                  const EdgeInsetsDirectional
                                                          .only(
                                                      start: 20.0,
                                                      bottom: 70.0),
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[800]),
                                              hintText: "Write Review",
                                              fillColor: Colors.white70),
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        BtnWidget(
                                          color: Constants.primaryAppColor,
                                          onClicked: () {
                                            Navigator.pop(context);
                                            Future.delayed(
                                                const Duration(seconds: 1), () {
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              AssignedOrdersScreen()),
                                                      (Route<dynamic> route) =>
                                                          false);
                                            });
                                          },
                                          txt: 'Submit Review',
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        destinationLatLng ==
                            LatLng(state.response!.data.userLatitude,
                                state.response!.data.userLongitude);

                        return Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: Container(
                                margin: const EdgeInsets.only(
                                    bottom: 10.0, right: 8.0),
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white, width: 1.5)),
                                child: const CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: AssetImage(
                                        'assets/images/profile.jpg')),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: Container(
                                width: size.width,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF444D50),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(60.0),
                                    topRight: Radius.circular(60.0),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 15),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 50,
                                                margin: const EdgeInsets.only(
                                                    bottom: 10.0, right: 8.0),
                                                decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: const Color(
                                                            0xFFE44544),
                                                        width: 1.5)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),

                                                  child: CachedNetworkImage(
                                                    imageUrl: state.response!
                                                            .data.user.hasMedia
                                                        ? state.response!.data
                                                            .user.media[0].url
                                                        : 'ff',
                                                    height: 50,
                                                    width: 50,
                                                    fit: BoxFit.fitWidth,
                                                    placeholder:
                                                        (context, str) {
                                                      return const SpinKitThreeBounce(
                                                        color: Constants
                                                            .primaryAppColor,
                                                        size: 10,
                                                      );
                                                    },
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Image.asset(
                                                      "assets/images/no-profile.jpg",
                                                      width: size.width,
                                                      height: 250,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ), //     height: 250,
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      state.response!.data.user
                                                          .name,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white)),
                                                  const SizedBox(height: 5),
                                                  RatingBar.builder(
                                                    itemSize: 10,
                                                    initialRating: state
                                                        .response!.data.userRate
                                                        .toDouble(),
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    unratedColor: Colors.grey,
                                                    itemCount: 5,
                                                    itemPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 4.0),
                                                    itemBuilder: (context, _) =>
                                                        const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    onRatingUpdate: (rating) {},
                                                  ),
                                                  const SizedBox(height: 10),
                                                ],
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                  "assets/images/detail.svg",
                                                  width: 25,
                                                  color: Colors.white),
                                              SizedBox(
                                                width: size.width * .05,
                                              ),
                                              SvgPicture.asset(
                                                  "assets/images/chat.svg",
                                                  width: 20,
                                                  color: Colors.white),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(60.0),
                                          topRight: Radius.circular(60.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30, right: 30, top: 20),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                        "assets/images/money.svg",
                                                        width: 25,
                                                        color: const Color(
                                                            0xFF43494B)),
                                                    const SizedBox(width: 10),
                                                    const Text("Total order",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Color(
                                                                0xFF43494B)))
                                                  ],
                                                ),
                                                Text(
                                                    state.response!.data
                                                            .totalPayment
                                                            .toString() +
                                                        " SAR",
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xFFE44544)))
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                        "assets/images/time.svg",
                                                        width: 25,
                                                        color: const Color(
                                                            0xFF43494B)),
                                                    const SizedBox(width: 10),
                                                    const Text("Delivery time",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Color(
                                                                0xFF43494B)))
                                                  ],
                                                ),
                                                Text(
                                                    duration == null
                                                        ? "0"
                                                        : duration!,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xFFE44544)))
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                        "assets/images/navi.svg",
                                                        width: 25,
                                                        color: const Color(
                                                            0xFF43494B)),
                                                    const SizedBox(width: 10),
                                                    const Text(
                                                        "Distance from you",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Color(
                                                                0xFF43494B)))
                                                  ],
                                                ),
                                                Text(
                                                    distance == null
                                                        ? "0"
                                                        : distance!,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xFFE44544)))
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                        "assets/images/money.svg",
                                                        width: 25,
                                                        color: const Color(
                                                            0xFF43494B)),
                                                    const SizedBox(width: 10),
                                                    const Text("Payment Method",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Color(
                                                                0xFF43494B)))
                                                  ],
                                                ),
                                                Text(
                                                    state.response!.data
                                                        .paymentMethod,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xFFE44544)))
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                BlocBuilder<ChangestatusCubit,
                                                        ChangestatusState>(
                                                    builder: (context, stat) {
                                                  if (stat
                                                      is ChangestatusLoaded) {
                                                    return InkWell(
                                                      onTap: () async {
                                                        if (state.response!.data
                                                                .orderStatusId ==
                                                            3) {
                                                          await BlocProvider.of<
                                                                      ChangestatusCubit>(
                                                                  context)
                                                              .getChangestatus(
                                                                  status_id: 4,
                                                                  order_id: state
                                                                      .response!
                                                                      .data
                                                                      .id);
                                                        } else if (state
                                                                .response!
                                                                .data
                                                                .orderStatusId ==
                                                            4) {
                                                          await BlocProvider.of<
                                                                      ChangestatusCubit>(
                                                                  context)
                                                              .getChangestatus(
                                                                  status_id: 5,
                                                                  order_id: state
                                                                      .response!
                                                                      .data
                                                                      .id);
                                                        }
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        width: size.width * .5 -
                                                            60,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            color: const Color(
                                                                0xFF80AF50),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        24.0)),
                                                        child: Text(
                                                          state.response!.data
                                                                      .orderStatusId ==
                                                                  2
                                                              ? "pickup"
                                                              : state.response!.data
                                                                          .orderStatusId ==
                                                                      3
                                                                  ? "pickup"
                                                                  : "delivered",
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ),
                                                    );
                                                  } else if (stat
                                                      is ChangestatusLoading) {
                                                    return SpinKitThreeBounce(
                                                      color: Constants
                                                          .primaryAppColor,
                                                      size: size.width * .08,
                                                    );
                                                  } else {
                                                    return InkWell(
                                                      onTap: () async {
                                                        if (state.response!.data
                                                                .orderStatusId ==
                                                            3) {
                                                          await BlocProvider.of<
                                                                      ChangestatusCubit>(
                                                                  context)
                                                              .getChangestatus(
                                                                  status_id: 4,
                                                                  order_id: state
                                                                      .response!
                                                                      .data
                                                                      .id);
                                                        } else if (state
                                                                .response!
                                                                .data
                                                                .orderStatusId ==
                                                            4) {
                                                          await BlocProvider.of<
                                                                      ChangestatusCubit>(
                                                                  context)
                                                              .getChangestatus(
                                                                  status_id: 5,
                                                                  order_id: state
                                                                      .response!
                                                                      .data
                                                                      .id);
                                                        }
                                                        // else if (state
                                                        //         .response!
                                                        //         .data
                                                        //         .orderStatusId ==
                                                        //     4) {
                                                        //   await BlocProvider.of<
                                                        //               ChangestatusCubit>(
                                                        //           context)
                                                        //       .getChangestatus(
                                                        //           status_id: 5,
                                                        //           order_id: state
                                                        //               .response!
                                                        //               .data
                                                        //               .id);
                                                        // }
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        width: size.width * .5 -
                                                            60,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            color: const Color(
                                                                0xFF80AF50),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        24.0)),
                                                        child: Text(
                                                          state.response!.data
                                                                      .orderStatusId ==
                                                                  2
                                                              ? "pickup"
                                                              : state.response!.data
                                                                          .orderStatusId ==
                                                                      3
                                                                  ? "pickup"
                                                                  : "delivered",
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                }),
                                                InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return CustomAlert(
                                                              orderID: state
                                                                  .response!
                                                                  .data
                                                                  .id);
                                                        });
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: size.width * .5 - 60,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFFE44544),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    24.0)),
                                                    child: const Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                      } else {
                        return const Text("No Orders");
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
