import 'package:cafe21/controller/common_function.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CafeDetailsController{

  var db = FirebaseFirestore.instance;


  updateCafeDetails(Map<String, dynamic> cafeMap, context) async {

    bool isSuccessful = false;
    await db.collection('cafe-details').doc('admin').update(cafeMap).then((value){
      isSuccessful = true;
    }, onError: (e){
      CommonFunction().showSnackBar('Error: $e', context);
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
    await db.collection('developer-details').doc('details').get().then((doc) async {
      if(!doc.exists){
        await db.collection('developer-details').doc('details').set(developerDetails);
      }
    });


    // return isSuccessful;
  }

}