// // ignore_for_file: use_key_in_widget_constructors, file_names
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:lottie/lottie.dart';
// import 'package:talabatkom_driver/app/constants.dart';
//
// class UnAssignedOrdersScreen extends StatefulWidget {
//   @override
//   State<UnAssignedOrdersScreen> createState() => UnAssignedOrdersScreenState();
// }
//
// class UnAssignedOrdersScreenState extends State<UnAssignedOrdersScreen> {
//   final Completer<GoogleMapController> _controller = Completer();
//
//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(30.07730000, 31.35710000),
//     zoom: 14.4746,
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return SizedBox(
//       height: size.height,
//       width: size.width,
//       child: Scaffold(
//         backgroundColor: Constants.whiteAppColor,
//         body: Stack(
//           children: [
//             GoogleMap(
//               mapType: MapType.normal,
//               myLocationButtonEnabled: false,
//               zoomControlsEnabled: false,
//               initialCameraPosition: _kGooglePlex,
//               onMapCreated: (GoogleMapController controller) {
//                 _controller.complete(controller);
//               },
//             ),
//             Positioned(
//               left: 10,
//               top: 40,
//               child: Container(
//                 height: 40,
//                 width: 40,
//                 margin: const EdgeInsets.only(bottom: 10.0, right: 8.0),
//                 decoration: BoxDecoration(
//                     color: Colors.transparent,
//                     shape: BoxShape.circle,
//                     border: Border.all(color: Colors.white, width: 1.5)),
//                 child: const CircleAvatar(
//                     backgroundColor: Colors.transparent,
//                     backgroundImage: AssetImage('assets/images/profile.jpg')),
//               ),
//             ),
//             Positioned(
//               left: 120,
//               top: 150,
//               child: Lottie.asset(
//                 'assets/images/deliver.json',
//                 width: size.width * 0.15,
//                 height: size.height * 0.11,
//                 fit: BoxFit.fill,
//               ),
//             ),
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Container(
//                 width: double.infinity,
//                 decoration: const BoxDecoration(
//                   color: Color(0xFF444D50),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(60.0),
//                     topRight: Radius.circular(60.0),
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 20),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 30),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           SvgPicture.asset("assets/images/info.svg",
//                               width: 25, color: Colors.white),
//                           Row(
//                             children: [
//                               Container(
//                                 height: 50,
//                                 width: 50,
//                                 margin: const EdgeInsets.only(
//                                     bottom: 10.0, right: 8.0),
//                                 decoration: BoxDecoration(
//                                     color: Colors.transparent,
//                                     shape: BoxShape.circle,
//                                     border: Border.all(
//                                         color: const Color(0xFFE44544),
//                                         width: 1.5)),
//                                 child: const CircleAvatar(
//                                     backgroundColor: Colors.transparent,
//                                     backgroundImage:
//                                         AssetImage('assets/images/prof.jpg')),
//                               ),
//                               Column(
//                                 children: [
//                                   const Text("Karim Mohamed",
//                                       style: TextStyle(
//                                           fontSize: 16, color: Colors.white)),
//                                   const SizedBox(height: 1),
//                                   SvgPicture.asset("assets/images/revv.svg")
//                                 ],
//                               )
//                             ],
//                           ),
//                           SvgPicture.asset("assets/images/chat.svg",
//                               width: 20, color: Colors.white)
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Container(
//                       width: double.infinity,
//                       decoration: const BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(60.0),
//                           topRight: Radius.circular(60.0),
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 30.0, vertical: 20.0),
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     SvgPicture.asset("assets/images/money.svg",
//                                         width: 25,
//                                         color: const Color(0xFF43494B)),
//                                     const SizedBox(width: 10),
//                                     const Text("Total order",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             color: Color(0xFF43494B)))
//                                   ],
//                                 ),
//                                 const Text("40 SAR",
//                                     style: TextStyle(
//                                         fontSize: 14, color: Color(0xFFE44544)))
//                               ],
//                             ),
//                             const SizedBox(height: 15),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     SvgPicture.asset("assets/images/time.svg",
//                                         width: 25,
//                                         color: const Color(0xFF43494B)),
//                                     const SizedBox(width: 10),
//                                     const Text("Delivery time",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             color: Color(0xFF43494B)))
//                                   ],
//                                 ),
//                                 const Text("13:45",
//                                     style: TextStyle(
//                                         fontSize: 14, color: Color(0xFFE44544)))
//                               ],
//                             ),
//                             const SizedBox(height: 15),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     SvgPicture.asset("assets/images/navi.svg",
//                                         width: 25,
//                                         color: const Color(0xFF43494B)),
//                                     const SizedBox(width: 10),
//                                     const Text("Distance from you",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             color: Color(0xFF43494B)))
//                                   ],
//                                 ),
//                                 const Text("401 m",
//                                     style: TextStyle(
//                                         fontSize: 14, color: Color(0xFFE44544)))
//                               ],
//                             ),
//                             const SizedBox(height: 15),
//                             Row(
//                               children: [
//                                 Expanded(
//                                     child: Container(
//                                   height: 40,
//                                   alignment: Alignment.center,
//                                   decoration: BoxDecoration(
//                                       color: const Color(0xFF80AF50),
//                                       borderRadius:
//                                           BorderRadius.circular(24.0)),
//                                   child: const Text(
//                                     "Recieved",
//                                     style: TextStyle(
//                                         fontSize: 14, color: Colors.white),
//                                   ),
//                                 )),
//                                 SizedBox(width: size.width * 0.15),
//                                 Expanded(
//                                     child: GestureDetector(
//                                   onTap: () {
//                                     // showDialog(
//                                     //     context: context,
//                                     //     builder: (BuildContext context) {
//                                     //       return CustomAlert();
//                                     //     });
//                                   },
//                                   child: Container(
//                                     height: 40,
//                                     alignment: Alignment.center,
//                                     decoration: BoxDecoration(
//                                         color: const Color(0xFFE44544),
//                                         borderRadius:
//                                             BorderRadius.circular(24.0)),
//                                     child: const Text(
//                                       "Canceled",
//                                       style: TextStyle(
//                                           fontSize: 14, color: Colors.white),
//                                     ),
//                                   ),
//                                 ))
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
