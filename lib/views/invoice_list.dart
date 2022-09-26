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
  List sellsData = [];
  List invoiceData = [];
  String selectedButton = 'All';
  List<String> buttonList = ['All', 'Paid', 'Unpaid'];


  @override
  void initState() {
    super.initState();
    getTodaysSellsData();
  }

  getTodaysSellsData() async {
    sellsData = await InvoiceListController().getTodaysSells();
    invoiceData = sellsData.reversed.toList();

    setState(() {});

    // print(invoiceData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      // drawer: const MyDrawer(),
      appBar: AppBar(
        titleTextStyle: const TextStyle(fontWeight: FontWeight.normal),
        title: const Text('Chef de cuisine'),
        leading: IconButton(
          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashBoard(),)),
          icon: const Icon(Icons.home),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: sellsData.isEmpty
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : Column(
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
                    selectedButton = value.toString();
                    setState(() {});
                  },
                ),
                IconButton(onPressed: (){
                  showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime.now());
                }, icon: const Icon(Icons.calendar_month_outlined),),
                IconButton(onPressed: (){
                  showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime.now());
                }, icon: const Icon(Icons.refresh),),
              ],
            ),
            ),
            Expanded(
                child: ListView.builder(
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
                                  )));
                        },
                        child: BuildInvoiceListItem(
                          index: index,
                          invoiceData: invoiceData[index],
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
            getTodaysSellsData();
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
}

class BuildInvoiceListItem extends StatelessWidget {
  const BuildInvoiceListItem(
      {Key? key, required this.index, required this.invoiceData})
      : super(key: key);
  final int index;
  final InvoiceModel invoiceData;



  @override
  Widget build(BuildContext context) {
    bool isPaid;
    if(invoiceData.paymentMethod== paymentMethodList[3]){
      isPaid = false;
    }else{
      isPaid = true;
    }

    int totalAmount = 0;

    for (var i = 0; i < invoiceData.orders.length; i++) {
      totalAmount = totalAmount +
          (int.parse(invoiceData.orders[i]['price']) *
              int.parse(invoiceData.orders[i]['quantity']));
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
                          text: totalAmount.toString(),
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
              '${index + 1}',
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