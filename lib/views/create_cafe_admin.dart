import 'package:cafe21/controller/auth_controller.dart';
import 'package:cafe21/controller/common_function.dart';
import 'package:cafe21/views/dashboard_page.dart';
import 'package:cafe21/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateCafeAdmin extends StatefulWidget {
  const CreateCafeAdmin({Key? key}) : super(key: key);

  @override
  State<CreateCafeAdmin> createState() => _CreateCafeAdminState();
}

class _CreateCafeAdminState extends State<CreateCafeAdmin> {

  late SharedPreferences prefs;

  TextEditingController cafeNameController = TextEditingController();
  TextEditingController cafeAddressController = TextEditingController();
  TextEditingController cafePhoneController = TextEditingController();
  TextEditingController adminEmailController = TextEditingController();
  TextEditingController cafePasswordController = TextEditingController();
  TextEditingController purchaseCodeController = TextEditingController();

  EdgeInsets containerPadding =
      const EdgeInsets.only(left: 0, right: 0, top: 4);
  BoxDecoration containerDecoration = BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.circular(10));
  double containerGap = 16;

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cafe21'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
            onSelected: (value){
              if(value.toString().contains('log-in')){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
              }
            },
            itemBuilder: (context) {
            return [
              const PopupMenuItem(value: 'log-in', child: Text('Log in'))
            ];
          },)
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'You have to fill this data for initialise admin account. All filled are required',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontFamily: 'Lato'),
              ),
              SizedBox(height: containerGap),
              Container(
                padding: containerPadding,
                decoration: containerDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 10),
                      child: Text(
                        'Cafe Name',
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 14,
                            color: Colors.grey.shade600),
                      ),
                    ),
                    TextField(
                      controller: cafeNameController,
                      decoration: InputDecoration(
                          hintText: 'Enter Cafe Name',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.restaurant),
                          suffixIcon: InkWell(
                              onTap: () {
                                cafeNameController.clear();
                                setState(() {});
                              },
                              child: const Icon(Icons.clear))),
                    ),
                  ],
                ),
              ),
              SizedBox(height: containerGap),
              Container(
                padding: containerPadding,
                decoration: containerDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 10),
                      child: Text(
                        'Cafe Address',
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 14,
                            color: Colors.grey.shade600),
                      ),
                    ),
                    TextField(
                      controller: cafeAddressController,
                      decoration: InputDecoration(
                          hintText: 'Enter Cafe Address',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.add_home),
                          suffixIcon: InkWell(
                              onTap: () {
                                cafeAddressController.clear();
                                setState(() {});
                              },
                              child: const Icon(Icons.clear))),
                    ),
                  ],
                ),
              ),
              SizedBox(height: containerGap),
              Container(
                padding: containerPadding,
                decoration: containerDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 10),
                      child: Text(
                        'Cafe Phone',
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 14,
                            color: Colors.grey.shade600),
                      ),
                    ),
                    TextField(
                      controller: cafePhoneController,
                      decoration: InputDecoration(
                          hintText: 'Enter cafe phone',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.phone_android_rounded),
                          suffixIcon: InkWell(
                              onTap: () {
                                cafePhoneController.clear();
                                setState(() {});
                              },
                              child: const Icon(Icons.clear))),
                    ),
                  ],
                ),
              ),
              SizedBox(height: containerGap),
              Container(
                padding: containerPadding,
                decoration: containerDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 10),
                      child: Text(
                        'Admin Email',
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 14,
                            color: Colors.grey.shade600),
                      ),
                    ),
                    TextField(
                      controller: adminEmailController,
                      decoration: InputDecoration(
                          hintText: 'Enter admin email',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.email_outlined),
                          suffixIcon: InkWell(
                              onTap: () {
                                adminEmailController.clear();
                                setState(() {});
                              },
                              child: const Icon(Icons.clear))),
                    ),
                  ],
                ),
              ),
              SizedBox(height: containerGap),
              Container(
                padding: containerPadding,
                decoration: containerDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 10),
                      child: Text(
                        'Admin Password',
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 14,
                            color: Colors.grey.shade600),
                      ),
                    ),
                    TextField(
                      controller: cafePasswordController,
                      decoration: InputDecoration(
                          hintText: 'Enter Admin Password',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: InkWell(
                              onTap: () {
                                cafePasswordController.clear();
                                setState(() {});
                              },
                              child: const Icon(Icons.clear))),
                    ),
                  ],
                ),
              ),
              SizedBox(height: containerGap),
              Container(
                padding: containerPadding,
                decoration: containerDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 10),
                      child: Text(
                        'Purchase Code',
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 14,
                            color: Colors.grey.shade600),
                      ),
                    ),
                    TextField(
                      controller: purchaseCodeController,
                      decoration: InputDecoration(
                          hintText: 'Enter Purchase Code',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.qr_code_sharp),
                          suffixIcon: InkWell(
                              onTap: () {
                                purchaseCodeController.clear();
                                setState(() {});
                              },
                              child: const Icon(Icons.clear))),
                    ),
                  ],
                ),
              ),
              SizedBox(height: containerGap),
              InkWell(
                onTap: saveData,
                child: Container(
                  width: double.maxFinite,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                      child: Text(
                    'Save Data',
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Or'),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                },
                child: const Text('Login to account', style: TextStyle(color: Colors.purple),),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  saveData() async {
    bool isEmailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(adminEmailController.text);

    if (cafeNameController.text.isEmpty) {
      CommonFunction().showSnackBar('Enter Cafe Name', context);
    } else if (cafeAddressController.text.isEmpty) {
      CommonFunction().showSnackBar('Enter Cafe Address', context);
    } else if (cafePhoneController.text.isEmpty) {
      CommonFunction().showSnackBar('Enter Cafe Phone', context);
    } else if (adminEmailController.text.isEmpty) {
      CommonFunction().showSnackBar('Enter Email Address', context);
    } else if (isEmailValid == false) {
      CommonFunction().showSnackBar('Email not valid', context);
    } else if (cafePasswordController.text.isEmpty) {
      CommonFunction().showSnackBar('Enter Admin Password', context);
    } else if (purchaseCodeController.text.isEmpty) {
      CommonFunction().showSnackBar('Enter Purchase Code', context);
    } else {

      CommonFunction().showLoadingIndicatorWithTitle(title: 'Creating Admin Account...', context: context);

      Map<String, dynamic> cafeDetails = {
        'cafe-name': cafeNameController.text,
        'cafe-address': cafeAddressController.text,
        'cafe-phone': cafePhoneController.text,
      };

      bool isSuccessful = await AuthController().createAdminAccount(
          email: adminEmailController.text,
          password: cafePasswordController.text,
          cafeDetails: cafeDetails,
          context: context
      );

      if(isSuccessful){
        await prefs.setBool('isLogged', true);
        Navigator.pop(context);
        // print(isSuccessful);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashBoard()));
      }else{
        // print(isSuccessful);
        Navigator.pop(context);
      }

    }
  }
}
