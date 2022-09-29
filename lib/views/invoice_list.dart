import 'package:cafe21/app_color.dart';
import 'package:cafe21/views/invoice_entry.dart';
import 'package:cafe21/views/invoice_details.dart';
import 'package:flutter/material.dart';
import 'package:cafe21/controller/invoice_list_controller.dart';
import 'package:cafe21/model/invoice_model.dart';
import 'package:intl/intl.dart';
import 'package:cafe21/const.dart';

import 'dashboard_page.dart';

class InvoiceList extends StatefulWidget {
  const InvoiceList({Key? key}) : super(key: key);

  @override
  State<InvoiceList> createState() => _InvoiceListState();
}

class _InvoiceListState extends State<InvoiceList> {

  List sellsData = [];    // all invoice data here
  List invoiceData = [];  // all data for ui rendering
  List filteredInvoiceData = [];  // all filtered data
  String selectedButton = 'All';
  List<String> buttonList = ['All', 'Paid', 'Unpaid'];


  @override
  void initState() {
    super.initState();
    getSellsData();
  }

  getSellsData() async {

    selectedButton = 'All';
    sellsData = await InvoiceListController().getSellsData(); // getting all invoice data
    filteredInvoiceData = sellsData;  // so, first no filter assign all data here
    invoiceData = filteredInvoiceData;  // data assign for ui rendering
    setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: AppBar(
        titleTextStyle: const TextStyle(fontWeight: FontWeight.normal),
        title: const Text('Chef de cuisine'),
        leading: IconButton(
          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashBoard(),)),
          icon: const Icon(Icons.home),
        ),
        actions: [
          IconButton(
              onPressed: () {

          }, icon: const Icon(Icons.replay_circle_filled_outlined))
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Filter invoice:', style: TextStyle(fontWeight: FontWeight.w600),),
                const Expanded(child: SizedBox()),
                DropdownButton(
                  value: selectedButton,
                  items: buttonList.map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e))).toList(),
                  onChanged: (value) {
                    filterDataByPayment(value);
                  },
                ),
                IconButton(
                  onPressed: filterDataByDate,
                  icon: const Icon(Icons.calendar_month_outlined),
                ),
                IconButton(onPressed: getSellsData, icon: const Icon(Icons.refresh),),
              ],
            ),
            ),
            Expanded(
                child: sellsData.isEmpty
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : ListView.builder(
                  reverse: false,
                  itemCount: invoiceData.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onLongPress: (){
                        deleteInvoice(index);
                      },
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InvoiceDetails(
                                    invoiceData: invoiceData[index],
                                    isServerData: true,
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
                builder: (context) => const CartPage(),
              ));
        },
      ),
    );
  }

  deleteInvoice(index){
    showDialog(context: context, builder: (context) {
      return  AlertDialog(
        title: const Text('Are you sure!', style: TextStyle(color: Colors.red),),
        content: const Text('This invoice will be deleted.'),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          MaterialButton(onPressed: () async {

            String msg = await InvoiceListController().deleteInvoice(invoiceData[index].invoiceId);
            Navigator.pop(context);
            invoiceData.clear();
            sellsData.clear();
            getSellsData();
            SnackBar snackBar = SnackBar(backgroundColor: Colors.purple, content: Text(msg), action: SnackBarAction(label: 'OK', textColor: Colors.white, onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),),);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

          },
            color: const Color(AppColor.box5),
            child: const Text('OK', style: TextStyle(color: Colors.white),),
          ),
          MaterialButton(onPressed: (){
            Navigator.pop(context);
          },
            color: const Color(AppColor.box4),
            child: const Text('CANCEL', style: TextStyle(color: Colors.white),),
          ),
        ],
      );
    },);
  }

  filterDataByDate() async {

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

      filteredInvoiceData = sellsData.where((element) => element.invoiceId.toString().substring(0, 8) == idForCompare).toList();
      invoiceData = filteredInvoiceData;
      setState(() {});

    }

  }

  filterDataByPayment(value) {

    selectedButton = value.toString();

    if(value =='Unpaid'){
      invoiceData = filteredInvoiceData.where((element) => element.paymentMethod == 'Payment Due').toList();
    }
    else if(value =='All'){
      invoiceData = filteredInvoiceData;

    }
    else{
      invoiceData = filteredInvoiceData.where((element) => element.paymentMethod != 'Payment Due').toList();

    }

    setState(() {});
  }
}

class BuildInvoiceListItem extends StatelessWidget {

  const BuildInvoiceListItem(
      {Key? key, required this.index, required this.invoiceData, required this.length})
      : super(key: key);
  final int index, length;
  final InvoiceModel invoiceData;

  @override
  Widget build(BuildContext context) {
    
    bool isPaid;
    double netBill = double.parse(invoiceData.netBill);
    
    if(invoiceData.paymentMethod== paymentMethodList[3]){
      isPaid = false;
    }else{
      isPaid = true;
    }

    return Stack(
      children: [
        Container(
          height: 55,
          margin: const EdgeInsets.only(left: 16, bottom: 4, top: 4),
          padding: const EdgeInsets.only(left: 24,),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 16,
              ),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(DateFormat.yMMMd()
                        .add_jm()
                        .format(invoiceData.dateTime.toDate())
                        .toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: .5),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        Text('id: ${invoiceData.invoiceId}',
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, color: Colors.black54),
                        ),
                        const SizedBox(width: 4),
                        Container(
                            padding: const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 1),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(16)
                            ),
                            child: Text(isPaid ? 'PAID' : 'UNPAID', style: const TextStyle(fontSize: 8, color: Colors.white),))
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: RichText(
                  text: TextSpan(
                      text: '\$',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: Colors.grey.shade400),
                      children: [
                        TextSpan(
                          text: netBill.toStringAsFixed(1),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black87),

                        )
                      ]
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          child: CircleAvatar(
            child: Text(
              '${length-index}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}