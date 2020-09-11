import 'dart:core';

class SingleOrder{

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

  SingleOrder({
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

  factory SingleOrder.fromJson(Map < String, dynamic> item){
    return SingleOrder(
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
  }

}