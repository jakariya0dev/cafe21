import 'package:cafe21/pages/my_homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/title_text.dart';

class Invoice extends StatefulWidget {
  const Invoice({Key? key}) : super(key: key);

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const MyHomePage()));
          }, icon: const Icon(Icons.home)),
          actions: [
            TextButton(
                onPressed: () {},
                child: const Text(
                  'Print',
                  style: TextStyle(color: Colors.black),
                )),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const [
              BulidTitleText(text: 'Invoice Summery'),
              SizedBox(height: 20),
              BuildInvoiceRow('Invoice id:', '10102'),
              BuildInvoiceRow('Ordered item:', '10'),
              BuildInvoiceRow('Total amount:', '1020'),
              BuildInvoiceRow('Total discount (10%):', '10102'),
              BuildInvoiceRow('Total Tax (5%):', '10102'),
              SizedBox(height: 20),
              BuildInvoiceRow('Customer name:', 'Zakaria Hosain'),
              BuildInvoiceRow('Customer phone:', '0152146603'),
              BuildInvoiceRow('Waiter name:', 'Jack'),
              BuildInvoiceRow('Table no:', '02'),
              BuildInvoiceRow('Order time:', '12:30 pm'),
              BuildInvoiceRow('Order date:', '12-12-2022'),
              BuildInvoiceRow('Payment:', 'Online'),
              BuildInvoiceRowLast()
            ],
          ),
        ),
        bottomNavigationBar: Container(
          // color: Colors.amber,
          padding: const EdgeInsets.all(16),
          child: const Text(
            'Generated with cafe21 developed by Brain Storm 21',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   child: const Icon(Icons.edit_calendar_outlined),
        // ),
      ),
    );
  }
}

class BuildInvoiceRowLast extends StatelessWidget {
  const BuildInvoiceRowLast({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          'Total bill:',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          '\$ 1000',
          textAlign: TextAlign.center,
          style: TextStyle(
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


