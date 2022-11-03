import 'package:cafe21/app_color.dart';
import 'package:cafe21/cons/enums.dart';
import 'package:cafe21/controller/admin_dashboard_controller.dart';
import 'package:cafe21/controller/common_function.dart';
import 'package:cafe21/controller/connection_checker.dart';
import 'package:cafe21/controller/dashboard_controller.dart';
import 'package:cafe21/model/data.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../admin_dashboard.dart';

class AddWaiterPage extends StatefulWidget {
  const AddWaiterPage({Key? key,  required this.index}) : super(key: key);
  final int index;
  @override
  State<AddWaiterPage> createState() => _AddWaiterPageState();
}

class _AddWaiterPageState extends State<AddWaiterPage> {

  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nidController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  double containerHeight = 40;
  String msg = '';

  getData() async {
    allWaiterData.clear();
    // allFoodsData.clear();
    // allCategoryData.clear();
    // await dashboardController.getAllFoodCategory();
    // await dashboardController.getAllFood();
    await DashboardController().getAllWaiter();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminDashboard(index: 2)));
      return false;
    },
    child: Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminDashboard(index: 2))),
        ),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add new waiter data',
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.deepPurple, fontSize: 18),
              ),
              const SizedBox(height: 40),
              Container(
                margin: const EdgeInsets.only(bottom: 6),
                height: containerHeight,
                child: TextField(
                  controller: idController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.deepPurple.shade900),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.numbers),
                    hintText: 'Waiter ID',
                    isDense: true,
                    hintStyle: TextStyle(color: Colors.blue.shade300),
                    suffixIcon: InkWell(
                      onTap: () {
                        idController.clear();
                        setState(() {});
                      },
                      child: Icon(
                        Icons.clear,
                        color: Colors.blue.shade300,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                height: containerHeight,
                child: TextField(
                  controller: nameController,
                  style: TextStyle(color: Colors.deepPurple.shade900),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    hintText: 'Waiter name',
                    isDense: true,
                    hintStyle: TextStyle(color: Colors.blue.shade300),
                    suffixIcon: InkWell(
                      onTap: () {
                        nameController.clear();
                        setState(() {});
                      },
                      child: Icon(
                        Icons.clear,
                        color: Colors.blue.shade300,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                height: containerHeight,
                child: TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(color: Colors.deepPurple.shade900),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone_android),
                    hintText: 'Phone number',
                    isDense: true,
                    hintStyle: TextStyle(color: Colors.blue.shade300),
                    suffixIcon: InkWell(
                      onTap: () {
                        phoneController.clear();
                        setState(() {});
                      },
                      child: Icon(
                        Icons.clear,
                        color: Colors.blue.shade300,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                height: containerHeight,
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.deepPurple.shade900),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.mail_outline),
                    hintText: 'Email Address',
                    isDense: true,
                    hintStyle: TextStyle(color: Colors.blue.shade300),
                    suffixIcon: InkWell(
                      onTap: () {
                        emailController.clear();
                        setState(() {});
                      },
                      child: Icon(
                        Icons.clear,
                        color: Colors.blue.shade300,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                height: containerHeight,
                child: TextField(
                  controller: nidController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.deepPurple.shade900),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.web),
                    hintText: 'National id number',
                    isDense: true,
                    hintStyle: TextStyle(color: Colors.blue.shade300),
                    suffixIcon: InkWell(
                      onTap: () {
                        nidController.clear();
                        setState(() {});
                      },
                      child: Icon(
                        Icons.clear,
                        color: Colors.blue.shade300,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                height: 80,
                child: TextField(
                  controller: addressController,
                  style: TextStyle(color: Colors.deepPurple.shade900),
                  maxLines: 15,
                  minLines: 5,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Details Address',
                    labelText: 'Address',
                    isDense: true,
                    hintStyle: TextStyle(color: Colors.blue.shade300),
                    suffixIcon: InkWell(
                      onTap: () {
                        addressController.clear();
                        setState(() {});
                      },
                      child: Icon(
                        Icons.clear,
                        color: Colors.blue.shade300,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                msg,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: MaterialButton(
                      color: const Color(AppColor.box4),
                      onPressed: () {
                        idController.clear();
                        nameController.clear();
                        phoneController.clear();
                        nidController.clear();
                        emailController.clear();
                        addressController.clear();
                      },
                      child: const Text(
                        'CLEAR ALL',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child:  MaterialButton(
                     color: const Color(AppColor.box5),
                     onPressed: () async {
                       if (idController.text.isEmpty) {
                         msg = 'Error: Enter waiter id!';
                         setState(() {});
                       }
                       else if (nameController.text.isEmpty) {
                         msg = 'Error: Name is empty!';
                         setState(() {});
                       }
                       else if (phoneController.text.isEmpty) {
                         msg = 'Error: Enter phone number!';
                         setState(() {});
                       }
                       else if (emailController.text.isEmpty) {
                         msg = 'Error: Email is empty!';
                         setState(() {});
                       }
                       else if (nidController.text.isEmpty) {
                         msg = 'Error: Enter nid number!';
                         setState(() {});
                       }
                       else if (addressController.text.isEmpty) {
                         msg = 'Error: Address is Empty!';
                         setState(() {});
                       }
                       else if (connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
                         CommonFunction().showSnackBar('No internet!\nCheck internet connection', context);
                       }else {
                         bool isSuccessful = await AdminDashboardController().addNewWaiterData({
                           'id': idController.text,
                           'name': nameController.text,
                           'phone': phoneController.text,
                           'email': emailController.text,
                           'nid': nidController.text,
                           'address': addressController.text,
                           'image': '',
                         });
                         if(isSuccessful){
                           idController.clear();
                           nameController.clear();
                           phoneController.clear();
                           nidController.clear();
                           emailController.clear();
                           addressController.clear();
                           getData();
                           CommonFunction().showSnackBar('Successfully Saved', context);
                         }
                       }
                     },
                     child: const Text(
                       'SAVE DATA',
                       style: TextStyle(color: Colors.white),
                     ),
                 ),
                 )
                ],
              )
            ],
          ),
        ),
      ),),
    );
  }

}
