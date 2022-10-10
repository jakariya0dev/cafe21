import 'package:cafe21/views/dashboard_page.dart';
import 'package:cafe21/views/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    init();
    super.initState();

  }

  init() async {
    SharedPreferences prefs =  await SharedPreferences.getInstance();

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
      backgroundColor: const Color(0xff004aad),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: Center(child: Image.asset('assets/images/sp_logo.png'),),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('Developed By', style: TextStyle(color: Colors.white, fontSize: 10, fontStyle: FontStyle.italic),),
            Text('Brain Storm 21', style: TextStyle(color: Colors.white, fontFamily: 'Michroma'),),
          ],
        ),
      ),
    );
  }
}
