import 'package:cafe21/cons/app_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/invoice_model.dart';

class InvoiceListController{

  var db = FirebaseFirestore.instance;

  Future<List> getTodaysSells() async {

    List <InvoiceModel> invoice = [];

    await db.collection(AppConfig.dbName).doc('invoices').collection('invoice-details').get().then((value){
      for(var element in value.docs){
        InvoiceModel invoiceModel = InvoiceModel(
          invoiceId: element.id,
          customer: element['customer'],
          phone: element['phone'],
          discount: element['discount'],
          tax: element['tax'],
          waiter: element['waiter'],
          table: element['table'],
          dateTime: element['dateTime'],
          orders: element['orders'],
          address: element['address'],
          discountType: element['discountType'],
          paymentMethod : element['paymentMethod']
        );
        invoice.add(invoiceModel);
      }

    });

    return invoice;
  }

  deleteInvoice(invoiceId) async {
    late String msg;
    msg = await db.collection(AppConfig.dbName).doc('invoices').collection('invoice-details').doc(invoiceId).delete().then((value) => msg = 'Successfully Deleted!', onError: (e) => msg = 'Cant delete: $e');
    return msg;
  }
}