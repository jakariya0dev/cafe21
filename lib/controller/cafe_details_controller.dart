import 'package:cafe21/controller/common_function.dart';
import 'package:cafe21/model/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../cons/enums.dart';

class CafeDetailsController{

  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  updateCafeDetails(Map<String, dynamic> cafeMap, context) async {

    bool isSuccessful = false;
    await db.collection('cafe-details').doc('admin').update(cafeMap).then((value){
      isSuccessful = true;
    }, onError: (e){
      CommonFunction().showSnackBar('Error: $e', context);
    });

    return isSuccessful;
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
      print('Error: $e');
    });

    return isSuccessful;
  }
}