import 'package:cafe21/views/dashboard_page.dart';
import 'package:cafe21/views/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import '../cons/const_string.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() async {
    SharedPreferences prefs =  await SharedPreferences.getInstance();
    // print('sp: ${prefs.getString('role')}');
    Future.delayed(const Duration(seconds: 3), () {
     if(prefs.getBool('isLogged') == true){
       Navigator.push(context, MaterialPageRoute(builder: (context) => const DashBoard()));
     }else{
       Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
     }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: const Center(child: Text('Splash Screen'),),
      ),
    );
  }
}
