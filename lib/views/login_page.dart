import 'dart:async';
import 'package:cafe21/app_color.dart';
import 'package:cafe21/cons/app_config.dart';
import 'package:cafe21/views/dashboard_page.dart';
import 'package:cafe21/views/create_cafe_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cafe21/cons/const_string.dart';
import 'package:cafe21/model/user_model.dart';
import '../controller/common_function.dart';
import '../controller/connection_checker.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoginButtonPressed = false;
  SharedPreferences? prefs;

  // String userRole = 'manager';
  bool isPasswordVisible = true;

  @override
  initState() {
    init();
    super.initState();
  }

  init() async {
    prefs = await SharedPreferences.getInstance();
    ConnectionChecker().checkInternetConnection((){
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                    SizedBox(height: height * 0.25),
                    Container(
                      padding: const EdgeInsets.all(24),
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
                              suffix: InkWell(
                                  onTap: () {
                                    emailController.clear();
                                    setState(() {});
                                  },
                                  child: const Icon(Icons.clear, color: Colors.purple,)),
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
                          const SizedBox(height: 16),
                          TextField(
                            controller: passwordController,
                            obscureText: isPasswordVisible,
                            style: TextStyle(
                                color: Colors.deepPurple.shade100,
                                fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                                hintText: 'Your Password',
                                suffix: InkWell(
                                    onTap: () {
                                      isPasswordVisible = !isPasswordVisible;
                                      setState(() {});
                                    },
                                    child: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.purple,)),
                                hintStyle: const TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.w100),
                                focusColor: Colors.deepPurple,
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.deepPurple, width: 1.5))),
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 42),
                          AnimatedContainer(
                            height: 50,
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.deepPurple,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            width: isLoginButtonPressed ? 50 : width,
                            curve: Curves.linear,
                            child: isLoginButtonPressed
                                ? const Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.white),
                                  )
                                : TextButton(
                                    onPressed: () {
                                      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
                                        userLogin();
                                      } else{
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: const Text('No internet!\nCheck internet connection'), action: SnackBarAction(
                                          label: 'close',
                                          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                                        ),));
                                      }

                                    },
                                    child: const Text(
                                      'Log in',
                                      style: TextStyle(color: Colors.white),
                                    )),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Or'),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateCafeAdmin()));
                      },
                      child: const Text('Create admin account', style: TextStyle(color: Colors.purple),),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.only(left: 42.0, right: 42, top: 10, bottom: 32),
        child: Text(
          'If you don\'t have an account or forgot it please call our helpline at +8801521466603',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Roboto'
          ),
        ),
      ),
    );
  }

  warningDialog(msg) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Warning!'),
            content: Text(msg),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    isLoginButtonPressed = false;
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: const Text('Ok'))
            ],
          );
        });
  }

  // login with firebase auth
  userLogin() async {

    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text);

    setState(() {});

    if (emailController.text.isEmpty) {
      warningDialog('Enter email address.');
    } else if (!emailValid) {
      warningDialog('Not valid email address.');
    } else if (passwordController.text.isEmpty) {
      warningDialog('Enter user password.');
    }
    else if (connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
      CommonFunction().showSnackBar('No internet!\nCheck internet connection', context);
    }
    else {
      isLoginButtonPressed = !isLoginButtonPressed;
      setState(() {});

      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        if (credential.user?.uid != null) {
          // UserModel user = await getUserData(emailController.text);
          // await prefs?.setString(ConstString.userRole, user.userRole);
          // await prefs?.setString(ConstString.userMail, user.mail);
          await prefs?.setBool(ConstString.isLogged, true);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const DashBoard()));
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          warningDialog('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          warningDialog('Wrong password provided.');
        }
      }
    }
  }

  Future<UserModel> getUserData(String? uid) async {
    var value = await FirebaseFirestore.instance
        .collection(AppConfig.dbName)
        .doc('users')
        .collection('all-users')
        .doc(uid)
        .get();
    UserModel user = UserModel(
        id: value['id'],
        name: value['name'],
        mail: value['mail'],
        phone: value['phone'],
        userRole: value['user-role']);

    return user;
  }
}
