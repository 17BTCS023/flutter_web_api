import 'dart:core';

class OrderForListing{

  int id;
  String name;
  double price;
  String description;
  String image;
  String url;
  int views;
  int total_order;
  int total_revenue;
  String status;
  DateTime date_created;

  OrderForListing({
      this.id,
      this.name,
      this.price,
      this.description,
      this.image,
      this.url,
      this.views,
      this.total_order,
      this.total_revenue,
      this.status,
      this.date_created });

}