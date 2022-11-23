import 'package:cafe21/model/data.dart';
import 'package:cafe21/views/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cafe21/controller/common_function.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cafe21/cons/enums.dart';
import 'package:flutter/material.dart';
import 'package:cafe21/cons/app_config.dart';

class AuthController{

  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;
  late bool isSuccessful;


  getAppUserData() async {

    await db.collection(AppConfig.userCollection).get().then((value) {
      for (var doc in value.docs) {
        allAppUserData.add({
          'user-email': doc['user-email'],
          'user-password': doc['user-password'],
          'user-role': doc['user-role'],
        });
      }
    });
  }

  addNewUser(Map user) async {
    bool isSuccessful = false;
    await db.collection(AppConfig.userCollection).doc(user['user-email']).set({
      'user-email': user['user-email'],
      'user-password': user['user-password'],
      'user-role': user['user-role'],
    }).then((value) {
      isSuccessful = true;
    }, onError: (e) {
      isSuccessful = false;
      print(e);
    });
    return isSuccessful;
  }

  deleteUser(index) async {

    bool isSuccessful = false;
    await db.collection(AppConfig.userCollection).doc(allAppUserData[index]['user-email']).delete().then((value){
      isSuccessful = true;
    }, onError: (e){
      isSuccessful = false;
      print(e);
    });
    return isSuccessful;
  }

  /*
  * Intentionally we didn't direct update here
  * First we add new doc and then delete old one
  * this is why, we login user via doc name which is user email
  * */

  updateUser({required Map newUser, required String oldEmail}) async {
    bool isSuccessful = false;
    await db.collection(AppConfig.userCollection).doc(newUser['user-email']).set({
      'user-email': newUser['user-email'],
      'user-password': newUser['user-password'],
      'user-role': newUser['user-role']
    }).then((value) async {
      isSuccessful = true;
      await db.collection('app-users').doc(oldEmail).delete();
    }, onError: (e) {
      isSuccessful = false;
      print(e);
    });

    return isSuccessful;
  }

  userLogin(email, password, context) async {

    await db.collection('user-list').doc(email).get().then((value) async {
      if(!value.exists){
        CommonFunction().showSnackBar('User does not exist', context);
      }
      else if(value.exists && value['user-password'] != password){
        CommonFunction().showSnackBar('Password does\'t matched', context);
      }
      else if(value.exists && value['user-password'] != password){
        await prefs?.setBool(UserRoleKey.isLogged.name, true);
        await prefs?.setString(UserKey.email.name, email);
        await prefs?.setString(UserRoleKey.userRole.name, UserRoleKey.user.name);
      }
      isSuccessful = true;
    }, onError: (e){
      CommonFunction().showSnackBar('Error: $e', context);
      isSuccessful = false;
    });


    return isSuccessful;
  }

  adminLogin(email, password, context) async {
    late bool isSuccessful;
    try {
      await auth.signInWithEmailAndPassword(
          email: email, password: password).then((userCredential) async {
        // User? user = userCredential.user;
        await prefs?.setString(UserRoleKey.userRole.name, UserRoleKey.userRole.name);
        await prefs?.setBool(UserRoleKey.isLogged.name, true);
        await prefs?.setString(UserKey.email.name, email);
        isSuccessful = true;
      });
    }
    on FirebaseAuthException catch (e) {
      isSuccessful = false;
      if (e.code == 'user-not-found') {
        CommonFunction().showSnackBar('No user found for that email.', context);
      }
      else if (e.code == 'wrong-password') {
        CommonFunction().showSnackBar('Wrong password provided.', context);
      }
    }
    return isSuccessful;
  }

  userLogOut(context) async {


    await FirebaseAuth.instance.signOut();
    prefs?.remove(UserRoleKey.isLogged.name);
    prefs?.remove(UserRoleKey.userRole.name);

    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage(),));

  }

  createAdminAccount({email, password, cafeDetails, context}) async {

    bool isSuccessful = false;

    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value){

      var user = value.user;
      var userEmail = user?.email;
      if(user!=null){
        prefs?.setString(AdminKey.adminUserId.name, user.uid);
      }
      if(userEmail!=null){
        prefs?.setString(AdminKey.adminEmail.name, userEmail);
      }

      prefs?.setString(UserRoleKey.userRole.name, UserRoleKey.admin.name);
      prefs?.setBool(UserRoleKey.isLogged.name, true);
      saveCafeDetails(cafeDetails);
      isSuccessful = true;

    }, onError: (e) {
      isSuccessful = false;
      CommonFunction().showSnackBar('Error: $e', context);
    });

    return isSuccessful;
  }

  saveCafeDetails(Map<String, dynamic> cafeDetails) async {
    await db.collection('cafe-details').doc('admin').set(cafeDetails);
    cafeDetailsData = cafeDetails;
  }


  updateAdminEmail({required String oldEmail, required String password, required String newEmail, required context}) async {

    late bool isSuccessful;

    await auth.signInWithEmailAndPassword(email: oldEmail, password: password).then((value) async {
      var user = value.user;
      await user?.updateEmail(newEmail);
      await prefs?.setString(AdminKey.adminEmail.name, newEmail);
      isSuccessful = true;
    }, onError: (e){
      isSuccessful = false;
      CommonFunction().showSnackBar('Error: $e', context);
    });

    return isSuccessful;
  }

  updateAdminPassword({required String email, required String oldPassword, required String newPassword, required context}) async {
    late bool isSuccessful;

    await auth.signInWithEmailAndPassword(email: email, password: oldPassword).then((value) async {
      var user = value.user;
      await user?.updatePassword(newPassword);
      isSuccessful = true;
    }, onError: (e){
      isSuccessful = false;
      CommonFunction().showSnackBar('Error: $e', context);
    });

    return isSuccessful;
  }

}