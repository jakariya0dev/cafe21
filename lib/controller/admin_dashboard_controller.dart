import 'package:cafe21/cons/app_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/data.dart';

class AdminDashboardController {

  var db = FirebaseFirestore.instance;

  // Food Data Manipulation
  getProductData(category) async {
    List data = [];
    await db
        .collection(AppConfig.dbName)
        .doc('foods')
        .collection('products')
        .where(
          'category',
          isEqualTo: category,
        )
        .get()
        .then((value) {
      for (var doc in value.docs) {
        data.add({
          'docId': doc.id,
          'name': doc['name'],
          'type': doc['category'],
          'description': doc['description'],
          'price': doc['price']
        });
      }
    });

    return data;
  }

  addNewFoodData(productData) async {
    late bool isSuccessful;
    await db
        .collection(AppConfig.dbName)
        .doc('foods')
        .collection('products')
        .doc()
        .set(productData)
        .then((value) => isSuccessful = true,
            onError: (e){
              print(e);
              return isSuccessful = false;
            });
    return isSuccessful;
  }

  updateFoodData(productData, docId) async {
    String msg = '';
    await db
        .collection(AppConfig.dbName)
        .doc('foods')
        .collection('products')
        .doc(docId)
        .update(productData)
        .then((value) => msg = 'Successfully updated!',
            onError: (e) => msg = "Error updating document $e");

    return msg;
  }

  deleteFoodData(docId, context) async {
    late String msg;
    await db
        .collection(AppConfig.dbName)
        .doc('foods')
        .collection('products')
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
  getWaiterData() async {
    List waiterList = [];

    await db
        .collection(AppConfig.dbName)
        .doc('users')
        .collection('waiters')
        .get()
        .then((value) {
      for (var item in value.docs) {
        waiterList.add({
          'docId': item.id,
          'id': item['id'],
          'name': item['name'],
          'phone': item['phone'],
          'email': item['email'],
          'nid': item['nid'],
          'address': item['address'],
          'image': item['image']
        });
      }
    });

    return waiterList;
  }

  addNewWaiterData(waiterData) async {
    late bool isSuccessful;
    await db
        .collection(AppConfig.dbName)
        .doc('users')
        .collection('waiters')
        .doc(waiterData['phone'])
        .set(waiterData).then((value) => isSuccessful = true, onError: (e){
          print(e);
          return isSuccessful = false;
    });
    return isSuccessful;
  }

  updateWaiterData(waiterList) async {
    late bool isSuccessful;
    await db
        .collection(AppConfig.dbName)
        .doc('users')
        .collection('waiters')
        .doc(waiterList['docId'])
        .update({
      'id': waiterList['id'],
      'name': waiterList['name'],
      'phone': waiterList['phone'],
      'email': waiterList['email'],
      'nid': waiterList['nid'],
      'address': waiterList['address'],
      'image': waiterList['image']
    }).then((value) => isSuccessful = true,
            onError: (e){
      print(e);
      return isSuccessful = false;
            });

    return isSuccessful;
  }

  deleteWaiterData(docName) async {
    late bool isSuccessful;
    await db
        .collection(AppConfig.dbName)
        .doc('users')
        .collection('waiters')
        .doc(docName)
        .delete()
        .then(
      (doc) {
        isSuccessful = true;
      },
      onError: (e) {
        print(e);
        return isSuccessful = false;
      }
    );
    return isSuccessful;
  }

  // Category Data Manipulation
  getCategoryList() async {
    var categoryList = await db
        .collection(AppConfig.dbName)
        .doc('foods')
        .collection('food-category')
        .doc('category')
        .get();
    return categoryList['names'];
  }

  addNewCategoryName({required name}) async {
    late bool isSuccessful;
    await db
        .collection(AppConfig.dbName)
        .doc('foods')
        .collection('food-category')
        .doc()
        .set({'name': name}).then((value) => isSuccessful = true, onError: (e) {
      isSuccessful = false;
      print(e);
    });

    return isSuccessful;
  }

  updateCategoryName({required id, required name}) async {
    late bool isSuccessful;
    await db
        .collection(AppConfig.dbName)
        .doc('foods')
        .collection('food-category')
        .doc(id)
        .set({'name': name}).then((value) => isSuccessful = true, onError: (e) {
      isSuccessful = false;
      print(e);
    });

    return isSuccessful;
  }

  deleteCategory(id) async {
    late bool isSuccessful;
    await db
        .collection(AppConfig.dbName)
        .doc('foods')
        .collection('food-category')
        .doc(id)
        .delete()
        .then((value) => isSuccessful = true, onError: (e) {
      print(e);
      return isSuccessful = false;
    });

    return isSuccessful;
  }

  getAppUserData() async {
    allAppUserData.clear();
    await db.collection('app-users').get().then((value) {
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
