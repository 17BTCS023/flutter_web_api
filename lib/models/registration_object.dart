import 'package:flutter/cupertino.dart';

class RegistrationObject{
  String userName;
  String email;
  String password1;
  String password2;

  RegistrationObject(
      {
        // @required this.id,
        @required this.userName,
        @required this.email,
        @required this.password1,
        @required this.password2
      }
      );

  Map<String,dynamic> toJson() {
    return{
      "username": userName,
      "email": email,
      "password1": password1,
      "password2": password2
    };
  }
}