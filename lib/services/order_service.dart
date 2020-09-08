import 'dart:convert';

import 'package:flutter_web_api/models/api_response.dart';
import 'package:flutter_web_api/models/order_for_listing.dart';
import 'package:http/http.dart' as http;

class OrderService {

  static const API = "https://l5vqpgr2pd.execute-api.us-west-2.amazonaws.com/dev/api/v1/product/";

  Future<APIResponse<List<OrderForListing>>> getOrdersList() async {
    print('Getting order list from API ... *****************');
    return http.get(API)
        .then((data) {
      print( " ${data.statusCode}  ... *****************");
      print('data recieved =  $data');
      if (data.statusCode == 200) { // checking the status code
        final jsonData = json.decode(data
            .body); // the data returned from API, converting it into a list of objects
        print('data recieved =  $jsonData');
        final orders = <OrderForListing>[];
        for (var item in jsonData) {
          final order = OrderForListing(
            id: item['id'] ,
            name: item['name'],
            price: item['price'],
            description: item['description'],
            image: item['image'],
            url: item['url'],
            views: item['views'],
            total_order: item['total_order'],
            total_revenue: item['total_revenue'],
            status: item['status'],
            date_created: DateTime.parse(item["date_created"]),
          );
          print('------------------------------------------\n $order  \n---------------------------------------\n');
          orders.add(order);
        }
        return APIResponse<List<OrderForListing>>(data: orders);
      }
      return APIResponse<List<OrderForListing>>(error: true, errorMessage: 'Some error occurred');
    })
    .catchError((_) => APIResponse<List<OrderForListing>>(error: true, errorMessage: 'Some error occurred, caught in catch block'));
  }
}

