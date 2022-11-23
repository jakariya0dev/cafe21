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

}