import 'package:cafe21/cons/app_color.dart';
import 'package:cafe21/cons/enums.dart';
import 'package:cafe21/controller/common_function.dart';
import 'package:cafe21/controller/connection_checker.dart';
import 'package:cafe21/controller/dashboard_controller.dart';
import 'package:cafe21/model/data.dart';
import 'package:cafe21/model/invoice_model.dart';
import 'package:cafe21/views/invoice/invoice_list.dart';
import 'package:cafe21/views/invoice/invoice_print.dart';
import 'package:cafe21/views/invoice/invoice_update.dart';
import 'package:cafe21/widget/invoice_details/build_name_container.dart';
import 'package:cafe21/widget/invoice_details/build_order_item_list.dart';
import 'package:cafe21/widget/invoice_details/build_row_box.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cafe21/controller/invoice_controller.dart';

class InvoiceDetails extends StatefulWidget {
  const InvoiceDetails(
      {Key? key, required this.invoiceData})
      : super(key: key);

  final InvoiceModel invoiceData;

  @override
  State<InvoiceDetails> createState() => _InvoiceDetailsState();
}

class _InvoiceDetailsState extends State<InvoiceDetails> {
  late double netBill, totalAmountAfterDiscount, totalAmount = 0;

  @override
  initState() {
    super.initState();
    ConnectionChecker().checkInternetConnection(() {
      setState(() {});
    });
    _init();
  }

  _init() async {

    for (var i = 0; i < widget.invoiceData.orders.length; i++) {
      totalAmount = totalAmount +
          (double.parse(widget.invoiceData.orders[i]['itemTotal']));
    }
    totalAmountAfterDiscount = totalAmount -
        (totalAmount * (int.parse(widget.invoiceData.discount) / 100));
    netBill = totalAmountAfterDiscount +
        (totalAmountAfterDiscount * (int.parse(widget.invoiceData.tax) / 100));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue.shade800,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: _editInvoice,
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              )),
          IconButton(
              onPressed: _showWarningBeforeDeleteInvoice,
              icon: const Icon(
                Icons.delete_forever,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InvoicePrint(
                              invoiceData: widget.invoiceData
                            )));
              },
              icon: const Icon(
                Icons.print,
                color: Colors.white,
              )),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BuildNameContainer(
                    id: widget.invoiceData.invoiceId,
                    name: widget.invoiceData.customer,
                    phone: widget.invoiceData.phone,
                    waiterId: widget.invoiceData.waiterId,
                    paymentMethod: widget.invoiceData.paymentMethod,
                    date: DateFormat.yMMMd()
                        .add_jm()
                        .format(widget.invoiceData.dateTime.toDate())
                        .toString(),
                    totalAmount: widget.invoiceData.subTotal,
                    totalAmountAfterDiscount: widget.invoiceData.total,
                    netAmount: widget.invoiceData.netBill,
                    address: widget.invoiceData.address,),
                const SizedBox(height: 16),
                BuildBoxRow(
                    discount: widget.invoiceData.discount,
                    discountType: widget.invoiceData.discountType,
                    tax: widget.invoiceData.tax,
                    table: widget.invoiceData.table),
                BuildOrderItemList(
                  orders: widget.invoiceData.orders,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8),
        child: Text('Prepared by: ${widget.invoiceData.biller}', textAlign: TextAlign.center,),
      ),
    );
  }

  _showWarningBeforeDeleteInvoice(){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Are you sure!',
            style: TextStyle(color: Colors.red),
          ),
          content: const Text('This invoice will be deleted.'),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            MaterialButton(
              onPressed: () async {
                Navigator.pop(context);
                if (connectivityResult != ConnectivityResult.mobile &&
                    connectivityResult != ConnectivityResult.wifi) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text('No internet!\nCheck internet connection'),
                    action: SnackBarAction(
                      label: 'Ok',
                      onPressed: () => Navigator.pop(context),
                    ),
                  ));
                }
                else if (prefs?.getString(UserKey.role.name) != UserRole.admin.name) {
                  CommonFunction()
                      .showWarningDialog('Only admin can delete invoice', context);
                }
                else {
                  _deleteInvoice();
                }
              },
              color: const Color(AppColor.box5),
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: const Color(AppColor.box4),
              child: const Text(
                'CANCEL',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  _deleteInvoice() async {

    if(prefs?.get(UserKey.role.name) == UserRole.user.name){
      CommonFunction().showWarningDialog('Only Admin Can Delete Invoices', context);
    }
    else{
      CommonFunction().showLoadingIndicatorWithTitle(context: context, title: 'Deleting...');
      await InvoiceController()
          .deleteInvoice(widget.invoiceData.invoiceId);
      allSellsData.clear(); // from data file
      await DashboardController().getAllSellsData();
      _pop();
      Get.off(()=> const InvoiceList());
    }
  }

  _editInvoice(){
        Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) =>
        InvoiceUpdate(invoiceData: widget.invoiceData),
    ),);
  }

  void _pop() {
    Navigator.pop(context);
  }
}












