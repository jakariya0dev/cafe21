
import 'package:cafe21/controller/common_function.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cafe21/model/data.dart';
import 'package:cafe21/cons/enums.dart';

class CreateAdminController{

  var db = FirebaseFirestore.instance;

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
}