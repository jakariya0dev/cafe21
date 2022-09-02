import 'package:cafe21/pages/dashboard_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String role = 'manager';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
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
                    Container(
                      height: height * 0.6,
                      color: Colors.red,
                      // color: Colors.red.shade50.withOpacity(0.1),
                    ),
                  ],
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const CircleAvatar(
                        radius: 32,
                        backgroundImage: AssetImage('assets/images/logo.png')),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      padding: const EdgeInsets.all(24),
                      // height: height * 0.5,
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
                            'Login Account',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                                fontSize: 20),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          TextField(
                            controller: phoneController,
                            style: const TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.w500),
                            decoration: const InputDecoration(
                                hintText: 'Phone Number',
                                hintStyle: TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.w300),
                                focusColor: Colors.deepPurple,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.deepPurple, width: 1.5))),
                            keyboardType: TextInputType.phone,
                          ),
                          TextField(
                            controller: phoneController,
                            style: const TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.w500),
                            decoration: const InputDecoration(
                                hintText: 'Your Password',
                                hintStyle: TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.w300),
                                focusColor: Colors.deepPurple,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.deepPurple, width: 1.5))),
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          RadioListTile(
                              title: const Text('Manager'),
                              dense: true,
                              isThreeLine: false,
                              toggleable: true,
                              selected: true,
                              value: 'manager',
                              groupValue: role,
                              onChanged: (value){
                                role = value.toString();
                                setState(() {

                                });
                            print('Manager');
                          }),
                          RadioListTile(
                              title: const Text('Admin'),
                              dense: true,
                              value: 'admin',
                              groupValue: role,
                              onChanged: (value){
                                role = value.toString();
                                setState(() {

                                });
                            print("Amdin");
                          }),
                          MaterialButton(
                            minWidth: double.maxFinite,
                            color: Colors.deepPurple,
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const DashBoard(),));
                            },
                            shape: const StadiumBorder(),
                            child: const Text(
                              'Log in',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                    // const SizedBox(height: 24,),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 42.0, vertical: 32),
                      child: Text(
                        'If you don\'t have an account or forgot it please call our helpline',
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
