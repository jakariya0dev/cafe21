
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:cafe21/cons/const_string.dart';
import 'package:cafe21/views/login_page.dart';

import '../cons/app_config.dart';
import '../cons/enums.dart';
import '../model/data.dart';
import '../model/invoice_model.dart';

class MyDrawerController{


  var db = FirebaseFirestore.instance;

  userLogOut(context) async {


    await FirebaseAuth.instance.signOut();
    prefs?.remove(UserRoleKey.isLogged.name);
    prefs?.remove(UserRoleKey.userRole.name);

    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage(),));

  }

  Future<List> getSellsData() async {

    List <InvoiceModel> invoices = [];
    List <InvoiceModel> reversedInvoices = [];

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
    reversedInvoices = invoices.reversed.toList();
    return reversedInvoices;
  }

  weeklyData(invoiceDat) async {
    List filteredInvoiceData = [], sellsData = [];
    DateTime dayBeforeAWeek = DateTime.now().subtract(const Duration(days: 1));

    sellsData = await getSellsData();
    filteredInvoiceData = sellsData.where((element) => element.dateTime.toDate().isAfter(dayBeforeAWeek)).toList();
    return filteredInvoiceData;
  }
}