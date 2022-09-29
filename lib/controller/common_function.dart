import 'package:flutter/material.dart';

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

  saveDemoInvoice(){
    // DateTime dateTime = DateTime.now();
    // var year = dateTime.year;
    // var month = dateTime.month;
    // var hour = dateTime.hour;
    // var second = dateTime.second;
    // var ms = dateTime.millisecond;
    //
    //   var db = FirebaseFirestore.instance;
    //   db.collection(AppConfig.dbName).doc('invoices').collection('invoice-details').doc('20220801000000').set({
    //     'customer' : 'ABC ${dateTime.second}',
    //     'phone' : ms.toString(),
    //     'address' : month.toString(),
    //     'discount' : hour.toString(),
    //     'discountType' : '%',
    //     'tax' : month.toString(),
    //     'waiterName' : 'Jack',
    //     'waiterId' : '150',
    //     'table' : hour,
    //     'dateTime' : dateTime,
    //     'paymentMethod' : 'Online Payment',
    //     'orders' : [],
    //     'subTotal': '140',
    //     'total' : '130',
    //     'netBill' : '155'
    //   });
  }
}

