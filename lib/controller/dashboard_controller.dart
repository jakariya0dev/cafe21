import 'package:cafe21/cons/app_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cafe21/model/invoice_model.dart';

class DashboardController{

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List> getSellsData() async {

    List <InvoiceModel> invoices = [];

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
        invoices.add(invoiceModel);
      }

    });

    return invoices;
  }

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