import 'package:cafe21/cons/app_color.dart';
import 'package:cafe21/cons/const.dart';
import 'package:cafe21/cons/enums.dart';
import 'package:cafe21/controller/common_function.dart';
import 'package:cafe21/controller/connection_checker.dart';
import 'package:cafe21/controller/dashboard_controller.dart';
import 'package:cafe21/model/data.dart';
import 'package:cafe21/views/invoice/invoice_details.dart';
import 'package:cafe21/views/invoice/invoice_entry.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:cafe21/controller/invoice_controller.dart';
import 'package:cafe21/views/dashboard_page.dart';
import 'package:cafe21/widget/invoice/invoice_list_item.dart';

class InvoiceList extends StatefulWidget {

  const InvoiceList({Key? key}) : super(key: key);

  @override
  State<InvoiceList> createState() => _InvoiceListState();

}

class _InvoiceListState extends State<InvoiceList> {

  List filteredInvoiceData = []; // all filtered data
  List invoiceData = []; // all data for ui rendering
  String selectedButton = 'All';
  late String appbarTitle;
  final bodyPlaceholder = const Text('No sells data available!');

  @override
  void initState() {
    getReadySellsData();
    ConnectionChecker().checkInternetConnection(() {
      setState(() {});
    });
    super.initState();
  }

  getReadySellsData() async {
    appbarTitle = 'All invoice list';
    selectedButton = 'All';
    filteredInvoiceData = allSellsData; // Filter data assign all data here
    invoiceData = filteredInvoiceData; // data assign for ui rendering
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: AppBar(
        titleTextStyle: const TextStyle(fontWeight: FontWeight.normal),
        title: Text(appbarTitle, style: const TextStyle(color: Colors.white)),
        leading: IconButton(
          onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const DashBoard(),
              )),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  const Text(
                    'Filter invoice:',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const Expanded(child: SizedBox()),
                  DropdownButton(
                    value: selectedButton,
                    items: buttonList
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {
                      filterDataByPayment(value);
                    },
                  ),
                  IconButton(
                    onPressed: filterDataByDate,
                    icon: const Icon(Icons.calendar_month_outlined),
                  ),
                  IconButton(
                    onPressed: getReadySellsData,
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
            ),
            Expanded(
                child: invoiceData.isEmpty
                    ? Center(child: bodyPlaceholder)
                    : ListView.builder(
                        reverse: false,
                        itemCount: invoiceData.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onLongPress: (){
                                if (prefs?.getString(UserKey.role.name) ==
                                    UserRole.admin.name) {
                                  invoiceDeleteConfirmDialog(index);

                                } else {
                                  CommonFunction().showWarningDialog(
                                      'Only admin can delete invoice', context);
                                }
                          },
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => InvoiceDetails(
                                              invoiceData: invoiceData[index]
                                            )));
                              },
                              child: BuildInvoiceListItem(
                                index: index,
                                invoiceData: invoiceData[index],
                                length: invoiceData.length,
                              ));
                        },
                      )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const InvoiceEntry(),
              ));
        },
      ),
    );
  }

  invoiceDeleteConfirmDialog(index){
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
              onPressed: () {
                Navigator.pop(context);
                deleteInvoice(index);
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

  deleteInvoice(index) async {
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
            CommonFunction().showLoadingIndicatorWithTitle(context: context, title: 'Invoice Deleting...');
            bool isSuccessful = await InvoiceController()
                .deleteInvoice(invoiceData[index].invoiceId);
            if(isSuccessful){
              allSellsData.clear(); // from data file
              await DashboardController().getAllSellsData();
              getReadySellsData();
              pop();
              CommonFunction.showGetXSnackBar('Message!', 'Successfully Deleted');
            }
            else{
              pop();
              CommonFunction.showGetXSnackBar('Message!', 'Failed to Delete');
            }



    } else {
      CommonFunction.showGetXSnackBar('No internet', 'Check internet connection');
    }
  }

  filterDataByDate() async {
    String idForCompare, year, month, day;

    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      year = date.year.toString();
      int pMonth = date.month;
      int pDay = date.day;

      if (pMonth < 10) {
        month = pMonth.toString().padLeft(2, '0');
      } else {
        month = pMonth.toString();
      }
      if (pDay < 10) {
        day = pDay.toString().padLeft(2, '0');
      } else {
        day = pDay.toString();
      }

      idForCompare = year + month + day;
      appbarTitle = 'all invoice of $day/$month/$year';

      filteredInvoiceData = allSellsData
          .where((element) =>
              element.invoiceId.toString().substring(0, 8) == idForCompare)
          .toList();
      invoiceData = filteredInvoiceData;
      setState(() {});
    }
  }

  filterDataByPayment(value) {
    selectedButton = value.toString();

    if (value == 'Unpaid') {
      invoiceData = filteredInvoiceData
          .where((element) => element.paymentMethod == 'Payment Due')
          .toList();
    } else if (value == 'All') {
      invoiceData = filteredInvoiceData;
    } else {
      invoiceData = filteredInvoiceData
          .where((element) => element.paymentMethod != 'Payment Due')
          .toList();
    }

    setState(() {});
  }

  void pop() {
    Navigator.pop(context);
  }

}


