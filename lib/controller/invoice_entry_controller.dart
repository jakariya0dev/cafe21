
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../cons/app_config.dart';
import '../views/invoice/invoice_print.dart';

class InvoiceEntryController{

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
    db.collection(AppConfig.dbName).doc('invoices').collection('invoice-details').doc(invoice.invoiceId).set({
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
      'netBill' : invoice.netBill
    }).whenComplete((){

    });
  }

  Future<List> getFoodData(String type) async {

    var foodData = [];

    await db
        .collection(AppConfig.dbName)
        .doc('foods')
        .collection('products')
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

  getCategoryList() async {

    var categoryList = await db.collection(AppConfig.dbName).doc('foods').collection('food-category').doc('category').get();
    return categoryList['names'];
  }

  getWaiterData() async {

    List waiterList = [];

    await db.collection(AppConfig.dbName).doc('users').collection('waiters').get().then((value) {

      for(var item in value.docs){
        waiterList.add({
          'id' : item['id'],
          'name' : item['name'],
        });
      }

    });

    return waiterList;
  }


}
