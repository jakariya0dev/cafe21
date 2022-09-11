
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:cafe21/model/invoice_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widget/title_text.dart';


class InvoicePrint extends StatefulWidget {
  const InvoicePrint({Key? key, required this.invoiceData, required this.isServerData}) : super(key: key);

  final InvoiceModel invoiceData;
  final bool isServerData;

  @override
  State<InvoicePrint> createState() => _InvoicePrintState();
}

class _InvoicePrintState extends State<InvoicePrint> {

  late double netBill;
  double totalAmount = 0;
  late double totalAmountAfterDiscount;

  // printing services
  BlueThermalPrinter printer = BlueThermalPrinter.instance;
  List<BluetoothDevice> devices = [];
  BluetoothDevice? selectedDevice;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for(var i = 0; i < widget.invoiceData.orders.length; i++ ){

      totalAmount = totalAmount + double.parse(widget.invoiceData.orders[i]['itemTotal']);
    }

    if(widget.invoiceData.discount.isNotEmpty && widget.invoiceData.discountType == '%'){
      totalAmountAfterDiscount = totalAmount - (totalAmount*(int.parse(widget.invoiceData.discount)/100));
      netBill = totalAmountAfterDiscount + (totalAmountAfterDiscount*(int.parse(widget.invoiceData.tax)/100));
    }
    if(widget.invoiceData.discount.isNotEmpty && widget.invoiceData.discountType == '\$'){
      totalAmountAfterDiscount = totalAmount - int.parse(widget.invoiceData.discount);
      netBill = totalAmountAfterDiscount + (totalAmountAfterDiscount*(int.parse(widget.invoiceData.tax)/100));
    }
    initPrinter();

  }

  Future<void> initPrinter() async {
    devices = await printer.getBondedDevices();
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {

    String date = widget.isServerData ? DateFormat.yMMMd().add_jm().format(widget.invoiceData.dateTime.toDate()).toString() : DateFormat.yMMMd().add_jm().format(widget.invoiceData.dateTime).toString();
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.clear)),
          actions: [

            TextButton(
                onPressed: () {},
                child: const Text(
                  'Edit',
                  style: TextStyle(color: Colors.black),
                )),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
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
                BuildInvoiceRow('Total amount:', totalAmount.toString()),
                BuildInvoiceRow('After discount: (${widget.invoiceData.discount}${widget.invoiceData.discountType}):', totalAmountAfterDiscount.toString()),
                BuildInvoiceRow('With Tax (${widget.invoiceData.tax}%):', netBill.toString()),
                BuildInvoiceRowLast(title: 'Net Bill:', value: '\$$netBill',)
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.purple,
          padding: const EdgeInsets.all(16),
          height: width*0.15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton(
                items: devices.map((e) => DropdownMenuItem(value: e,child: Text(e.name.toString()),)).toList(),
                onChanged: (value) {
                  selectedDevice = value as BluetoothDevice?;
                  printer.connect(selectedDevice!);

                  setState(() {});
                },
              ),
              const Text('Print Invo',
                style: TextStyle(color: Colors.white),
              )
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
