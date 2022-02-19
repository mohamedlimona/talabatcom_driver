import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:talabatcom_driver/models/disdur_model.dart';
import 'package:talabatcom_driver/models/mapapi_model.dart';

class MapServices {
  final Set<Marker> markers = <Marker>{};
  final Set<Polyline> polyline = {};
  final LatLng destinationLatLng = const LatLng(31.094254, 30.739935);
  LatLng? initialLatLng;
  int firsttim = 1;

  ///Authentication APIs
  Future<APIResultModel?> getRouteCoordinates(dynamic parameters) async {
    try {
      return APIResultModel.fromResponse(
          response: await http
              .get(Uri.https('maps.googleapis.com', '/maps/api/directions/json',
                  parameters))
              .then((value) {
            return value;
          }),
          data: null);
    } on TimeoutException catch (e) {
      print('Timeout Error: $e');
    } on SocketException catch (e) {
      print('Socket Error: $e');
    } on HandshakeException catch (e) {
      print('Socket Error: $e');
    } on Error catch (e) {
      print('General Error: $e');
    }
  }

  Future<DistanceDuration_model?> gettimebetween(
      {LatLng? l1, LatLng? l2}) async {
    try {
      final response = await http.get(Uri.parse(
          "https://maps.googleapis.com/maps/api/distancematrix/json?departure_time=now&origins=${l1!.latitude},${l1.longitude}&destinations=${l2!.latitude},${l2.longitude}&key=AIzaSyDgjSgfmYnmDIBbSnICGdErtwgBBUWioTs"));

      Map<String, dynamic> responsemap = json.decode(response.body);
      if (response.statusCode == 200 && responsemap["status"] == "OK") {
        final data = DistanceDuration_model.fromJson(jsonDecode(response.body));
        return data;
      }
    } on TimeoutException catch (e) {
      print('Timeout Error: $e');
    } on SocketException catch (e) {
      print('Socket Error: $e');
    } on HandshakeException catch (e) {
      print('Socket Error: $e');
    } on Error catch (e) {
      print('General Error: $e');
    }
  }

  Future<APIResultModel?> getRoute(LatLng l1, LatLng l2) {
    return getRouteCoordinates({
      'origin': '${l1.latitude},${l1.longitude}',
      'destination': '${l2.latitude},${l2.longitude}',
      'key': "AIzaSyDgjSgfmYnmDIBbSnICGdErtwgBBUWioTs",
    });
  }

  Future<Uint8List> getMarker(BuildContext context) async {
    ByteData byteData = await DefaultAssetBundle.of(context)
        .load("assets/images/food-delivery-marker.png");
    return byteData.buffer.asUint8List();
  }

  Future<Set<Marker>> setMapPins(
      List<LatLng> markersLocation, BuildContext context) async {
    markers.clear();
    Uint8List imageData = await getMarker(context);

    markers.add(Marker(
        markerId: MarkerId(markersLocation[0].toString()),
        position: markersLocation[0],
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: const Offset(1, 1),
        icon: BitmapDescriptor.fromBytes(imageData)));

    markers.add(Marker(
      markerId: MarkerId(markersLocation[1].toString()),
      position: markersLocation[1],
    ));
    return markers;
  }

  addPolyLines(
      {LocationData? initial,
      LatLng? destinationLatLng,
      Completer<GoogleMapController>? controlle}) {
    moveCamera(
        controlle: controlle,
        lat: (initial!.latitude! + destinationLatLng!.latitude) / 2,
        lng: (initial.longitude! + destinationLatLng.longitude) / 2);
  }

  moveCamera(
      {Completer<GoogleMapController>? controlle,
      double? lat,
      double? lng}) async {
    final CameraPosition myPosition = CameraPosition(
      target: LatLng(lat!, lng!),
      zoom: 12,
    );
    final GoogleMapController controller = await controlle!.future;
    // if (firsttim == 1) {
    controller.animateCamera(CameraUpdate.newCameraPosition(myPosition));
    // }
    // firsttim = 2;
  }
}
