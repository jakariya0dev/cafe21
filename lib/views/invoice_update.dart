import 'package:flutter/material.dart';

import '../model/invoice_model.dart';
import '../network/services.dart';
import 'invoice_print.dart';

class InvoiceUpdate extends StatefulWidget {
  const InvoiceUpdate({Key? key}) : super(key: key);

  @override
  State<InvoiceUpdate> createState() => _InvoiceUpdate();
}

class _InvoiceUpdate extends State<InvoiceUpdate> {

  List<String> category = [
    'burger ',
    'sandwich ',
    'Pizza',
    'Rice',
    'Beverage',
    'Bangla',
    'Thai Food',
    'Others'
  ];

  int quantity = 0;
  List foodData = [];
  Map <String, dynamic> invoice = {};
  List orderedItem = [];
  TextEditingController customerController = TextEditingController(), phoneController = TextEditingController(), discountController = TextEditingController(), taxController = TextEditingController(), waiterController = TextEditingController(), tableController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          titleTextStyle: const TextStyle(
              fontWeight: FontWeight.normal, color: Colors.black),
          title: const Text('invoice id: 12122020'),
          actions: [
            TextButton(
                onPressed: () async {
                  // if(customerController.text.isNotEmpty && phoneController.text.isNotEmpty && discountController.text.isNotEmpty && taxController.text.isNotEmpty && waiterController.text.isNotEmpty && tableController.text.isNotEmpty && orderedItem.isNotEmpty){
                  //   InvoiceModel invoice = InvoiceModel(customer: customerController.text, phone: phoneController.text, discount: discountController.text, tax: taxController.text, waiter: waiterController.text, table: tableController.text, dateTime: DateTime.now(), orders: orderedItem);
                  //   await Services().saveInvoiceToServer(invoice);
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => const Invoice(),
                  //       ));
                  // }else{
                  //
                  //   SnackBar snackBar = SnackBar(content: const Text('Fill all field and add some product'), action: SnackBarAction(label: 'ok', onPressed: (){
                  //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  //   }),);
                  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  //
                  // }

                },
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.black),
                )),
          ],
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: customerController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  alignLabelWithHint: true,
                  isDense: true,
                  labelText: 'Customer Name',
                  hintText: 'ex: Sakib Al Hasan',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  isDense: true,
                  prefixIcon: Icon(Icons.phone_android_rounded),
                  labelText: 'Customer Phone',
                  hintText: 'ex: 01521466603',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children:  [
                  Expanded(
                    child: TextField(
                      controller: discountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        isDense: true,
                        labelText: 'Discount',
                        hintText: 'ex: 5',
                        suffixText: '%',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: taxController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        isDense: true,
                        labelText: 'Tax',
                        hintText: 'ex: 10',
                        suffixText: '%',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: waiterController,
                      decoration: const InputDecoration(
                        isDense: true,
                        labelText: 'Waiter name',
                        hintText: 'ex: Jack',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: tableController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        isDense: true,
                        labelText: 'Table no',
                        hintText: 'ex: 5',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Ordered item',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(child: orderedItem.isEmpty ? const Center(child: Text('No item in list'),) : ListView.builder(
                itemCount: orderedItem.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Text('${index + 1}. '),
                          Expanded(child: Text(orderedItem[index]['name']!)),
                          Text('2×${orderedItem[index]['price']}'),
                          const SizedBox(
                            width: 8,
                          ),
                          InkWell(onTap: (){
                            orderedItem.removeAt(index);
                            changeState();
                          }, child: const Icon(Icons.cancel_presentation))
                        ],
                      ),
                      const Divider()
                    ],
                  );
                },
              ))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          mini: false,
          onPressed: () async {
            foodData = await Services().getFoodData('sandwich ');
            invoice.addAll({
              'name' : customerController.text,
              'phone' : phoneController.text,
              'discount' : discountController.text,
              'tax' : taxController.text,
              'waiter' : waiterController.text,
              'table' : tableController.text
            });

            // print(invoice);
            addFoodToCart(context);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void changeState(){
    setState(() {

    });
  }

  Future<dynamic> addFoodToCart(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        int selectedButton = 0;
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text('Add product'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  height: 35,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return MaterialButton(
                          onPressed: () async {
                            selectedButton = index;
                            // print(selectedButton);
                            foodData.clear();
                            foodData = await Services().getFoodData(category[index]);
                            print(orderedItem);
                            setState(() {});
                          },
                          elevation: selectedButton == index ? 10 : 0,
                          shape: selectedButton == index
                              ? const StadiumBorder()
                              : null,
                          color: selectedButton == index
                              ? Colors.amberAccent
                              : Colors.white,
                          child: Text(category[index]),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 10,
                        );
                      },
                      itemCount: category.length),
                ),
                Expanded(
                  child: foodData.isEmpty ? const Center(child: CircularProgressIndicator(),) : ListView.separated(
                    itemCount: foodData.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        dense: true,
                        title: Text(foodData[index]['name']+' - \$'+foodData[index]['price']),
                        subtitle: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                // quantity++;
                                setState(() {});
                              },
                              child: const Icon(Icons.add_circle_outline),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(quantity.toString()),
                            ),
                            InkWell(
                                onTap: () {
                                  // quantity--;
                                  setState(() {});
                                },
                                child: const Icon(Icons.remove_circle_outline)),
                          ],
                        ),
                        trailing: TextButton(
                          onPressed: (){
                            orderedItem.add({'name' : foodData[index]['name'], 'price' : foodData[index]['price'], 'id' : foodData[index]['id'],});
                            changeState();
                          },
                          child: const Text('Add'),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                  ),
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok')),
              // TextButton(
              //     onPressed: () {
              //       // Services().add();
              //
              //     },
              //     child: const Text('Ok')),
            ],
          );
        });
      },
    );
  }

}
