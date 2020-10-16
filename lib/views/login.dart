import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_api/models/login_object.dart';
import 'package:flutter_web_api/services/user_services.dart';
import 'package:flutter_web_api/views/forgot_password.dart';
import 'package:flutter_web_api/views/welcome.dart';

import 'order_modify.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController password1Controller = new TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log in"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25.0),
          child: Column(
            children: [
              Center(
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
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                        ),
                        RaisedButton(
                          onPressed: (){
                            setState(() {
                              _isLoading = true;
                            });
                            loginUser(usernameController.text.toString(),
                                emailController.text.toString(),
                                password1Controller.text.toString());
                          },
                          color:  Colors.blueAccent,
                          child: Text(
                            "Log in",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],

                    )
                ),
              ),
              FlatButton(
                textColor: Color(0xFF6200EE),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => ForgotPassword()));

                  // Respond to button press
                },
                child: Text("Forgot Password ?"),
              )
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  loginUser(String username,String  email,String password2 )  async {
    LoginObject obj = LoginObject(userName:username, email: email, password: password2);
    await UserServices().login(obj);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Welcome()));
  }
}

