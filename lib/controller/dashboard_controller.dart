import 'package:cafe21/cons/app_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardController{

  FirebaseFirestore db = FirebaseFirestore.instance;

  getAllFood()async{
    List food = [];

    await db.collection(AppConfig.dbName).doc('foods').collection('products').get().then((value) {
      for(var item in value.docs){
        food.add(item);
      }
    });
    // print('dc ${food.length}');
    return food;
  }

  getAllFoodCategory()async{
    List category = [];

    await db.collection(AppConfig.dbName).doc('foods').collection('food-category').doc('category').get().then((value) {
    category = value['names'];
    });
    // print('dc ${food.length}');
    return category;
  }


  getAllWaiter() async {
    List waiterList = [];

    await db.collection(AppConfig.dbName).doc('users').collection('waiters').get().then((value) {
      for(var item in value.docs){
        waiterList.add(item);
      }
    });
    print('dc ${waiterList.length}');
    return waiterList;
  }
}