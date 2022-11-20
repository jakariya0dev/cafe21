import 'package:flutter/material.dart';
import 'package:cafe21/controller/common_function.dart';

import 'package:cafe21/model/data.dart';

class CafeDetails extends StatefulWidget {
  const CafeDetails({Key? key}) : super(key: key);

  @override
  State<CafeDetails> createState() => _CafeDetailsState();
}

class _CafeDetailsState extends State<CafeDetails> {

  int selectedCategoryButtonIndex = 0;
  TextEditingController cafeNameController = TextEditingController(text: cafeDetails['cafe-name']);
  TextEditingController cafeAddressController = TextEditingController(text: cafeDetails['cafe-address']);
  TextEditingController cafePhoneController = TextEditingController(text: cafeDetails['cafe-phone']);
  TextEditingController adminEmailController = TextEditingController(text: cafeDetails['admin-email']);
  TextEditingController cafePasswordController = TextEditingController(text: cafeDetails['admin-password']);
  TextEditingController purchaseCodeController = TextEditingController(text: cafeDetails['purchase-code']);

  EdgeInsets containerPadding =
  const EdgeInsets.only(left: 0, right: 0, top: 4);
  BoxDecoration containerDecoration = BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.circular(10));
  double containerGap = 16;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: containerGap),
              Container(
                padding: containerPadding,
                decoration: containerDecoration,
                child: TextField(
                  controller: cafeNameController,
                  decoration: InputDecoration(
                      hintText: 'Enter Cafe Name',
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.restaurant),
                      suffixIcon: InkWell(
                          onTap: () {
                            cafeNameController.clear();
                            setState(() {});
                          },
                          child: const Icon(Icons.clear))),
                ),
              ),
              SizedBox(height: containerGap),
              Container(
                padding: containerPadding,
                decoration: containerDecoration,
                child: TextField(
                  controller: cafeAddressController,
                  decoration: InputDecoration(
                      hintText: 'Enter Cafe Address',
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.add_home),
                      suffixIcon: InkWell(
                          onTap: () {
                            cafeAddressController.clear();
                            setState(() {});
                          },
                          child: const Icon(Icons.clear))),
                ),
              ),
              SizedBox(height: containerGap),
              Container(
                padding: containerPadding,
                decoration: containerDecoration,
                child: TextField(
                  controller: cafePhoneController,
                  decoration: InputDecoration(
                      hintText: 'Enter Cafe Phone',
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.phone_android_rounded),
                      suffixIcon: InkWell(
                          onTap: () {
                            cafePhoneController.clear();
                            setState(() {});
                          },
                          child: const Icon(Icons.clear))),
                ),
              ),
              SizedBox(height: containerGap),
              Container(
                padding: containerPadding,
                decoration: containerDecoration,
                child: TextField(
                  controller: adminEmailController,
                  decoration: InputDecoration(
                      hintText: 'Enter Email Address',
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.email_outlined),
                      suffixIcon: InkWell(
                          onTap: () {
                            adminEmailController.clear();
                            setState(() {});
                          },
                          child: const Icon(Icons.clear))),
                ),
              ),
              SizedBox(height: containerGap),
              Container(
                padding: containerPadding,
                decoration: containerDecoration,
                child: TextField(
                  controller: cafePasswordController,
                  decoration: InputDecoration(
                      hintText: 'Enter Admin Password',
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: InkWell(
                          onTap: () {
                            cafePasswordController.clear();
                            setState(() {});
                          },
                          child: const Icon(Icons.clear))),
                ),
              ),
              SizedBox(height: containerGap),
              Container(
                padding: containerPadding,
                decoration: containerDecoration,
                child: TextField(
                  controller: purchaseCodeController,
                  decoration: InputDecoration(
                      hintText: 'Enter Your Purchase Code',
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.qr_code_sharp),
                      suffixIcon: InkWell(
                          onTap: () {
                            purchaseCodeController.clear();
                            setState(() {});
                          },
                          child: const Icon(Icons.clear))),
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
              const SizedBox(height: 65),
            ],
          ),
        ),
    );
  }

  saveData(){

    bool isEmailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(adminEmailController.text);

    if(cafeNameController.text.isEmpty){
      CommonFunction().showSnackBar('Enter Cafe Name', context);
    }
    else if(cafeAddressController.text.isEmpty) {
      CommonFunction().showSnackBar('Enter Cafe Address', context);
    }
    else if(cafePhoneController.text.isEmpty){
      CommonFunction().showSnackBar('Enter Cafe Phone', context);
    }
    else if(adminEmailController.text.isEmpty){
      CommonFunction().showSnackBar('Enter Email Address', context);
    }
    else if(isEmailValid == false){
      CommonFunction().showSnackBar('Email not valid', context);
    }
    else if(cafePasswordController.text.isEmpty){
      CommonFunction().showSnackBar('Enter Admin Password', context);
    }
    else if(purchaseCodeController.text.isEmpty){
      CommonFunction().showSnackBar('Enter Purchase Code', context);
    }
    else{
      print("object");
    }

  }

}
