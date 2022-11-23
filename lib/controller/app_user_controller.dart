import 'package:cafe21/cons/app_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cafe21/model/data.dart';

class AppUserController{

  var db = FirebaseFirestore.instance;

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
}