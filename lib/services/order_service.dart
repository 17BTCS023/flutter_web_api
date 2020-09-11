import 'dart:convert';

import 'package:flutter_web_api/models/api_response.dart';
import 'package:flutter_web_api/models/order_for_listing.dart';
import 'package:flutter_web_api/models/order_insert.dart';
import 'package:flutter_web_api/models/single_order.dart';
import 'package:http/http.dart' as http;

class OrderService {

  static const API = "https://l5vqpgr2pd.execute-api.us-west-2.amazonaws.com/dev/api/v1/product/";
  static const header = {
    'Content-Type' : 'application/json'
  };

  Future<APIResponse<List<OrderForListing>>> getOrdersList() async {
    // print('Getting order list from API ... *****************');
    return http.get(API)
        .then((data) {
      // print( " ${data.statusCode}  ... *****************");
      // print('data recieved =  $data');
      if (data.statusCode == 200) { // checking the status code
        final jsonData = json.decode(data
            .body); // the data returned from API, converting it into a list of objects
        // print('data recieved =  $jsonData');
        final orders = <OrderForListing>[];
        for (var item in jsonData) {
          orders.add(OrderForListing.fromJson(item));
        }
        return APIResponse<List<OrderForListing>>(data: orders);
      }
      return APIResponse<List<OrderForListing>>(error: true, errorMessage: 'Some error occurred');
    })
    .catchError((_) => APIResponse<List<OrderForListing>>(error: true, errorMessage: 'Some error occurred, caught in catch block'));
  }

  Future<APIResponse<SingleOrder>> getOrder(int id) async {
    print('Getting Single order from API ... *****************');
    return http.get(API+id.toString())
        .then((data) {
      print( " ${data.statusCode}  ... *****************");
      print('data received =  $data');
      if (data.statusCode == 200) { // checking the status code
        final jsonData = json.decode(data.body); // the data returned from API, converting it into a list of objects
        print('data recieved =  $jsonData');
        return APIResponse<SingleOrder>(data: SingleOrder.fromJson(jsonData));
      }
      return APIResponse<SingleOrder>(error: true, errorMessage: 'Some error occurred');
    })
        .catchError((_) => APIResponse<SingleOrder>(error: true, errorMessage: 'Some error occurred, caught in catch block'));
  }

  // creating a new note
  Future<APIResponse<bool>> createOrder(OrderInsert item) async {
    print('Creating order in API ... *****************');
    return http.post(API,
        headers:{

        },
        body: json.encode(item.toJson())).then((data) {
      print( "status code was:  ${data.statusCode}  ... *****************");
      print('data ka body =  ${data.body}');
      if (data.statusCode == 201) { // checking the status code
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'Some error occurred');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'Some error occurred, caught in catch block'));
  }

}

