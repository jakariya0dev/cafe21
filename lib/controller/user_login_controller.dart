
import 'package:cafe21/controller/common_function.dart';
import 'package:cafe21/model/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cafe21/cons/enums.dart';

class UserLoginController{

    late bool isSuccessful;
    var auth = FirebaseAuth.instance;
    var db = FirebaseFirestore.instance;

    userLogin(email, password, context) async {


      await db.collection('user-list').doc(email).get().then((value) async {
        if(value.exists && value['user-password'] == password){

          await prefs?.setBool(UserRoleKey.isLogged.name, true);
          await prefs?.setString(UserKey.email.name, email);
          await prefs?.setString(UserRoleKey.userRole.name, UserRoleKey.user.name);

        }
        else{
          CommonFunction().showSnackBar('User does not exist', context);
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

}