import 'package:flutter/foundation.dart';
class OrderInsert {
  // int id;
  String name;
  double price;
  String description;
  String image;
  String url;
  int views;
  int total_order;
  int total_revenue;
  String status;

  OrderInsert(
      {
        // @required this.id,
        @required this.name,
        @required this.price,
        @required this.description,
        @required this.image,
        @required this.url,
        @required this.views,
        @required this.total_order,
        @required this.total_revenue,
        @required this.status
      }
      );

  Map<String,dynamic> toJson() {
    return{
      // "id": id,
      "name" : name,
      "price": price,
      "description": description,
      "image": image,
      "url":url,
      "views":views,
      "total_order": total_order,
      "total_revenue": total_revenue,
      "status" : status,
    };
  }

}
