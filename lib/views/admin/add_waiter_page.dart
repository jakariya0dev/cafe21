import 'package:cafe21/cons/app_color.dart';
import 'package:cafe21/controller/admin_dashboard_controller.dart';
import 'package:cafe21/controller/common_function.dart';
import 'package:cafe21/controller/connection_checker.dart';
import 'package:cafe21/controller/dashboard_controller.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:cafe21/views/admin/admin_dashboard.dart';

class AddWaiterPage extends StatefulWidget {
  const AddWaiterPage({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<AddWaiterPage> createState() => _AddWaiterPageState();
}

class _AddWaiterPageState extends State<AddWaiterPage> {
  // TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nidController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  double containerHeight = 40;
  String errorMsg = '';


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const AdminDashboard(index: 2)));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin area', style: TextStyle(fontSize: 16),),
          leading: BackButton(
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const AdminDashboard(index: 2))),
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
                Image.asset('assets/icons/icon_waiter.png', height: 80, width: 80,),
                const SizedBox(height: 16),
                const Text(
                  'Add new waiter data',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.deepPurple,
                      fontSize: 18,
                    fontFamily: 'Lato'
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  errorMsg,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 16),
               /* Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  height: containerHeight,
                  child: TextField(
                    controller: idController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.deepPurple.shade900),
                    onChanged: (value) {
                      if(value.length>3){
                        errorMsg = 'Waiter id should unique and only 3 digit';
                        setState(() {});
                      }else{
                        errorMsg = '';
                        setState(() {});
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.numbers),
                      hintText: 'Unique Waiter ID',
                      isDense: true,
                      hintStyle: TextStyle(color: Colors.grey.shade400),
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
                ),*/
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
                      hintStyle: TextStyle(color: Colors.grey.shade400),
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
                      hintStyle: TextStyle(color: Colors.grey.shade400),
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
                      hintStyle: TextStyle(color: Colors.grey.shade400),
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
                      hintStyle: TextStyle(color: Colors.grey.shade400),
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
                      hintStyle: TextStyle(color: Colors.grey.shade400),
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
                // const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: MaterialButton(
                        height: 50,
                        color: const Color(AppColor.box4),
                        onPressed: () {
                          // idController.clear();
                          nameController.clear();
                          phoneController.clear();
                          nidController.clear();
                          emailController.clear();
                          addressController.clear();
                          errorMsg = '';
                          setState(() {});
                        },
                        child: const Text(
                          'CLEAR ALL',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MaterialButton(
                        height: 50,
                        color: const Color(AppColor.box5),
                        onPressed: saveNewWaiterData,
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
        ),
      ),
    );
  }

  saveNewWaiterData() async {

    bool isWaiterEmailValid = CommonFunction.emailValidator(emailController.text);

/*    if (idController.text.isEmpty) {
      errorMsg = 'Error: Enter waiter id!';
      setState(() {});
    }
    else if(idController.text.length>3){
      errorMsg = 'Error: Waiter id should unique and only 3 digit';
      setState(() {});
    }
    else if(allWaiterData.contains((e) => e.containsValue(emailController.text))){
      errorMsg = 'Error: Waiter id already used';
      setState(() {});
    }*/

    if (nameController.text.isEmpty) {
      errorMsg = 'Error: Name is empty!';
      setState(() {});
    }
    else if (phoneController.text.isEmpty) {
      errorMsg = 'Error: Enter phone number!';
      setState(() {});
    }
    else if (emailController.text.isEmpty) {
      errorMsg = 'Error: Email is empty!';
      setState(() {});
    }
    else if (!isWaiterEmailValid){
      errorMsg = 'Error: Waiter email not valid';
      setState(() {});
    }
    else if (nidController.text.isEmpty) {
      errorMsg = 'Error: Enter nid number!';
      setState(() {});
    }
    else if (addressController.text.isEmpty) {
      errorMsg = 'Error: Address is Empty!';
      setState(() {});
    }
    else if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      CommonFunction().showSnackBar(
          'No internet!\nCheck internet connection',
          context);
    }
    else {

      CommonFunction().showWarningDialog('Savin Data...', context);
      bool isSuccessful = await AdminDashboardController()
          .addNewWaiterData({
        // 'id': idController.text,
        'name': nameController.text,
        'phone': phoneController.text,
        'email': emailController.text,
        'nid': nidController.text,
        'address': addressController.text,
        'image': '',
      });
      if (isSuccessful) {
        // idController.clear();
        nameController.clear();
        phoneController.clear();
        nidController.clear();
        emailController.clear();
        addressController.clear();
        errorMsg = '';
        Navigator.pop(context);
        setState(() {});
        await DashboardController().getAllWaiter();
        CommonFunction()
            .showSnackBar('Successfully Saved', context);
      }else{
        Navigator.pop(context);
      }
    }
  }
}
