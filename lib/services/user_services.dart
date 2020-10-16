import 'dart:convert';

import 'package:flutter_web_api/models/api_response.dart';
import 'package:flutter_web_api/models/login_object.dart';
import 'package:flutter_web_api/models/order_for_listing.dart';
import 'package:flutter_web_api/models/order_insert.dart';
import 'package:flutter_web_api/models/registration_object.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserServices{

  var jsonData = null;
  var jsonData2 = null;

  static const API =
      "https://l5vqpgr2pd.execute-api.us-west-2.amazonaws.com/dev/dj-rest-auth/registration/";
  static const header = {'Content-Type': 'application/json'};

  Future<APIResponse<bool>> registerUser(RegistrationObject item) async {
    print('_________________Registering the user___________________________');
    return http
        .post(API, headers: header, body: json.encode(item.toJson()))
        .then((data) async {
      print("Status Code =:  ${data.statusCode} ");
      print('Data Body =  ${data.body}');
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      if (data.statusCode == 201) {
        jsonData2 = json.decode(data.body);

        if(jsonData2['username' == "A user with that username already exists."] ||
        'email' == "A user is already registered with this e-mail address."){
          print('User already registered');
        }
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(
          error: true, errorMessage: 'Some error occurred');
    }).catchError((_) => APIResponse<bool>(
        error: true,
        errorMessage: 'Some error occurred, caught in catch block'));
  }

  Future<APIResponse<bool>> login(LoginObject item) async {
    print('_________________Logging in___________________________');
    return http
        .post("https://l5vqpgr2pd.execute-api.us-west-2.amazonaws.com/dev/dj-rest-auth/login/", headers: header, body: json.encode(item.toJson()))
        .then((data) async {
      print("Status Code =:  ${data.statusCode} ");
      print('Data Body =  ${data.body}');
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      if (data.statusCode == 200) {
        jsonData = json.decode(data.body);
        sharedPreferences.setString("token", jsonData['token']);
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(
          error: true, errorMessage: 'Some error occurred');
    }).catchError((_) => APIResponse<bool>(
        error: true,
        errorMessage: 'Some error occurred, caught in catch block'));
  }

}