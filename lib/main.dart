import 'package:flutter/material.dart';
import 'package:flutter_web_api/services/order_service.dart';
import 'package:flutter_web_api/views/order_list.dart';
import 'package:flutter_web_api/views/registration.dart';
import 'package:get_it/get_it.dart';
import 'models/order_for_listing.dart';

// In every page we need to create a service instance manually, to avoid that repetition, will be using the get_it package
// To use the package, we need to initialize the setupLocator function so that
void setupLocator(){
  // GetIt is a static instance, it is available everywhere in the app
  GetIt.instance.registerLazySingleton(() => OrderService());  // We are registering the LazySingleton (LS), since we just need a single le
  // To consume the LS ->  ***GetIt.I<OrderService>();***
  print('Inside setupLoactor ... *****************');


}
void main() {
  setupLocator();  // calling the setupLocator function
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Registration(),

));
}

