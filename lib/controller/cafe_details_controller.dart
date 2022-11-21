import 'package:cafe21/controller/common_function.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CafeDetailsController{

  var db = FirebaseFirestore.instance;

  updateCafeDetails(Map<String, dynamic> cafeMap, context){

    bool isSuccessful = false;
    db.collection('cafe-details').doc('admin').update(cafeMap).then((value){
      isSuccessful = true;
    }, onError: (e){
      CommonFunction().showSnackBar('Error: $e', context);
    });

    return isSuccessful;
  }
}