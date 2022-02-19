import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:talabatcom_driver/app/keys.dart';
import 'dart:io';
import 'package:talabatcom_driver/helpers/utils/sharedPreferenceClass.dart';

class UpdateLocationRepo {
  Future<bool?> updatelocation({double? longitude, double? latitude}) async {
    try {
      var response =
          await http.post(Uri.parse('$Apikey/driver/driver_location'), body: {
        "api_token": sharedPrefs.token,
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
      });
      Map<String, dynamic> responsemap = json.decode(response.body);
      if (response.statusCode == 200 && responsemap["success"] == true) {
        return true;
      }
    } on TimeoutException catch (e) {
      print('Timeout Error: $e');
    } on SocketException catch (e) {
      print('Socket Error: $e');
    } on Error catch (e) {
      print('General Error: $e');
    }
  }
}
