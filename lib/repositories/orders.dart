// ignore_for_file: avoid_print
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import '../app/constants.dart';
import '../app/keys.dart';
import '../helpers/utils/sharedPreferenceClass.dart';
import '../models/list_orders_model.dart';
import 'package:http/http.dart' as http;

Future<ListOrdersModel?> getListOrders(String token) async {
  try {
    var response = await http.get(
      Uri.parse('$Apikey/orders?api_token=${sharedPrefs.token}'),
      headers: {'Accept': 'application/json'},
    );
    Map<String, dynamic> responseMap = json.decode(response.body);
    if (response.statusCode == 200 && responseMap["success"] == true) {
      final data = ListOrdersModel.fromJson(jsonDecode(response.body));
      return data;
    } else {
      Fluttertoast.showToast(
          msg: responseMap["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Constants.primaryAppColor,
          textColor: Constants.whiteAppColor,
          fontSize: 16.0);
    }
  } on TimeoutException catch (e) {
    print('Timeout Error: $e');
  } on SocketException catch (e) {
    print('Socket Error: $e');
  }
}