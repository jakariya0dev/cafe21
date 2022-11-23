import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cafe21/cons/app_config.dart';

class InvoiceController{

  var db = FirebaseFirestore.instance;

  String generateInvoiceId(){

    String id, year, month, day, hour, minute, second;
    DateTime date = DateTime.now();
    year = date.year.toString();
    int pMonth = date.month;
    int pDay = date.day;
    int pHour = date.hour;
    int pMinute = date.minute;
    int pSecond = date.second;

    if(pMonth<10) {
      month = pMonth.toString().padLeft(2, '0');
    }else {
      month = pMonth.toString();
    }

    if(pDay<10) {
      day = pDay.toString().padLeft(2, '0');
    }else {
      day = pDay.toString();
    }

    if(pHour<10) {
      hour = pHour.toString().padLeft(2, '0');
    }else {
      hour = pHour.toString();
    }

    if(pMinute<10) {
      minute = pMinute.toString().padLeft(2, '0');
    }else {
      minute = pMinute.toString();
    }

    if(pSecond<10) {
      second = pSecond.toString().padLeft(2, '0');
    }else {
      second = pSecond.toString();
    }


    id = year+month+day+hour+minute+second;
    return id;
  }

  saveInvoiceToServer(invoice, context){
    db.collection(AppConfig.invoiceCollection).doc(invoice.invoiceId).set({
      'customer' : invoice.customer,
      'phone' : invoice.phone,
      'address' : invoice.address,
      'discount' : invoice.discount,
      'discountType' : invoice.discountType,
      'tax' : invoice.tax,
      'waiterName' : invoice.waiterName,
      'waiterId' : invoice.waiterId,
      'table' : invoice.table,
      'dateTime' : invoice.dateTime,
      'paymentMethod' : invoice.paymentMethod,
      'orders' : invoice.orders,
      'subTotal': invoice.subTotal,
      'total' : invoice.total,
      'netBill' : invoice.netBill,
      'biller' : invoice.biller
    }).whenComplete((){

    });
  }

  deleteInvoice(invoiceId) async {
    late String msg;
    msg = await db.collection(AppConfig.invoiceCollection).doc(invoiceId).delete().then((value) => msg = 'Successfully Deleted!', onError: (e) => msg = 'Cant delete: $e');
    return msg;
  }

  Future<List> getFoodData(String type) async {

    var foodData = [];

    await db
        .collection(AppConfig.foodCollection)
        .where('category', isEqualTo: type)
        .get()
        .then((value) {
      for (var element in value.docs) {
        foodData.add({
          'name': element['name'],
          'price': element['price'],
          'id': element.id,
        });
      }
    });

    return foodData;

  }
}