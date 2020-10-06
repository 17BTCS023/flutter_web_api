import 'dart:convert';

import 'package:flutter_web_api/models/api_response.dart';
import 'package:flutter_web_api/models/order_for_listing.dart';
import 'package:flutter_web_api/models/order_insert.dart';
import 'package:flutter_web_api/models/registration_object.dart';
import 'package:flutter_web_api/models/single_order.dart';
import 'package:http/http.dart' as http;

class UserServices{
  static const API =
      "https://l5vqpgr2pd.execute-api.us-west-2.amazonaws.com/dev/dj-rest-auth/registration/";
  static const header = {'Content-Type': 'application/json'};

  Future<APIResponse<bool>> registerUser(RegistrationObject item) async {
    print('_________________Registering the user___________________________');
    return http
        .post(API, headers: header, body: json.encode(item.toJson()))
        .then((data) {
      print("Status Code =:  ${data.statusCode} ");
      print('Data Body =  ${data.body}');
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(
          error: true, errorMessage: 'Some error occurred');
    }).catchError((_) => APIResponse<bool>(
        error: true,
        errorMessage: 'Some error occurred, caught in catch block'));
  }
}