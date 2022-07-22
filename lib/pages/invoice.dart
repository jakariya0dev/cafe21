import 'package:cafe21/widget/invoice_card.dart';
import 'package:flutter/material.dart';

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
        appBar: AppBar(),
        body: Container(),
        bottomNavigationBar: const InvoiceCard(),
      ),
    );
  }
}
