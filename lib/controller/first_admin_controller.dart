

import 'package:cafe21/controller/common_function.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/data.dart';

class FirstAdminController{

  var db = FirebaseFirestore.instance;

  createAdminAccount({email, password, cafeDetails, context}) async {

    bool isSuccessful = false;

   await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value){
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
}