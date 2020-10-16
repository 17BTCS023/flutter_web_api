import 'package:flutter/cupertino.dart';

class LoginObject{
  String userName;
  String email;
  String password;

  LoginObject(
      {
        // @required this.id,
        @required this.userName,
        @required this.email,
        @required this.password,
      }
      );

  Map<String,dynamic> toJson() {
    return{
      "username": userName,
      "email": email,
      "password": password,
    };
  }
}