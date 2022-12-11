import 'package:cafe21/cons/app_config.dart';
import 'package:cafe21/controller/common_function.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CafeDetailsController{

  var db = FirebaseFirestore.instance;

  updateCafeDetails(Map<String, dynamic> cafeMap, context) async {

    bool isSuccessful = false;
    await db.collection(AppConfig.cafeDetails).doc('admin').update(cafeMap).then((value){
      isSuccessful = true;
    }, onError: (e){
      CommonFunction.showGetXSnackBar('Error!', e.toString());
    });

    return isSuccessful;
  }

  setDeveloperDetails() async {

    Map<String, dynamic> developerDetails = {
      'info' : 'System Developed By',
      'name' : 'Brain Storm 21',
      'web' : 'www.brainstorm21.com',
      'phone' : '+8801521466603'
    };

    // bool isSuccessful = false;
    await db.collection(AppConfig.cafeDetails).doc('details').get().then((doc) async {
      if(!doc.exists){
        await db.collection(AppConfig.cafeDetails).doc('details').set(developerDetails);
      }
    });


    // return isSuccessful;
  }

}