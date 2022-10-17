import 'package:cafe21/cons/app_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cafe21/model/invoice_model.dart';
import 'package:cafe21/model/data.dart';

class DashboardController{

  FirebaseFirestore db = FirebaseFirestore.instance;

  getAllSellsData() async {

    await db.collection(AppConfig.dbName).doc('invoices').collection('invoice-details').get().then((value){
      for(var element in value.docs){
        InvoiceModel invoiceModel = InvoiceModel(
            invoiceId: element.id,
            customer: element['customer'],
            phone: element['phone'],
            discount: element['discount'],
            tax: element['tax'],
            waiterName: element['waiterName'],
            waiterId: element['waiterId'],
            table: element['table'],
            dateTime: element['dateTime'],
            orders: element['orders'],
            address: element['address'],
            discountType: element['discountType'],
            paymentMethod : element['paymentMethod'],
            subTotal: element['subTotal'],
            total: element['total'],
            netBill: element['netBill']
        );
        allSellsData.add(invoiceModel);
      }
      allSellsData = allSellsData.reversed.toList();
    });

  }

  getAllFood() async {

    await db.collection(AppConfig.dbName).doc('foods').collection('products').get().then((value) {

      for(var doc in value.docs){
        allFoodsData.add({
          'id' : doc.id,
          'name' : doc['name'],
          'type' : doc['category'],
          'description' : doc['description'],
          'price' : doc['price']
        });
      }});

  }

  getAllFoodCategory()async{

    await db.collection(AppConfig.dbName).doc('foods').collection('food-category').doc('category').get().then((value) {
      allCategoryData = value['names'];
    });
  }

  getAllWaiter() async {

    await db.collection(AppConfig.dbName).doc('users').collection('waiters').get().then((value) {

      for(var item in value.docs){
        allWaiterData.add({
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

  }

}