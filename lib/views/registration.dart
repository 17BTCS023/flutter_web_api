import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_api/models/registration_object.dart';
import 'package:flutter_web_api/services/user_services.dart';
import 'package:flutter_web_api/views/login.dart';

import 'order_modify.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController password1Controller = new TextEditingController();
  TextEditingController password2Controller = new TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(25.0),
          child: Center(
            child: Form(
              key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Username",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    TextFormField(
                      controller: password1Controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Password",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    TextFormField(
                      controller: password2Controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Confirm Password",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    RaisedButton(
                      onPressed: (){
                        setState(() {
                          _isLoading = true;
                        });
                        RegisterUser(usernameController.text.toString(),
                            emailController.text.toString(),
                            password1Controller.text.toString(),
                            password2Controller.text.toString());
                      },
                      color:  Colors.blueAccent,
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],

            )
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  RegisterUser(String username,String  email,String password,String confirmPassword )  async {
      RegistrationObject obj = RegistrationObject(userName:username, email: email, password1: password, password2: confirmPassword);
      await UserServices().registerUser(obj);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Login()));
  }
}
