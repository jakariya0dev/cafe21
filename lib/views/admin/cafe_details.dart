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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Padding(
                      padding: const EdgeInsets.only(left: 15, top: 10),
                      child: Text('Cafe name', style: TextStyle(fontFamily: 'Lato', color: Colors.grey.shade600),),
                    ),
                    TextField(
                      controller: cafeNameController,
                      decoration: const InputDecoration(
                          hintText: 'Enter Cafe Name',
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.restaurant),
                          ),
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
                      child: Text('Cafe address', style: TextStyle(fontFamily: 'Lato', color: Colors.grey.shade600),),
                    ),
                    TextField(
                      controller: cafeAddressController,
                      decoration: const InputDecoration(
                          hintText: 'Enter Cafe Address',
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.add_home),
                          ),
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
                      child: Text('Cafe Phone', style: TextStyle(fontFamily: 'Lato', color: Colors.grey.shade600),),
                    ),
                    TextField(
                      controller: cafePhoneController,
                      decoration: const InputDecoration(
                          hintText: 'Enter Cafe Phone',
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.phone_android_rounded),
                          ),
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
                        'Update Data',
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
