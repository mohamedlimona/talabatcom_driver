// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:talabatcom_driver/app/constants.dart';
import 'package:talabatcom_driver/app/keys.dart';
import 'package:talabatcom_driver/helpers/utils/myApplication.dart';
import 'package:talabatcom_driver/helpers/utils/sharedPreferenceClass.dart';
import 'package:talabatcom_driver/models/check_phone_model.dart';
import 'package:talabatcom_driver/models/forget_pass_model.dart';
import 'package:http/http.dart' as http;
import 'package:talabatcom_driver/models/update_pass_model.dart';
import 'package:talabatcom_driver/models/user_model.dart';
import 'package:talabatcom_driver/models/verification_model.dart';
import 'package:talabatcom_driver/screens/pending_screen.dart';

import '../models/device_info_model.dart';

class AuthRepo {
  Future<Usermodel?> login(
      {String? phone, String? pass, required bool rememberme}) async {
    try {
      var response =
          await http.post(Uri.parse('$Apikey/driver/login'), headers: {
        'Accept': 'application/json'
      }, body: {
        'phone': phone,
        'password': '$pass',
      });
      Map<String, dynamic> responsemap = json.decode(response.body);
      if (response.statusCode == 200 && responsemap["success"] == true) {
        final userdata = Usermodel.fromJson(jsonDecode(response.body));
        if (rememberme) {
          sharedPrefs.setSignedIn(true);
        } else {
          sharedPrefs.setSignedIn(false);
        }
        sharedPrefs.settoken(userdata.data.token);
        sharedPrefs.setName(userdata.data.name);
        print(userdata.data.token);
        Fluttertoast.showToast(
            msg: responsemap["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 3,
            backgroundColor: Constants.primaryAppColor,
            textColor: Constants.whiteAppColor,
            fontSize: 16.0);
        return userdata;
      } else {
        Fluttertoast.showToast(
            msg: responsemap["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 3,
            backgroundColor: Constants.primaryAppColor,
            textColor: Constants.whiteAppColor,
            fontSize: 16.0);
      }
    } on TimeoutException catch (e) {
      print('Timeout Error: $e');
    } on SocketException catch (e) {
      print('Socket Error: $e');
    } on Error catch (e) {
      print('General Error: $e');
    }
  }

  ///Create SignUp Cycle
  Future<bool?> signUp(
      String name,
      // String nationalId,
      String phone,
      String password,
      String passwordConfirmation,
      String idFrontImage,
      String idBackImage,
      String driverFrontImage,
      String vehicleFrontImage,
      BuildContext context) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse('$Apikey/driver/register'));

      Map<String, String> headers = {
        'Accept': 'application/json',
      };
      request.headers.addAll(headers);
      request.files
          .add(await http.MultipartFile.fromPath('ID_front', idFrontImage));
      request.files
          .add(await http.MultipartFile.fromPath('ID_back', idBackImage));
      request.files.add(await http.MultipartFile.fromPath(
          'driver_front_license', driverFrontImage));
      /*request.files.add(await http.MultipartFile.fromPath(
          'driver_back_license', driverBackImage));*/
      request.files.add(await http.MultipartFile.fromPath(
          'Vehicle_front_license', vehicleFrontImage));
      /*request.files.add(await http.MultipartFile.fromPath(
          'Vehicle_back_license', vehicleBackImage));*/
      request.fields["name"] = name;
      request.fields["phone"] = phone;
      request.fields["password"] = password;
      request.fields["password_confirmation"] = passwordConfirmation;
      var response = await request.send();
//
      Map<String, dynamic> responseMap;
      response.stream.transform(utf8.decoder).listen((value) {
        responseMap = json.decode(value);
        if (response.statusCode == 200 && responseMap['success'] == true) {
          sharedPrefs.setDevToken(responseMap['data']['token']);
          MyApplication.navigateToReplace(
              context, PendingScreen(token: responseMap['data']['token']));
          Fluttertoast.showToast(
              msg:'Signed Up Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Constants.primaryAppColor,
              textColor: Constants.whiteAppColor,
              fontSize: 16.0);
          // return true;
        } else {
          Fluttertoast.showToast(
              msg: responseMap["message"],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Constants.primaryAppColor,
              textColor: Constants.whiteAppColor,
              fontSize: 16.0);
        }
        // return false;
      });
    } on TimeoutException catch (e) {
      print('Timeout Error: $e');
    } on SocketException catch (e) {
      print('Socket Error: $e');
    } on Error catch (e) {
      print('General Error: $e');
    }
  }

  ///Create new password Cycle
  Future<VerificationResponse?> verify(String phone, code) async {
    try {
      var response = await http.post(
          Uri.parse('${Apikey.replaceAll('/driver', '')}/checkVerification'),
          headers: {
            'Accept': 'application/json',
          },
          body: {
            'phone': phone,
            'code': "$code"
          });
      print("code====> $code");

      print("phone===> 00966$phone");

      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["success"] == true) {
        return VerificationResponse.fromJson(responseMap);
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
    } on Error catch (e) {
      print('General Error: $e');
    }
  }

  ///Create update password Cycle
  Future<UpdatePassResponse?> updatePass(
      String password, String passwordConfirmation, String token) async {
    try {
      var response =
          await http.post(Uri.parse('$Apikey/update_password'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token
      }, body: {
        'password': password,
        'password_confirmation': passwordConfirmation,
      });
      print("password====> $password");
      print("passwordConfirmation====> $passwordConfirmation");
      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["success"] == true) {
        return UpdatePassResponse.fromJson(responseMap);
      } else {
        print("statusCodee====>  ${response.statusCode.toString()}");
        print("response====>  ${response.body.toString()}");
        print(response.reasonPhrase.toString());
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
    } on Error catch (e) {
      print('General Error: $e');
    }
  }

  ///Create forget password Cycle
  Future<ForgetPassResponse?> forgetPass(String phone) async {
    try {
      var response =
          await http.post(Uri.parse('$Apikey/forget_password'), headers: {
        'Accept': 'application/json',
      }, body: {
        'phone': phone,
      });

      print("phone===> 00966$phone");

      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["success"] == true) {
        return ForgetPassResponse.fromJson(responseMap);
      } else {
        print("statusCodee====>  ${response.statusCode.toString()}");
        print("response====>  ${response.body.toString()}");
        print(response.reasonPhrase.toString());
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
    } on Error catch (e) {
      print('General Error: $e');
    }
  }

  ///Create check password Cycle
  Future<CheckPhoneResponse?> checkPhone(String phone) async {
    try {
      var response = await http.post(
          Uri.parse('${Apikey.replaceAll('/driver', '')}/checkPhone'),
          headers: {
            'Accept': 'application/json',
          },
          body: {
            'phone': phone,
          });

      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["success"] == true) {
        final data = CheckPhoneResponse.fromJson(jsonDecode(response.body));
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
    } on Error catch (e) {
      print('General Error: $e');
    }
  }

  ///Driver info Cycle
  Future<DriverInfoModel?> getDriverInfo(String token) async {
    try {
      print(sharedPrefs.token);
      var response = await http.get(
        Uri.parse('$Apikey/driver/user?api_token=$token'),
        headers: {'Accept': 'application/json'},
      );
      print(sharedPrefs.token);
      print(response);
      Map<String, dynamic> responseMap = json.decode(response.body);
      print(responseMap);
      if (response.statusCode == 200 && responseMap["success"] == true) {
        final data = DriverInfoModel.fromJson(jsonDecode(response.body));
        print(data);
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
    } on Error catch (e) {
      print('General Error: $e');
    }
  }
}
