import 'package:cafe21/controller/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:cafe21/controller/common_function.dart';
import 'package:cafe21/controller/connection_checker.dart';
import 'package:cafe21/model/data.dart';
import 'admin_dashboard.dart';

class UpdateAppUser extends StatefulWidget {
  const UpdateAppUser({Key? key, required this.user}) : super(key: key);
  final Map user;

  @override
  State<UpdateAppUser> createState() => _UpdateAppUserState();
}

class _UpdateAppUserState extends State<UpdateAppUser> {
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  final List<String> _userRoleList = ['Manager', 'Cashier', 'Waiter', 'Other'];
  String _selectedUserRole = 'Select Role';

  // <-Start-> variable for container decoration
  EdgeInsets containerPadding =
  const EdgeInsets.only(left: 0, right: 0, top: 4);
  BoxDecoration containerDecoration = BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.circular(10));
  double containerGap = 16;

  // <-End-> variable for container decoration

  @override
  initState() {
    _init();
    super.initState();
  }

  _init() async {

    userEmailController.text = widget.user['user-email'];
    userPasswordController.text = widget.user['user-password'];
    _selectedUserRole = widget.user['user-role'];
    ConnectionChecker().checkInternetConnection(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const AdminDashboard(index: 3)));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Update user',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/user_profile.png', height: 80, width: 80,),
                  const SizedBox(height: 16),
                  const Text(
                    'User Profile',
                    style: TextStyle(
                        color: Colors.purple,
                        fontSize: 20,
                        fontFamily: 'Lato'),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: containerPadding,
                    decoration: containerDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 10),
                          child: Text(
                            'Email Address',
                            style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 12,
                                color: Colors.grey.shade600),
                          ),
                        ),
                        TextField(
                          controller: userEmailController,
                          decoration: const InputDecoration(
                              hintText: 'Enter mail here',
                              border: InputBorder.none,
                              prefixIcon:
                              Icon(Icons.mail_outline_outlined),
                              // suffixIcon: InkWell(
                              //   onTap: () {
                              //     userEmailController.clear();
                              //     setState(() {});
                              //   },
                              //   child: const Icon(Icons.clear),
                              // )),
                        ),)
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
                            'User Password',
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Roboto',
                                color: Colors.grey.shade600),
                          ),
                        ),
                        TextField(
                          controller: userPasswordController,
                          decoration: const InputDecoration(
                              hintText: 'Type password here',
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.lock_outline),
                              // suffixIcon: InkWell(
                              //   onTap: () {
                              //     userPasswordController.clear();
                              //     setState(() {});
                              //   },
                              //   child: const Icon(Icons.clear),
                              // )),
                        ),)
                      ],
                    ),
                  ),
                  SizedBox(height: containerGap),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 15, top: 10, bottom: 10, right: 15),
                    decoration: containerDecoration,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'User Role',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Roboto',
                                color: Colors.grey.shade600),
                          ),
                        ),
                        const SizedBox(width: 16),
                        DropdownButton(
                          hint: Text(_selectedUserRole),
                          items: _userRoleList
                              .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                              .toList(),
                          onChanged: (value) {
                            _selectedUserRole = value.toString();
                            setState(() {});
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  InkWell(
                    onTap: updateUserData,
                    child: Container(
                      width: double.maxFinite,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                          child: Text(
                            'UPDATE USER DATA',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Business logic
  var db = FirebaseFirestore.instance;

  updateUserData() async {
    bool emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(userEmailController.text);

    if (userEmailController.text.isEmpty) {
      CommonFunction.showGetXSnackBar('Warning!', 'User mail can\'t empty');
    }
    else if (emailValid == false) {
      CommonFunction.showGetXSnackBar('Warning!', 'Not valid email');
    }
    else if (userPasswordController.text.isEmpty) {
      CommonFunction.showGetXSnackBar('Warning!', 'User password can\'t empty');
    }
    else if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      CommonFunction.showGetXSnackBar('No internet!', 'Check internet connection');
    }
    else {
      CommonFunction().showLoadingIndicatorWithTitle(
          context: context, title: 'Creating ew user');
      bool isSuccessful = await AuthController().updateUser(newUser: {
        'user-email' : userEmailController.text,
        'user-password' : userPasswordController.text,
        'user-role' : _selectedUserRole,
      }, oldEmail: widget.user['user-email']);
      if(isSuccessful){
        allAppUserData.clear();
        await AuthController().getAppUserData();
        _pop();
        CommonFunction.showGetXSnackBar('Message!', 'Successfully updated');
      }
      else{
        _pop();
        CommonFunction.showGetXSnackBar('Message!', 'Failed to update');
      }
    }

  }

  void _pop() {
    Navigator.pop(context);
  }

}
