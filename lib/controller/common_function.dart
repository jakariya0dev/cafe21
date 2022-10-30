import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../cons/app_config.dart';

class CommonFunction{

  showWarningDialog(msg,context){
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: const Text('Warning!'),
        content: Text(msg),
        actions: [
          ElevatedButton(onPressed: () {
            Navigator.pop(context);
          }, child: const Text('Ok'))
        ],
      );
    });
  }

  showLoadingIndicatorWithTitle({required context, required title, message}){
    showDialog(context: context, builder: (context) {
      return AlertDialog(

        content: ListTile(
          leading: const CircularProgressIndicator(),
          title: Text(title),
          subtitle: Text(message ?? 'Please wait.'),
        ),
      );
    });
  }

  saveDemoInvoice(){
    DateTime dateTime = DateTime.now();
    var year = dateTime.year;
    var month = dateTime.month;
    var hour = dateTime.hour;
    var second = dateTime.second;
    var ms = dateTime.millisecond;

    var id = generateInvoiceId();

      var db = FirebaseFirestore.instance;
      db.collection(AppConfig.dbName).doc('invoices').collection('invoice-details').doc(id).set({
        'customer' : 'ABC ${dateTime.second}',
        'phone' : ms.toString(),
        'address' : month.toString(),
        'discount' : hour.toString(),
        'discountType' : '%',
        'tax' : month.toString(),
        'waiterName' : 'Jack',
        'waiterId' : '150',
        'table' : "7",
        'dateTime' : dateTime,
        'paymentMethod' : 'Online Payment',
        'orders' : [],
        'subTotal': '140',
        'total' : '130',
        'netBill' : '155'
      });
  }

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
}

