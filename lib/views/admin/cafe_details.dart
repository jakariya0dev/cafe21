import 'package:cafe21/controller/auth_controller.dart';
import 'package:cafe21/controller/common_function.dart';
import 'package:cafe21/model/data.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../cons/app_color.dart';
import '../../controller/cafe_details_controller.dart';
import '../../controller/connection_checker.dart';
import '../../controller/dashboard_controller.dart';

class CafeDetails extends StatefulWidget {
  const CafeDetails({Key? key}) : super(key: key);

  @override
  State<CafeDetails> createState() => _CafeDetailsState();
}

class _CafeDetailsState extends State<CafeDetails> {
  
  int selectedCategoryButtonIndex = 0;
  TextEditingController cafeNameController =
      TextEditingController(text: cafeDetailsData['cafe-name']);
  TextEditingController cafeAddressController =
      TextEditingController(text: cafeDetailsData['cafe-address']);
  TextEditingController cafePhoneController =
      TextEditingController(text: cafeDetailsData['cafe-phone']);

  // <-- start --> variable for container decoration
  EdgeInsets containerPadding =
      const EdgeInsets.only(left: 0, right: 0, top: 4);
  BoxDecoration containerDecoration = BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.circular(10));
  double containerGap = 16;

// <-- end --> variable for container decoration

  @override
  initState() {
    init();
    super.initState();
  }

  init() async {
    await ConnectionChecker().checkInternetConnection(() {
      setState(() {});
    });
  }

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
                    child: Text(
                      'Cafe name',
                      style: TextStyle(
                          fontFamily: 'Lato', color: Colors.grey.shade600),
                    ),
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
                    child: Text(
                      'Cafe address',
                      style: TextStyle(
                          fontFamily: 'Lato', color: Colors.grey.shade600),
                    ),
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
                    child: Text(
                      'Cafe Phone',
                      style: TextStyle(
                          fontFamily: 'Lato', color: Colors.grey.shade600),
                    ),
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
              onTap: updateData,
              child: Container(
                width: double.maxFinite,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                    child: Text(
                  'UPDATE CAFE DETAILS',
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
                onTap: updateAdminEmail,
                child: const Text(
                  'Change Admin Email',
                  style: TextStyle(
                      color: Colors.purple, fontWeight: FontWeight.w600),
                )),
            const SizedBox(height: 15),
            InkWell(
                onTap: updateAdminPassword,
                child: const Text(
                  'Reset Admin Password',
                  style: TextStyle(
                      color: Colors.purple, fontWeight: FontWeight.w600),
                ))
          ],
        ),
      ),
    );
  }

  updateData() async {

    if (cafeNameController.text.isEmpty) {
      CommonFunction().showSnackBar('Enter Cafe Name', context);
    } else if (cafeAddressController.text.isEmpty) {
      CommonFunction().showSnackBar('Enter Cafe Address', context);
    } else if (cafePhoneController.text.isEmpty) {
      CommonFunction().showSnackBar('Enter Cafe Phone', context);
    } else if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      CommonFunction()
          .showSnackBar('No internet!\nCheck internet connection', context);
    } else {
      CommonFunction().showLoadingIndicatorWithTitle(
          title: 'Updating Data', context: context);
      Map<String, dynamic> cafeMap = {
        'cafe-name': cafeNameController.text,
        'cafe-address': cafeAddressController.text,
        'cafe-phone': cafePhoneController.text,
      };
      bool isSuccessful =
          await CafeDetailsController().updateCafeDetails(cafeMap, context);
      if (isSuccessful) {
        cafeDetailsData.clear();
        DashboardController().getCafeDetails();
        Navigator.pop(context);
        setState(() {});
        CommonFunction().showSnackBar('Successfully updated', context);
      } else {
        Navigator.pop(context);
      }
    }
  }

  updateAdminEmail() {
    TextEditingController oldEmailController = TextEditingController();
    TextEditingController newEmailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    String oldEmailErrorText = '', newEmailErrorText = '', adminPasswordErrorText = '';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              // backgroundColor: Colors.purple.shade50,
              title: const Text(
                'Update Admin Email',
                style: TextStyle(
                    color: Colors.purple, fontSize: 16, fontFamily: 'Roboto'),
              ),
              contentPadding: const EdgeInsets.all(16),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: containerPadding,
                    decoration: containerDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 0, top: 10),
                          child: Text(
                            'Old Email Address',
                            style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 12,
                                color: Colors.grey.shade600),
                          ),
                        ),
                        TextField(
                          controller: oldEmailController,
                          decoration: InputDecoration(
                              hintText: 'Type admin mail',
                              hintStyle: TextStyle(color: Colors.grey.shade400),
                              errorText: oldEmailErrorText,
                              border: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 2,
                                  )),
                              // prefixIcon: const Icon(Icons.mail_outline_outlined),
                              suffixIcon: InkWell(
                                onTap: () {
                                  oldEmailController.clear();
                                  setState(() {});
                                },
                                child: const Icon(Icons.clear),
                              )),
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
                          padding: const EdgeInsets.only(left: 0, top: 10),
                          child: Text(
                            'New Email Address',
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Roboto',
                                color: Colors.grey.shade600),
                          ),
                        ),
                        TextField(
                          controller: newEmailController,
                          decoration: InputDecoration(
                              hintText: 'Type new email',
                              errorText: newEmailErrorText,
                              hintStyle: TextStyle(color: Colors.grey.shade400),
                              border: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 2,
                                  )),
                              // prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: InkWell(
                                onTap: () {
                                  newEmailController.clear();
                                  setState(() {});
                                },
                                child: const Icon(Icons.clear),
                              )),
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
                          padding: const EdgeInsets.only(left: 0, top: 10),
                          child: Text(
                            'Admin Password',
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Roboto',
                                color: Colors.grey.shade600),
                          ),
                        ),
                        TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                              hintText: 'Type admin password',
                              hintStyle: TextStyle(color: Colors.grey.shade400),
                              errorText: adminPasswordErrorText,
                              border: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 2,
                                  )),
                              // prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: InkWell(
                                onTap: () {
                                  passwordController.clear();
                                  setState(() {});
                                },
                                child: const Icon(Icons.clear),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                MaterialButton(
                    color: const Color(AppColor.box4),
                    onPressed: () async {
                      bool isOldEmailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(oldEmailController.text);

                      bool isNewEmailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(newEmailController.text);

                      if (oldEmailController.text.isEmpty) {
                        oldEmailErrorText = 'Can not empty!';
                        newEmailErrorText = '';
                        adminPasswordErrorText = '';
                        setState(() {});
                      }
                      else if (isOldEmailValid == false) {
                        oldEmailErrorText = 'Not a valid mail!';
                        newEmailErrorText = '';
                        adminPasswordErrorText = '';
                        setState(() {});
                      }
                      else if (newEmailController.text.isEmpty) {
                        oldEmailErrorText = '';
                        newEmailErrorText = 'Can not empty!';
                        adminPasswordErrorText = '';
                        setState(() {});
                      }
                      else if (isNewEmailValid == false) {
                        newEmailErrorText = 'Not a valid mail!';
                        oldEmailErrorText = '';
                        adminPasswordErrorText = '';
                        setState(() {});
                      }
                      else if (passwordController.text.isEmpty) {
                        oldEmailErrorText = '';
                        newEmailErrorText = '';
                        adminPasswordErrorText = 'Can not empty!';
                        setState(() {});
                      }
                      else if (connectivityResult != ConnectivityResult.mobile &&
                          connectivityResult != ConnectivityResult.wifi) {

                        oldEmailController.clear();
                        newEmailController.clear();
                        passwordController.clear();

                        Navigator.pop(context);
                        showSnackbar('No internet connection');
                      }
                      else {
                        
                        Navigator.pop(context);
                        showLoadingIndicator('Updating Admin Mail');
                        bool isSuccessful = await AuthController().updateAdminEmail(
                            oldEmail: oldEmailController.text,
                            password: passwordController.text,
                            newEmail: newEmailController.text,
                            context: context);
                        if(isSuccessful){
                          popContext();
                          showSnackbar('Successfully updated');
                        }else{
                          popContext();
                        }
                      }
                    },
                    child: const Text(
                      'UPDATE',
                      style: TextStyle(color: Colors.white),
                    )),
                MaterialButton(
                    color: const Color(AppColor.box5),
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'CANCEL',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            );
          },
        );
      },
    );
  }

  updateAdminPassword() {
    
    TextEditingController emailController = TextEditingController();
    TextEditingController oldPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    String emailErrorText = '', newPasswordErrorText = '', oldPasswordErrorText = '';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text(
              'Update Admin Password',
              style: TextStyle(
                  color: Colors.purple, fontSize: 16, fontFamily: 'Roboto'),
            ),
            contentPadding: const EdgeInsets.all(16),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: containerPadding,
                  decoration: containerDecoration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0, top: 10),
                        child: Text(
                          'Admin Email Address',
                          style: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 12,
                              color: Colors.grey.shade600),
                        ),
                      ),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                            hintText: 'Enter admin mail here',
                            errorText: emailErrorText,
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            border: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2,
                                )),
                            // prefixIcon: const Icon(Icons.mail_outline_outlined),
                            suffixIcon: InkWell(
                              onTap: () {
                                emailController.clear();
                                setState(() {});
                              },
                              child: const Icon(Icons.clear),
                            )),
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
                        padding: const EdgeInsets.only(left: 0, top: 10),
                        child: Text(
                          'Old Password',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Roboto',
                              color: Colors.grey.shade600),
                        ),
                      ),
                      TextField(
                        controller: oldPasswordController,
                        decoration: InputDecoration(
                            hintText: 'Type old password',
                            errorText: oldPasswordErrorText,
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            border: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2,
                                )),
                            // prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: InkWell(
                              onTap: () {
                                oldPasswordController.clear();
                                setState(() {});
                              },
                              child: const Icon(Icons.clear),
                            )),
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
                        padding: const EdgeInsets.only(left: 0, top: 10),
                        child: Text(
                          'New Password',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Roboto',
                              color: Colors.grey.shade600),
                        ),
                      ),
                      TextField(
                        controller: newPasswordController,
                        decoration: InputDecoration(
                            hintText: 'Type new password',
                            errorText: newPasswordErrorText,
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            border: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2,
                                )),
                            // prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: InkWell(
                              onTap: () {
                                newPasswordController.clear();
                                setState(() {});
                              },
                              child: const Icon(Icons.clear),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              MaterialButton(
                  color: const Color(AppColor.box4),
                  onPressed: () async {

                    bool isEmailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(emailController.text);

                    if (emailController.text.isEmpty) {
                      emailErrorText = 'Can not empty!';
                      newPasswordErrorText = '';
                      oldPasswordErrorText = '';
                      setState(() {});
                    }
                    else if (isEmailValid == false) {
                      emailErrorText = 'Not a valid mail!';
                      newPasswordErrorText = '';
                      oldPasswordErrorText = '';
                      setState(() {});
                    }
                    else if (oldPasswordController.text.isEmpty) {
                      emailErrorText = '';
                      oldPasswordErrorText = 'Can not empty!';
                      newPasswordErrorText = '';
                      setState(() {});
                    }
                    else if (newPasswordController.text.isEmpty) {
                      emailErrorText = '';
                      oldPasswordErrorText = '';
                      newPasswordErrorText = 'Can not empty!';
                      setState(() {});
                    }
                    else if (connectivityResult != ConnectivityResult.mobile &&
                        connectivityResult != ConnectivityResult.wifi) {

                      emailController.clear();
                      newPasswordController.clear();
                      oldPasswordController.clear();

                      Navigator.pop(context);
                      showSnackbar('No internet connection');
                    }
                    else {

                      Navigator.pop(context);
                      showLoadingIndicator('Updating Admin Mail');
                      bool isSuccessful = await AuthController().updateAdminPassword(
                          email: emailController.text.trim(),
                          oldPassword: oldPasswordController.text.trim(),
                          newPassword: newPasswordController.text.trim(),
                          context: context);
                      if(isSuccessful){
                        popContext();
                        showSnackbar('Successfully updated');
                      }else{
                        popContext();
                      }
                    }
                  },
                  child: const Text(
                    'UPDATE',
                    style: TextStyle(color: Colors.white),
                  )),
              MaterialButton(
                  color: const Color(AppColor.box5),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          );
        },);
      },
    );

  }

  showSnackbar(String msg) {
    CommonFunction().showSnackBar(msg, context);
  }

  showLoadingIndicator(String msg) {
    CommonFunction().showLoadingIndicatorWithTitle(context: context, title: msg);
  }
  
  popContext(){
    Navigator.pop(context);
  }

}
