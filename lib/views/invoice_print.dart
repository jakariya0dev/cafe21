import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:cafe21/app_color.dart';
import 'package:cafe21/model/invoice_model.dart';
import 'package:cafe21/views/invoice_list.dart';
import 'package:cafe21/views/invoice_update.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../controller/printer_controller.dart';
import '../widget/title_text.dart';

class InvoicePrint extends StatefulWidget {
  const InvoicePrint(
      {Key? key, required this.invoiceData, required this.isServerData})
      : super(key: key);

  final InvoiceModel invoiceData;
  final bool isServerData;

  @override
  State<InvoicePrint> createState() => _InvoicePrintState();
}

class _InvoicePrintState extends State<InvoicePrint> {

  // subtotal = 440
  // total = 420
  // netBill =430

  late String addedTax;
  String? selectDeviceName = 'Select Device';

  // printing services
  BlueThermalPrinter printer = BlueThermalPrinter.instance;
  List<BluetoothDevice> devices = [];
  BluetoothDevice? selectedDevice;

  @override
  void initState() {

    addedTax = (double.parse(widget.invoiceData.netBill) - double.parse(widget.invoiceData.total)).toStringAsFixed(2);
    initPrinter();
    super.initState();

  }

  Future<void> initPrinter() async {
    devices = await printer.getBondedDevices();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {

    String date = widget.isServerData ? DateFormat.yMMMd().add_jm().format(widget.invoiceData.dateTime.toDate()).toString() : DateFormat.yMMMd().add_jm().format(widget.invoiceData.dateTime).toString();
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            if(widget.isServerData==false){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const InvoiceList()));
            }else{
              Navigator.pop(context);
            }
          }, icon: const Icon(Icons.arrow_back_outlined)),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MaterialButton(
                color: const Color(AppColor.box5),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => InvoiceUpdate(invoiceData: widget.invoiceData)));
                  },
                  child: const Text(
                    'Edit invoice',
                    style: TextStyle(color: Colors.black),
                  )),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          constraints: const BoxConstraints.expand(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const BulidTitleText(text: 'Invoice Summery'),
                const SizedBox(height: 20),
                BuildInvoiceRowLast(title: 'Invoice id:', value: widget.invoiceData.invoiceId.toString()),
                const Divider(),
                BuildInvoiceRow('Customer name:', widget.invoiceData.customer.toString()),
                BuildInvoiceRow('Customer phone:', widget.invoiceData.phone.toString()),
                BuildInvoiceRow('Order time:', date ),
                const BuildInvoiceRow('Payment:', 'Online'),
                const BuildOrderTitle('Ordered item(s):'),
                Table(
                  border: TableBorder.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  columnWidths: const {
                    0: FractionColumnWidth(0.75),
                    2: FractionColumnWidth(0.25),
                  },
                  children: [
                    for(int i = 0; i < widget.invoiceData.orders.length; i++)  TableRow(
                        children: [
                          TableCell(child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text('${i+1}. ${widget.invoiceData.orders[i]['name']}', overflow: TextOverflow.ellipsis),
                          ),),
                          TableCell(child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text('${widget.invoiceData.orders[i]['quantity']}×${double.parse(widget.invoiceData.orders[i]['itemTotal'])/int.parse(widget.invoiceData.orders[i]['quantity'])}', textAlign: TextAlign.end, ),
                          ),)
                        ]
                    ),

                  ],
                ),
                const SizedBox(height: 20),
                BuildInvoiceRow('Total amount:', widget.invoiceData.subTotal),
                BuildInvoiceRow('After ${widget.invoiceData.discount}${widget.invoiceData.discountType} Discount (-${(double.parse(widget.invoiceData.subTotal)-double.parse(widget.invoiceData.total)).toStringAsFixed(2)}):', widget.invoiceData.total),
                BuildInvoiceRow('With ${widget.invoiceData.tax}% Tax (+${(double.parse(widget.invoiceData.netBill)-double.parse(widget.invoiceData.total)).toStringAsFixed(2)}):', widget.invoiceData.netBill),
                BuildInvoiceRowLast(title: 'Net Bill:', value: '\$${widget.invoiceData.netBill}',)
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 75,
          // color: Colors.purple,
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: DropdownButton(
                  items: devices
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.name.toString(),),
                          ))
                      .toList(),
                  onChanged: (value) {
                    selectedDevice = value as BluetoothDevice?;
                    selectDeviceName = value?.name;
                    printer.connect(selectedDevice!);
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                  width: 150,
                  child: MaterialButton(
                color: const Color(AppColor.box4),
                height: 40,
                shape: const StadiumBorder(),
                onPressed: () async {
                  if ((await printer.isConnected)!) {
                    printer.printCustom('Chef De Cuisine', 3, 1);
                    printer.printCustom('Badarganj Bus Stand, Badarganj', 1, 1);
                    printer.printCustom('Cell: 01762940480', 1, 1);

                    printer.printNewLine();
                    printer.printCustom('inv. id: ${widget.invoiceData.invoiceId}', 0, 0);
                    printer.printCustom('Timing: $date', 0, 0);
                    printer.printCustom('Payment: ${widget.invoiceData.paymentMethod}', 0, 0);
                    printer.printCustom('Ordered item(s)', 0, 0);
                    for (var i = 0; i < widget.invoiceData.orders.length; i++) {
                      printer.printCustom('----------------------------', 0, 0);
                      printer.printCustom('${i + 1}. ${widget.invoiceData.orders[i]['name']}', 0, 0);
                      printer.printCustom('-${widget.invoiceData.orders[i]['quantity']}x${widget.invoiceData.orders[i]['price']}', 0, 2);
                    }
                    printer.printCustom('----------------------------', 0, 0);
                    printer.printCustom('Total amount: ${widget.invoiceData.subTotal}', 0, 0);
                    printer.printCustom('After discount: (${widget.invoiceData.discount}%): ${widget.invoiceData.total}', 0, 0);
                    printer.printCustom('Added Tax (${widget.invoiceData.tax}%): $addedTax', 0, 0);
                    printer.printCustom('Net Bill(${widget.invoiceData.tax}%): ${widget.invoiceData.netBill}', 3, 1);

                    printer.printNewLine();
                    printer.printNewLine();
                    printer.printNewLine();
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  child: Text(
                    'Print invoice',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class BuildInvoiceRowLast extends StatelessWidget {
  const BuildInvoiceRowLast({
    Key? key, required this.title, required this.value,
  }) : super(key: key);

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:  [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class BuildInvoiceRow extends StatelessWidget {
  const BuildInvoiceRow(this.title, this.value, {Key? key}) : super(key: key);

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
            ),
            Text(
              value,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}

class BuildOrderTitle extends StatelessWidget {
  const BuildOrderTitle(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
            ),

          ],
        ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}
