
import 'package:flutter/material.dart';
import 'package:flutter_web_api/views/login.dart';
import 'package:flutter_web_api/views/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Welcome extends StatefulWidget {

  @override
  _WelcomeState createState() => _WelcomeState();

}

class _WelcomeState extends State<Welcome> {
  SharedPreferences sharedPreferences;
  @override
  void initState(){
    checkLoginStatus();
  }
  checkLoginStatus() async{
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString('token') == null){
      Navigator.pop(context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title: Text('Logged In'),
      ),
       body: Center(
         child: Container(
          color: Colors.amberAccent,
          child: RaisedButton(
            onPressed: (){
              sharedPreferences.clear();
              sharedPreferences.commit();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Registration()));
            },
              child: Text("Log Out",
              style: TextStyle(
                color: Colors.white,
                backgroundColor: Colors.black,
              ),)
            ,
          ),

      ),
       ),
    );
  }
}
