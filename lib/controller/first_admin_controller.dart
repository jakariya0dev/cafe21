

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirstAdminController{

  var db = FirebaseFirestore.instance;

  createTestManagerAccount() async {

    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: 'abc@mail.com',
        password: '000000',
    );
    await db.collection('app_user').doc().set({
      'email' : 'abc@mail.com',
      'password' : '000000',
    }).onError((error, stackTrace) => print(error));
  }

  saveCafeDetails(Map<String, dynamic> cafeDetails) async {

    bool isSuccessful = false;

    // await prefs.setBool('isCafeDetailsFilled', true);
    // Navigator.push(context, MaterialPageRoute(builder: (context) => const DashBoard(),))
    await db.collection('cafe-details').doc('admin').set(cafeDetails).then((value) => isSuccessful = true, onError: (e) {
      print(e);
    });

    return isSuccessful;
  }
}