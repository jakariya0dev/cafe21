
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cafe21/cons/app_config.dart';


class AdminDashboardController {

  var db = FirebaseFirestore.instance;

  // Food Data Manipulation

  addNewFoodData(productData) async {
    late bool isSuccessful;
    await db
        .collection(AppConfig.foodCollection)
        .doc()
        .set(productData)
        .then((value) => isSuccessful = true,
            onError: (e){
              // print(e);
              return isSuccessful = false;
            });
    return isSuccessful;
  }

  updateFoodData(productData, docId) async {
    String msg = '';
    await db
        .collection(AppConfig.foodCollection)
        .doc(docId)
        .update(productData)
        .then((value) => msg = 'Successfully updated!',
            onError: (e) => msg = "Error updating document $e");

    return msg;
  }

  deleteFoodData(docId, context) async {
    late String msg;
    await db
        .collection(AppConfig.foodCollection)
        .doc(docId)
        .delete()
        .then((doc) {
      msg = 'Successfully Deleted!';
    }, onError: (e) {
      return msg = 'Error: $e';
    });
    return msg;
  }

  // Waiter Data Manipulation

  addNewWaiterData(waiterData) async {
    late bool isSuccessful;
    await db
        .collection(AppConfig.waiterCollection)
        .doc()
        .set(waiterData).then((value) => isSuccessful = true, onError: (e){
          // print(e);
          return isSuccessful = false;
    });
    return isSuccessful;
  }

  updateWaiterData(waiterList) async {
    late bool isSuccessful;
    await db
        .collection(AppConfig.waiterCollection)
        .doc(waiterList['docId'])
        .update({
      'name': waiterList['name'],
      'phone': waiterList['phone'],
      'email': waiterList['email'],
      'nid': waiterList['nid'],
      'address': waiterList['address'],
      'image': waiterList['image']
    }).then((value) => isSuccessful = true,
            onError: (e){
      // print(e);
      return isSuccessful = false;
    });

    return isSuccessful;
  }

  deleteWaiterData(docName) async {
    late bool isSuccessful;
    await db
        .collection(AppConfig.waiterCollection)
        .doc(docName)
        .delete()
        .then(
      (doc) {
        isSuccessful = true;
      },
      onError: (e) {
        // print(e);
        return isSuccessful = false;
      }
    );
    return isSuccessful;
  }

  // Category Data Manipulation

  addNewCategoryName({required name}) async {
    late bool isSuccessful;
    await db
        .collection(AppConfig.categoryCollection)
        .doc()
        .set({'name': name}).then((value) => isSuccessful = true, onError: (e) {
      isSuccessful = false;
      // print(e);
    });

    return isSuccessful;
  }

  updateCategoryName({required id, required name}) async {
    late bool isSuccessful;
    await db
        .collection(AppConfig.categoryCollection)
        .doc(id)
        .set({'name': name}).then((value) => isSuccessful = true, onError: (e) {
      isSuccessful = false;
      // print(e);
    });

    return isSuccessful;
  }

  deleteCategory(id) async {

    late bool isSuccessful;
    List docsIdBasedOnCategory = [];

    /*
    First getting all product doc
    based on category id
    which will be deleted
    */

    // First getting all doc of product based on category id
    await db.collection(AppConfig.foodCollection).where('category', isEqualTo: id).get().then((value) {
        for(DocumentSnapshot doc in value.docs){
          docsIdBasedOnCategory.add(doc.id);
        }
    });

    // delete all doc of product based on category id
    for(String docId in docsIdBasedOnCategory){
      await db.collection(AppConfig.foodCollection).doc(docId).delete();
    }

    // delete category doc
    await db
        .collection(AppConfig.categoryCollection)
        .doc(id)
        .delete()
        .then((value) => isSuccessful = true, onError: (e) {
      // print(e);
      return isSuccessful = false;
    });

    return isSuccessful;

  }

  addTestData() async {

    await db
        .collection(AppConfig.categoryCollection)
        .doc('test-category')
        .set({'name': 'Test category'});

    await db
        .collection(AppConfig.waiterCollection)
        .doc('test-waiter')
        .set({
          'name' : 'Jack',
          'phone' : '0123456789',
          'email' : 'xyz@mail.com',
          'nid' : '123456789',
          'address' : 'CDC road',
          'image' : ''
        });

  }

}
