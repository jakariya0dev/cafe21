import 'dart:developer';

import 'package:cafe21/pages/invoice_entry.dart';
import 'package:cafe21/pages/invoice_details.dart';
import 'package:flutter/material.dart';
import '../network/services.dart';
import '../widget/drawer.dart';
import '../widget/list_item.dart';
import '../widget/title_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List sellsData = [];
  List invoiceData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTodaysSellsData();
  }
  
  getTodaysSellsData() async{

    sellsData = await Services().getTodaysSells();
    invoiceData = sellsData.reversed.toList();

    setState(() {

    });

    // print(invoiceData);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text('Chef de cuisine'),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: sellsData.isEmpty ? const Center(child: CircularProgressIndicator(),) : Column(
          children: [
            const BuildTitleCard(),
            Expanded(
                child: ListView.builder(
              reverse: false,

              itemCount: invoiceData.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => InvoiceDetails(invoiceData: invoiceData[index],)));
                    },
                    child: BuildListItem(index: index, invoiceData: invoiceData[index],));
              },
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber.shade500,
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
}
