import 'package:cloud_firestore/cloud_firestore.dart';


class AdminDashboardController {

  var db = FirebaseFirestore.instance;

  // Food Data Manipulation

  addNewFoodData(productData) async {
    late bool isSuccessful;
    await db
        .collection('food-list')
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
        .collection('food-list')
        .doc(docId)
        .update(productData)
        .then((value) => msg = 'Successfully updated!',
            onError: (e) => msg = "Error updating document $e");

    return msg;
  }

  deleteFoodData(docId, context) async {
    late String msg;
    await db
        .collection('food-list')
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
        .collection('waiter-list')
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
        .collection('waiter-list')
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
        .collection('waiter-list')
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

  addNewCategoryName({required name}) async {
    late bool isSuccessful;
    await db
        .collection('category-list')
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
        .collection('category-list')
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
        .collection('category-list')
        .doc(id)
        .delete()
        .then((value) => isSuccessful = true, onError: (e) {
      print(e);
      return isSuccessful = false;
    });

    return isSuccessful;
  }

  addTestCategoryName() async {
    late bool isSuccessful;
    await db
        .collection('category-list')
        .doc('test-category')
        .set({'name': 'Test category'}).then((value) => isSuccessful = true, onError: (e) {
      isSuccessful = false;
      print(e);
    });

    return isSuccessful;
  }

}
