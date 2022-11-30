import 'package:cafe21/cons/app_color.dart';
import 'package:cafe21/controller/auth_controller.dart';
import 'package:cafe21/views/create_cafe_admin.dart';
import 'package:cafe21/views/dashboard_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cafe21/cons/enums.dart';
import 'package:cafe21/controller/common_function.dart';
import 'package:cafe21/controller/connection_checker.dart';

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
  String radioValue = UserRole.user.name;

  @override
  initState() {
    init();
    super.initState();
  }

  init() async {
    ConnectionChecker().checkInternetConnection(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      body: SafeArea(
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: height * 0.15),
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
                                    child: const Icon(
                                      Icons.clear,
                                      color: Colors.purple,
                                    )),
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
                                    child: Icon(
                                      isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.purple,
                                    )),
                                hintStyle: const TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.w100),
                                focusColor: Colors.deepPurple,
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.deepPurple, width: 1.5))),
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 10),
                          RadioListTile(
                            contentPadding: EdgeInsets.zero,
                            isThreeLine: false,
                            title: const Text('User', style: TextStyle(fontWeight: FontWeight.bold),),
                            value: UserRole.user.name,
                            groupValue: radioValue,
                            onChanged: (value) {
                              setState(() {
                                radioValue = value.toString();
                              });
                            },
                          ),
                          RadioListTile(
                            contentPadding: EdgeInsets.zero,
                            isThreeLine: false,
                            title: const Text('Admin', style: TextStyle(fontWeight: FontWeight.bold),),
                            value: UserRole.admin.name,
                            groupValue: radioValue,
                            onChanged: (value) {
                              setState(() {
                                radioValue = value.toString();
                              });
                            },
                          ),
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
                                    onPressed: loginToAccount,
                                    child: const Text(
                                      'Log in',
                                      style: TextStyle(color: Colors.white),
                                    )),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Or'),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CreateCafeAdmin()));
                      },
                      child: const Text(
                        'Create admin account',
                        style: TextStyle(color: Colors.purple, fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Lato'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        resetAdminPassword();
                      },
                      child: const Text(
                        'Reset admin password',
                        style: TextStyle(color: Colors.purple, fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Lato'),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: InkWell(
                onTap: () => CommonFunction().showAboutDialog(context),
                child: const CircleAvatar(
                    radius: 16,
                    child: Icon(Icons.question_mark, size: 20,)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  loginToAccount() async {

    bool emailValid = CommonFunction.emailValidator(emailController.text);

    if (emailController.text.isEmpty) {
      CommonFunction().showSnackBar('Enter your email', context);
    }
    else if (!emailValid) {
      CommonFunction().showSnackBar('Email is not valid', context);
    }
    else if (passwordController.text.isEmpty) {
      CommonFunction().showSnackBar('Enter your password', context);
    }
    else if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      CommonFunction()
          .showSnackBar('No internet!\nCheck internet connection', context);
    }
    else if(radioValue == UserRole.user.name){

              isLoginButtonPressed = !isLoginButtonPressed;
              setState(() {});
              bool isSuccessful = await AuthController().userLogin(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                  context
              );
              if(isSuccessful) {

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const DashBoard()));
              }
              else {
                isLoginButtonPressed = !isLoginButtonPressed;
                setState(() {});
              }
    }
    else if(radioValue == UserRole.admin.name){

          isLoginButtonPressed = !isLoginButtonPressed;
          setState(() {});
          bool isSuccessful = await AuthController().adminLogin(
              emailController.text.trim(),
              passwordController.text.trim(),
              context
          );
          if(isSuccessful) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const DashBoard()));
          }
          else {
            isLoginButtonPressed = !isLoginButtonPressed;
            setState(() {});
          }
        }
  }

  void resetAdminPassword() {

      TextEditingController resetEmailController = TextEditingController();
      String errorText = '';

      showDialog(context: context, builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.blue.shade50,
            title: const Center(child: Text('Reset Admin Password', style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w600),)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Enter admin email, an email for reset admin password will be sent', style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w500, fontSize: 14), textAlign: TextAlign.center,),
                const SizedBox(height: 16),
                TextField(
                  controller: resetEmailController,
                  decoration: InputDecoration(
                      errorText: errorText,
                      hintText: 'admin@mail.com',
                      hintStyle: TextStyle(color: Colors.grey.shade300),
                      border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white

                  ),
                ),
              ],
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
                  onPressed: () async {

                    if (resetEmailController.text.isEmpty) {
                      errorText = 'Enter your email';
                      setState(() {});
                    }
                    // else if (resetEmailValid==false) {
                    //   errorText = 'Email is not valid';
                    //   setState(() {});
                    // }
                    else if (connectivityResult != ConnectivityResult.mobile &&
                        connectivityResult != ConnectivityResult.wifi) {
                      errorText = 'No internet!\nCheck internet connection';
                      setState(() {});
                    }
                    else{
                      Navigator.pop(context);
                      await AuthController().resetRequestForAdminPassword(resetEmailController.text.trim(), context);
                    }

                  }, child: const Text('Submit')),
              ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
                  onPressed: () {
                Navigator.pop(context);
              }, child: const Text('Cancel'))
            ],
          );
        },);
      });
  }

}
