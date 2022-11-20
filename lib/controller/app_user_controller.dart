import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cafe21/model/data.dart';

class AppUserController{

  var db = FirebaseFirestore.instance;

  deleteUser(index) async {

    bool isSuccessful = false;
    await db.collection('app-users').doc(allAppUserData[index]['user-email']).delete().then((value){
      isSuccessful = true;
    }, onError: (e){
      isSuccessful = false;
      print(e);
    });
    return isSuccessful;
  }
  updateUser(index){
    print('ud: $index');
  }
}