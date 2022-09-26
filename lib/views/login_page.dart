import 'package:cafe21/app_color.dart';
import 'package:cafe21/cons/app_config.dart';
import 'package:cafe21/views/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cons/const_string.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String userRole = 'manager';
  bool isLoginButtonPressed = false;
  SharedPreferences? prefs;
  bool isManagerSelected = true, isAdminSelected  = false;

  @override
  initState() {
    super.initState();
    init();
  }

  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;


    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                child: Column(
                  children: [
                    Container(
                      height: height * 0.4,
                      decoration: const BoxDecoration(
                          color: Colors.blue,
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Color(0xff2B1C9B), Color(0xff583de7)])),
                    ),
                  ],
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     SizedBox(height: height*0.2),
                    Container(
                      padding: const EdgeInsets.all(24),
                      height: height*0.60,
                      width: width * 0.8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.white,
                          boxShadow: const [BoxShadow()]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'User Login',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                                fontSize: 20),
                          ),
                          const SizedBox(height: 32),
                          TextField(
                            controller: emailController,
                            style: const TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                hintText: 'User Email',
                                hintStyle: TextStyle(
                                    color: Colors.deepPurple.shade200,
                                    fontWeight: FontWeight.w300),
                                focusColor: Colors.deepPurple,
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.deepPurple, width: 1.5))),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          TextField(
                            controller: passwordController,
                            style: TextStyle(
                                color: Colors.deepPurple.shade100,
                                fontWeight: FontWeight.w500),
                            decoration: const InputDecoration(
                                hintText: 'Your Password',
                                hintStyle: TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.w100),
                                focusColor: Colors.deepPurple,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.deepPurple, width: 1.5))),
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 32),
                          RadioListTile(
                              title: const Text('Manager', style: TextStyle(fontWeight: FontWeight.w500),),
                              dense: true,
                              isThreeLine: false,
                              toggleable: true,
                              selected: isManagerSelected,
                              value: ConstString.userRoleManager,
                              groupValue: userRole,
                              onChanged: (value) {
                                userRole = ConstString.userRoleManager;
                                isManagerSelected = true;
                                isAdminSelected = false;
                                setState(() {

                                });
                                // print('Manager');
                              }),
                          RadioListTile(
                              title: const Text('Admin', style: TextStyle(fontWeight: FontWeight.bold),),
                              dense: true,
                              selected: isAdminSelected,
                              value: ConstString.userRoleAdmin,
                              groupValue: userRole,
                              onChanged: (value) {
                                userRole = ConstString.userRoleAdmin;
                                isAdminSelected = true;
                                isManagerSelected = false;
                                setState(() {

                                });
                                // print("Admin");
                              }),
                          const Expanded(child: SizedBox()),
                          AnimatedContainer(
                            height: isLoginButtonPressed ? width*0.14 : width*0.11,
                            duration: const Duration(milliseconds: 500),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.deepPurple,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            width: isLoginButtonPressed ? 50 : width,
                            curve: Curves.linear,
                            child: isLoginButtonPressed ? const Center(child: CircularProgressIndicator(color: Colors.white),) : TextButton(
                                onPressed: () {
                                  userLogin();
                                },
                            child: const Text('Log in', style: TextStyle(color: Colors.white),)),)
                        ],
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Padding(
        padding:
        EdgeInsets.symmetric(horizontal: 42.0, vertical: 32),
        child: Text(
          'If you don\'t have an account or forgot it please call our helpline at +8801521466603',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
  warningDialog(msg){
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: const Text('Warning!'),
        content: Text(msg),
        actions: [
          ElevatedButton(onPressed: () {
            isLoginButtonPressed = false;
            setState(() {});
            Navigator.pop(context);
          }, child: const Text('Ok'))
        ],
      );
    });
  }

  // login with firebase auth
  userLogin() async {

    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController.text);

    setState(() {});

      if(emailController.text.isEmpty){
        warningDialog('Enter email address.');
      }
      else if(!emailValid){
        warningDialog('Not valid email address.');
      }
      else if(passwordController.text.isEmpty){
        warningDialog('Enter user password.');
      }
      else{
        isLoginButtonPressed = !isLoginButtonPressed;
        setState(() {});

        try {

          final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text
          );
          if(credential.user?.uid !=null){

            await prefs?.setString(ConstString.userRole, userRole);
            await prefs?.setBool(ConstString.isLogged, true);
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashBoard()));
          }

        } on FirebaseAuthException catch (e) {

          if (e.code == 'user-not-found') {
            warningDialog('No user found for that email.');
          }
          else if (e.code == 'wrong-password') {
            warningDialog('Wrong password provided.');
          }

        }
      }


  }
}
