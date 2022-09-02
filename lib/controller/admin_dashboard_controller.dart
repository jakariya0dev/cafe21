import 'package:cafe21/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AdminDashboardController{

  var db = FirebaseFirestore.instance;

  addNewFoodData({name, category, description, price, context}) async {
    
    await db.collection(Const.dbName).doc('foods').collection('products').doc().set({
      'name' : name,
      'category' : category,
      'description' : description,
      'price' : price
    }).then((value) => (value) {

    });
  }

  addNewWaiterData({id, name, phone, email, nid, address, image, context}) async {

    await db.collection(Const.dbName).doc('users').collection('waiters').doc(phone).set({
      'id' : id,
      'name' : name,
      'phone' : phone,
      'email' : email,
      'nid' : nid,
      'address' : address,
      'image' : image
    });
  }

  addNewCategoryName({name, context}) async {

    await db.collection(Const.dbName).doc('foods').collection('food-category').doc('category').update({
      'names' : FieldValue.arrayUnion([name]),
    }).then((value) => (value) {

    });
  }

  getCategoryList() async {

    var categoryList = await db.collection(Const.dbName).doc('foods').collection('food-category').doc('category').get();
    return categoryList['names'];
  }

  getProductData() async {
    List data = [];
    await db.collection(Const.dbName).doc('foods').collection('products').get().then((value) {

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

  getWaiterData() async {

    List waiterList = [];

    await db.collection(Const.dbName).doc('users').collection('waiters').get().then((value) {

      for(var item in value.docs){
        waiterList.add({
          'docId' : item.id,
          'id' : item['id'],
          'name' : item['name'],
          'phone' : item['phone'],
          'email' : item['email'],
          'address' : item['address'],
          'image' : item['image']
        });
      }

    });

    return waiterList;
  }

  deleteCategory(name) async {
    late String msg;
    await db.collection(Const.dbName).doc('foods').collection('food-category').doc('category').update({
        'names' : FieldValue.arrayRemove([name])
    }).then((value) => msg = 'Successfully Deleted!', onError: (e) => msg = 'Cant delete: $e');

    return msg;
  }

  deleteFoodData(docName, context) async {

    late String msg;
    await db.collection(Const.dbName).doc('foods').collection('products').doc(docName).delete().then(
          (doc){
            msg = 'Successfully Deleted!';
          },
      onError: (e){
        msg = 'Cant delete: $e';
      },
    );
    return msg;
  }

  deleteWaiterData(docName, context) async {

    late String msg;
    await db.collection(Const.dbName).doc('users').collection('waiters').doc(docName).delete().then(
          (doc){
        msg = 'Successfully Delete!';
      },
      onError: (e){
        msg = 'Cant delete: $e';
      },
    );
    return msg;
  }

}