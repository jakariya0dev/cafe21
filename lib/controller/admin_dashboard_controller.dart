import 'package:cafe21/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../cons/app_config.dart';


class AdminDashboardController{

  var db = FirebaseFirestore.instance;

  // Food Data Manipulation
  getProductData(category) async {
    List data = [];
    await db.collection(AppConfig.dbName).doc('foods').collection('products').where('category', isEqualTo: category,).get().then((value) {

      for(var doc in value.docs){
        data.add({
          'docId' : doc.id,
          'name' : doc['name'],
          'type' : doc['category'],
          'description' : doc['description'],
          'price' : doc['price']
        });
      }});

    return data;
  }
  addNewFoodData(productData) async {
    
    await db.collection(AppConfig.dbName).doc('foods').collection('products').doc().set(productData).then((value) => (value) {

    });
  }
  updateFoodData(productData, docId) async {

    await db.collection(AppConfig.dbName).doc('foods').collection('products').doc(docId).set(productData).then((value) => (value) {

    });
  }
  deleteFoodData(docName, context) async {

    late String msg;
    await db.collection(AppConfig.dbName).doc('foods').collection('products').doc(docName).delete().then(
          (doc){
        msg = 'Successfully Deleted!';
      },
      onError: (e){
        msg = 'Cant delete: $e';
      },
    );
    return msg;
  }

  // Waiter Data Manipulation
  getWaiterData() async {

    List waiterList = [];

    await db.collection(AppConfig.dbName).doc('users').collection('waiters').get().then((value) {

      for(var item in value.docs){
        waiterList.add({
          'docId' : item.id,
          'id' : item['id'],
          'name' : item['name'],
          'phone' : item['phone'],
          'email' : item['email'],
          'nid' : item['nid'],
          'address' : item['address'],
          'image' : item['image']
        });
      }

    });

    return waiterList;
  }
  addNewWaiterData(waiterData) async {

    await db.collection(AppConfig.dbName).doc('users').collection('waiters').doc(waiterData['phone']).set(waiterData);
  }
  updateWaiterData(waiterList) async {
    late String msg;
    await db.collection(AppConfig.dbName).doc('users').collection('waiters').doc(waiterList['docId']).update({
      'id' : waiterList['id'],
      'name' : waiterList['name'],
      'phone' : waiterList['phone'],
      'email' : waiterList['email'],
      'nid' : waiterList['nid'],
      'address' : waiterList['address'],
      'image' : waiterList['image']
    }).then((value) => msg = 'Successfully Updated!', onError: (e) => msg = 'Cant Update: $e');

    return msg;
  }
  deleteWaiterData(docName) async {

    late String msg;
    await db.collection(AppConfig.dbName).doc('users').collection('waiters').doc(docName).delete().then(
          (doc){
        msg = 'Successfully Delete!';
      },
      onError: (e){
        msg = 'Cant delete: $e';
      },
    );
    return msg;
  }

  // Category Data Manipulation
  getCategoryList() async {

    var categoryList = await db.collection(AppConfig.dbName).doc('foods').collection('food-category').doc('category').get();
    return categoryList['names'];
  }
  addNewCategoryName({name, context}) async {

    await db.collection(AppConfig.dbName).doc('foods').collection('food-category').doc('category').update({
      'names' : FieldValue.arrayUnion([name]),
    }).then((value) => (value) {

    });
  }
  updateCategoryName(categoryList) async {
    late String msg;
    await db.collection(AppConfig.dbName).doc('foods').collection('food-category').doc('category').set({
      'names' : categoryList
    }).then((value) => msg = 'Successfully Updated!', onError: (e) => msg = 'Cant Update: $e');

    return msg;
  }
  deleteCategory(name) async {
    late String msg;
    await db.collection(AppConfig.dbName).doc('foods').collection('food-category').doc('category').update({
        'names' : FieldValue.arrayRemove([name])
    }).then((value) => msg = 'Successfully Deleted!', onError: (e) => msg = 'Cant delete: $e');

    return msg;
  }

}