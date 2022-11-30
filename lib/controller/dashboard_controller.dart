import 'package:cafe21/cons/app_config.dart';
import 'package:cafe21/cons/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cafe21/model/invoice_model.dart';
import 'package:cafe21/model/data.dart';
import 'package:flutter/material.dart';

class DashboardController{

  FirebaseFirestore db = FirebaseFirestore.instance;

  static String titleForData = 'Daily Sells Data';
  static double totalTax = 0;
  static double totalWithTax = 0;
  static double totalWithoutTax = 0;
  static double totalDue = 0;
  static List unpaidInvoice = [];

  // for calculating most selling things and waiter
  static Map <String, int> countMostSellingFood = {};
  static Map <String, int> countMostServingPerson = {};

  getAllSellsData() async {

    await db.collection(AppConfig.invoiceCollection).get().then((value){
      for(var element in value.docs){
        InvoiceModel invoiceModel = InvoiceModel(
            invoiceId: element.id,
            customer: element['customer'],
            phone: element['phone'],
            discount: element['discount'],
            tax: element['tax'],
            waiterId: element['waiterId'],
            table: element['table'],
            dateTime: element['dateTime'],
            orders: element['orders'],
            address: element['address'],
            discountType: element['discountType'],
            paymentMethod : element['paymentMethod'],
            subTotal: element['subTotal'],
            total: element['total'],
            netBill: element['netBill'],
            biller: element['biller']
        );
        allSellsData.add(invoiceModel);
      }
      allSellsData = allSellsData.reversed.toList();
    });

  }

  getAllFood() async {

    await db.collection('food-list').get().then((value) {

      for(var doc in value.docs){
        allFoodsData.add({
          'id' : doc.id,
          'name' : doc['name'],
          'category' : doc['category'],
          'description' : doc['description'],
          'price' : doc['price']
        });
      }});

  }

  getAllFoodCategory()async{

    await db.collection('category-list').get().then((value) {
      for (var doc in value.docs){
          allCategoryData.add({
            'id' : doc.id,
            'name': doc['name']
          });
      }
    });
    

  }

  getAllWaiter() async {

    await db.collection('waiter-list').get().then((value) {

      allWaiterData.clear();

      for(var item in value.docs){
        allWaiterData.add({
          'docId' : item.id,
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
  
  getCafeDetails() async {

    var data = await db.collection('cafe-details').doc('admin').get();

    cafeDetailsData.addAll({
      'cafe-address' : data['cafe-address'],
      'cafe-name' : data['cafe-name'],
      'cafe-phone' : data['cafe-phone'],
    });

  }

  weeklyData(invoiceDat) async {
    List filteredInvoiceData = [], sellsData = [];
    DateTime dayBeforeAWeek = DateTime.now().subtract(const Duration(days: 1));

    sellsData = await DashboardController().getAllSellsData();
    filteredInvoiceData = sellsData.where((element) => element.dateTime.toDate().isAfter(dayBeforeAWeek)).toList();
    return filteredInvoiceData;
  }
  
  getDeveloperInfo() async {
    await db.collection('developer-details').doc('details').get().then((value){
      developerInfo.addAll({
        'name' : value['name'],
        'web' : value['web'],
        'cell' : value['cell']
      });
    });
  }

  getDataByDate(context) async {

    String idForCompare, year, month, day;

    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    );

    if(date != null){
      year = date.year.toString();
      int pMonth = date.month;
      int pDay = date.day;


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

      idForCompare = year+month+day;
      allSellsDataFiltered = allSellsData.where((element) => element.invoiceId.toString().substring(0, 8) == idForCompare).toList();
      calculationInvoiceData();
      titleForData = 'Sells Data of $day-$month-$year';

    }

  }

  getDailyData() async {

    String idForCompare, year, month, day;
    DateTime date = DateTime.now();


    year = date.year.toString();
    int pMonth = date.month;
    int pDay = date.day;

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

    idForCompare = year+month+day;

    allSellsDataFiltered = allSellsData.where((element) => element.invoiceId.toString().substring(0, 8) == idForCompare).toList();
    calculationInvoiceData();
    titleForData = 'Daily Sells Data';
  }

  getWeeklyData(){
    var sevenDaysAgoFromNow = DateTime.now().subtract(const Duration(days: 7));
    allSellsDataFiltered = allSellsData.where((element) => element.dateTime.toDate().isAfter(sevenDaysAgoFromNow)).toList();
    calculationInvoiceData();
    titleForData = 'Weekly Sells Data';
    // setState(() {});
  }

  getMonthlyData(){
    var now = DateTime.now();
    var thirtyDaysAgoFromNow = DateTime(now.year, now.month-1, now.day);
    allSellsDataFiltered = allSellsData.where((element) => element.dateTime.toDate().isAfter(thirtyDaysAgoFromNow)).toList();
    calculationInvoiceData();
    titleForData = 'Monthly Sells Data';
    // setState(() {});
  }

  getAllTotalData(){
    allSellsDataFiltered = allSellsData;
    calculationInvoiceData();
    titleForData = 'Total Sells Data';
    calculationInvoiceData();
  }

  calculationInvoiceData(){

    totalWithTax = 0;
    totalWithoutTax = 0;

    for (var item in allSellsDataFiltered) {

      totalWithTax = totalWithTax + double.parse(item.netBill);
      totalWithoutTax = totalWithoutTax + double.parse(item.total);
    }
    // setState(() {});
    // print(totalWithTax);
    // print(totalWithoutTax);
  }

  calculateMostSells(){

    List totalFoodIdFromInvoice = [];
    List totalWaiterIdFromInvoice = [];

    Map <String, int> countMostSellingFoodBeforeSort = {};
    Map <String, int> countMostServingPersonBeforeSort = {};

    // getting all food id and waiter name from invoices
    for (var invoice in allSellsData) {

      totalWaiterIdFromInvoice.add(invoice.waiterId);

      for(var item in invoice.orders){
        totalFoodIdFromInvoice.add(item['id']);
      }

    }

    // SUM of food orders
    for (var foodId in totalFoodIdFromInvoice){
      countMostSellingFoodBeforeSort[foodId] = (countMostSellingFoodBeforeSort[foodId] ?? 0) + 1;
    }

    // SUM of waiter orders
    for (var waiterName in totalWaiterIdFromInvoice){
      countMostServingPersonBeforeSort[waiterName] = (countMostServingPersonBeforeSort[waiterName] ?? 0) + 1;
    }

    // reversed the map ex:321
    countMostSellingFood = Map.fromEntries(
        countMostSellingFoodBeforeSort.entries.toList()..sort((e1, e2) => e2.value.compareTo(e1.value)));
    countMostServingPerson = Map.fromEntries(
        countMostServingPersonBeforeSort.entries.toList()..sort((e1, e2) => e2.value.compareTo(e1.value)));

  }

  calculateUnPaidInvoice() {

    unpaidInvoice.clear();
    totalDue = 0;
    unpaidInvoice = allSellsDataFiltered.where((e) => e.paymentMethod == paymentMethodList[3]).toList();
    for(var item in unpaidInvoice){
      totalDue += double.parse(item.netBill);
    }

  }

}