import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../cons/const_string.dart';
import '../views/login_page.dart';

class MyDrawerController{

  userLogOut(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(ConstString.isLogged);
    prefs.remove(ConstString.userRole);
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage(),));

  }
}