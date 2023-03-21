
import 'package:cafe21/cons/app_config.dart';
import 'package:cafe21/views/dashboard_page.dart';
import 'package:cafe21/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:cafe21/cons/enums.dart';
import 'package:cafe21/model/data.dart';
import 'on_boarding_page.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    _init();
    super.initState();

  }


  _init() async {

    Future.delayed(const Duration(seconds: 3), () {
      if(prefs?.getBool('isNotFirstInstall') == true){
            if(prefs?.getBool(UserKey.login.name) == true){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const DashBoard()));
            }else{
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
            }

      }else{
            Navigator.push(context, MaterialPageRoute(builder: (context) => const OnBoardingPage()));
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff004aad),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: Center(child: Image.asset('assets/icons/app_icon.png'),),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('Developed By', style: TextStyle(color: Colors.white, fontSize: 10, fontStyle: FontStyle.italic),),
            Text(AppConfig.companyName, style: TextStyle(color: Colors.white, fontFamily: 'Michroma'),),
          ],
        ),
      ),
    );
  }

}
