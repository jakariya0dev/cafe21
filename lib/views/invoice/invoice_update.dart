import 'package:cafe21/cons/app_color.dart';
import 'package:cafe21/cons/enums.dart';
import 'package:cafe21/controller/common_function.dart';
import 'package:cafe21/controller/invoice_controller.dart';
import 'package:cafe21/model/invoice_model.dart';
import 'package:cafe21/cons/const.dart';
import 'package:cafe21/widget/discount_container.dart';
import 'package:cafe21/model/data.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cafe21/controller/connection_checker.dart';


class InvoiceUpdate extends StatefulWidget {
  const InvoiceUpdate({Key? key, required this.invoiceData}) : super(key: key);

  final InvoiceModel invoiceData;

  @override
  State<InvoiceUpdate> createState() => _InvoiceUpdate();
}

class _InvoiceUpdate extends State<InvoiceUpdate> {


  List initialFoodData = [];
  bool? isEnabled;

  // FOR DIALOG FIELD MANAGE
  List<int> itemQuantityList = [];
  List<String> itemAddedInCartIdList = [];  // for button enable/disable
  List<TextEditingController> itemDiscountController = [];
  List<String> itemDiscountType = [];


  // for body drop down menu
  late String selectedWaiterName, selectedWaiterId, selectedPaymentMethod;

  // FOR GENERAL USE
  dynamic height, width;


  int selectedButton = 0;
  List<dynamic> orderedItemList = [];
  late String totalDiscount, totalDiscountType;

  // invoice data
  double subTotal = 0;   // only food total
  double total = 0;      // food total after discount
  double netBill = 0;   // total after tax added

  // controller for form field
  late TextEditingController customerController, phoneController, addressController;
  late TextEditingController discountController, taxController, tableController;

  getFoodDataForAddProductDialog({required String categoryId}) async {

    initialFoodData = allFoodsData.where((e) => e['category'] == categoryId).toList();

    // for managing dialog field
    for (var i = 0; i <= initialFoodData.length; i++) {
      itemQuantityList.add(1);
      itemDiscountController.add(TextEditingController());
      itemDiscountType.add('%');
    }

  }

  void changeState() {
    setState(() {});
  }

  @override
  void initState() {

        isEnabled = prefs?.getString(UserKey.role.name) == UserRole.user.name ? false : true;
        customerController = TextEditingController(text: widget.invoiceData.customer);
        phoneController = TextEditingController(text: widget.invoiceData.phone);
        addressController = TextEditingController(text: widget.invoiceData.address);
        discountController = TextEditingController(text: widget.invoiceData.discount);
        taxController = TextEditingController(text: widget.invoiceData.tax);
        tableController = TextEditingController(text: widget.invoiceData.table);

        selectedWaiterName = widget.invoiceData.waiterName;
        selectedWaiterId = widget.invoiceData.waiterId;
        selectedPaymentMethod = widget.invoiceData.paymentMethod;
        orderedItemList = widget.invoiceData.orders;

        for(int i = 0; i < orderedItemList.length; i++){
          itemAddedInCartIdList.add(orderedItemList[i]['id']);
        }

        totalDiscountType = widget.invoiceData.discountType;
        totalDiscount =  widget.invoiceData.discount;

        // print(itemAddedInCartIdList);
        subTotal = double.parse(widget.invoiceData.subTotal);   // only food total
        total = double.parse(widget.invoiceData.total);      // food total after discount
        netBill = double.parse(widget.invoiceData.netBill);

        ConnectionChecker().checkInternetConnection((){
          setState(() {});
        });

        getFoodDataForAddProductDialog(categoryId: allCategoryData[0]['id']);
        super.initState();

  }

  @override
  Widget build(BuildContext context) {

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue.shade50,
        appBar: AppBar(
          titleTextStyle: const TextStyle(
              fontWeight: FontWeight.normal, color: Colors.white),
          title: const Text('Update customer invoice'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MaterialButton(
                  color: const Color(AppColor.box5),
                  onPressed: updateInvoice,
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.grey.shade100),
                  )),
            ),
          ],
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Title card
                buildTitleCard(),
                const SizedBox(height: 10),
                buildCustomerSection(),
                const SizedBox(height: 10),
                buildFinanceSection(),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'Ordered item',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                buildOrderedListItem()
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              color: Colors.purple.shade500,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32), topRight: Radius.circular(32))),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 8,),
                      RichText(
                          text: TextSpan(
                              text: '\$',
                              style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal),
                              children: [
                                TextSpan(
                                  text: subTotal.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                )
                              ])),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Total ${orderedItemList.length} item(s) in order list',
                    style: const TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ],
              ),
              MaterialButton(
                shape: const StadiumBorder(),
                minWidth: 100,
                color: Colors.deepOrange,
                onPressed: () {
                  if(isEnabled!){
                    openFoodCartDialog(context);
                  }
                },
                child: const Text(
                  'Add item',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container buildTitleCard() {
    return Container(
      width: width,
      height: 85,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // color: Colors.white,
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple.shade400, Colors.purple.shade300]),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Inv. id:',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                widget.invoiceData.invoiceId,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Dated:',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                DateFormat.yMMMd().add_jm().format(widget.invoiceData.dateTime.toDate()),
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Container buildCustomerSection() {
    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          TextField(
            controller: customerController,
            decoration: InputDecoration(
              enabled: isEnabled!,
              prefixIcon: const Icon(Icons.person),
              alignLabelWithHint: true,
              isDense: true,
              labelText: 'Customer Name',
              hintText: 'ex: Saki Al Hasan',
              hintStyle: TextStyle(color: Colors.grey.shade300),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: phoneController,
            enabled: isEnabled!,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              isDense: true,
              prefixIcon: const Icon(Icons.phone_android_rounded),
              labelText: 'Customer Phone',
              hintText: 'ex: 01521466603',
              hintStyle: TextStyle(color: Colors.grey.shade300),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            enabled: isEnabled!,
            controller: addressController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person_pin_outlined),
              isDense: true,
              labelText: 'Customer address',
              hintText: 'ex: Jack',
              hintStyle: TextStyle(color: Colors.grey.shade300),
              border: const OutlineInputBorder(),
            ),
          )
        ],
      ),
    );
  }

  Container buildFinanceSection() {

    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  enabled: isEnabled!,
                  controller: discountController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    totalDiscount = value;
                    // print(totalDiscount);
                    changeState();
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Discount',
                    hintText: 'ex: 5',
                    hintStyle: TextStyle(color: Colors.grey.shade300),
                    suffix: InkWell(
                      onTap: () {
                        if (totalDiscountType == '%') {
                          totalDiscountType = '\$';
                        } else {
                          totalDiscountType = '%';
                        }
                        setState(() {});
                      },
                      child: Text(
                        totalDiscountType,
                        style: TextStyle(color: Colors.grey.shade800, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: TextField(
                  enabled: isEnabled!,
                  controller: taxController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Tax',
                    hintText: 'ex: 10',
                    hintStyle: TextStyle(color: Colors.grey.shade300),
                    suffix: Text(
                      '%',
                      style: TextStyle(color: Colors.grey.shade800),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: TextField(
                  enabled: isEnabled!,
                  controller: tableController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Table no',
                    hintText: 'ex: 5',
                    hintStyle: TextStyle(color: Colors.grey.shade300),
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const SizedBox(height: 5),
          Row(
            children: [
              const Expanded(
                child: Text('Waiter name: '),
              ),
              const SizedBox(width: 8),
              DropdownButton(
                hint: Text(selectedWaiterName),
                onTap: () {},
                items: allWaiterData
                    .map((e) =>
                    DropdownMenuItem(value: e['id']+'. '+e['name'], child: Text(e['id']+'. '+e['name'].toString())))
                    .toList(),
                onChanged: (value) {
                  selectedWaiterId = value.toString().substring(0, 3);
                  selectedWaiterName = value.toString().substring(5);
                  setState(() {});
                },
              )
            ],
          ),
          Row(
            children: [
              const Expanded(
                child: Text('Payment Method: '),
              ),
              const SizedBox(width: 8),
              DropdownButton(
                hint: Text(selectedPaymentMethod),
                // value: paymentMethod,
                onTap: () {},
                items: paymentMethodList
                    .map((e) =>
                    DropdownMenuItem(value: e, child: Text(e.toString())))
                    .toList(),
                onChanged: (value) {
                  selectedPaymentMethod = value.toString();
                  setState(() {});
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  SizedBox buildOrderedListItem() {

    return SizedBox(
        height: (100.0 + 8) * orderedItemList.length,
        child: orderedItemList.isEmpty
            ? const Center(
          child: Text('No item in list'),
        )
            : ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: orderedItemList.length,
          itemBuilder: (context, index) {
            return Container(
              height: 100,
              padding: const EdgeInsets.only(
                  top: 8, bottom: 16, left: 10, right: 10),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                  border: const Border(
                      left: BorderSide(color: Colors.blue, width: 5)),
                  color: Colors.purple.shade50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(child: SizedBox()),
                      InkWell(
                          onTap: () {
                            if(isEnabled!){
                              removeItemFromOrderList(index);
                            }
                          },
                          child: const Icon(
                            Icons.clear,
                            color: Colors.grey,
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '${orderedItemList[index]['quantity']}×${orderedItemList[index]['price']}',
                        style: TextStyle(
                            letterSpacing: 1,
                            fontSize: 16,
                            color: Colors.grey.shade900),
                      ),
                      const SizedBox(width: 10),
                      DiscountContainer(discount: orderedItemList[index]['discount'], type: orderedItemList[index]['discountType'],)
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                            '${index + 1}. ${orderedItemList[index]['name']}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade700),
                          )),
                      Text(
                        '\$${orderedItemList[index]['itemTotal']}',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.grey.shade800),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ));
  }

  openFoodCartDialog(BuildContext context) async {

    return showDialog(
      context: context,
      builder: (context) {

        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text('Add product'),
            content: SizedBox(
              height: double.maxFinite,
              width: width * 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    height: 35,
                    child: allCategoryData.isEmpty
                        ? const Center(
                      child: Text('No Category. add some food data', overflow: TextOverflow.ellipsis,),
                    ) : ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return MaterialButton(
                            onPressed: () async {
                              selectedButton = index;
                              initialFoodData.clear();
                              getFoodDataForAddProductDialog(categoryId: allCategoryData[index]['id']);
                              setState(() {});
                            },
                            elevation: selectedButton == index ? 10 : 0,
                            shape: selectedButton == index
                                ? const StadiumBorder()
                                : null,
                            color: selectedButton == index
                                ? Colors.amberAccent
                                : Colors.white,
                            child: Text(allCategoryData[index]['name'] ?? ''),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 10,
                          );
                        },
                        itemCount: allCategoryData.length),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: initialFoodData.isEmpty ? const Center(
                      child: Text('Ohh! No data.'),
                    ) : ListView.separated(
                      itemCount: initialFoodData.length,
                      itemBuilder: (context, index) {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${index+1}. ${initialFoodData[index]['name']} - \$${initialFoodData[index]['price']}',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Text(
                                    'Discount:',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  SizedBox(
                                    width: 55,
                                    child: TextField(
                                      controller: itemDiscountController[index],
                                      keyboardType: TextInputType.number,
                                      maxLines: 1,
                                      minLines: 1,
                                      decoration: InputDecoration(
                                          isDense: true,
                                          suffix: InkWell(
                                              onTap: () {
                                                if(itemDiscountType[index]=='%'){
                                                  itemDiscountType[index] = '\$';
                                                }else{
                                                  itemDiscountType[index] = '%';
                                                }
                                                setState(() {});
                                              },
                                              child: Text(itemDiscountType[index], style: const TextStyle(fontSize: 20),))),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        if (itemQuantityList[index] > 1) {
                                          itemQuantityList[index]--;
                                        }
                                        setState(() {});
                                      },
                                      child: const Icon(
                                        Icons.remove_circle_outline,
                                        color: Colors.grey,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      itemQuantityList[index].toString(),
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      itemQuantityList[index]++;
                                      setState(() {});
                                    },
                                    child: const Icon(
                                      Icons.add_circle_outline,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  TextButton(
                                    onPressed: itemAddedInCartIdList.contains(initialFoodData[index]['id']) ? null : () {
                                      addItemInOrderList(index);
                                      setState(() {});
                                    },
                                    child: Text(
                                      itemAddedInCartIdList.contains(initialFoodData[index]['id']) ? 'Added' : 'Add',
                                      style: TextStyle(
                                          color: itemAddedInCartIdList.contains(initialFoodData[index]['id']) ? Colors.grey : Colors.deepPurple),
                                    ),
                                  )
                                ],
                              ),
                            ]);
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          thickness: 1
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok')),
            ],
          );
        });
      },
    );
  }

  void addItemInOrderList(index) {

    num itemTotal;

    if(itemDiscountController[index].text.isNotEmpty &&  itemDiscountType[index] == '%'){
      num discount = int.parse(itemDiscountController[index].text)/100;
      num subTotal = itemQuantityList[index] * int.parse(initialFoodData[index]['price']);
      itemTotal = subTotal - (subTotal*discount);
    }
    else if(itemDiscountController[index].text.isNotEmpty && itemDiscountType[index] == '\$'){
      num subTotal = itemQuantityList[index]* int.parse(initialFoodData[index]['price']);
      itemTotal = subTotal - int.parse(itemDiscountController[index].text);
    }
    else{
      itemTotal = int.parse(initialFoodData[index]['price'])*itemQuantityList[index];
    }

    subTotal += itemTotal;
    orderedItemList.add({
        'id': initialFoodData[index]['id'],
        'name': initialFoodData[index]['name'],
        'price': initialFoodData[index]['price'],
        'discount': itemDiscountController[index].text,
        'discountType' : itemDiscountType[index],
        'quantity': itemQuantityList[index].toString(),
        'itemTotal': itemTotal.toStringAsFixed(2),
        'isAddedIndex': index
    });
    itemAddedInCartIdList.add(initialFoodData[index]['id']);
    itemQuantityList[index] = 1;
    itemDiscountController[index].clear();
    itemDiscountType[index] = '%';
    changeState();

  }

  void removeItemFromOrderList(index) {

    itemAddedInCartIdList.remove(orderedItemList[index]);
    subTotal -= double.parse(orderedItemList[index]['itemTotal']);
    orderedItemList.removeAt(index);
    changeState();

  }

  updateInvoice() async {
    if (customerController.text.isEmpty ||
        phoneController.text.isEmpty ||
        discountController.text.isEmpty ||
        taxController.text.isEmpty ||
        addressController.text.isEmpty ||
        tableController.text.isEmpty) {
      CommonFunction().showSnackBar('Fill all the field!', context);

    }
    else if(orderedItemList.isEmpty){
      CommonFunction().showSnackBar('Add item in ordered list!', context);
    }
    else if (connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
      CommonFunction().showSnackBar('No internet!\nCheck internet connection', context);
    }
    else {

      // for Waiting UI
      CommonFunction().showLoadingIndicatorWithTitle(context: context, title: 'Updating...');

      // for generating order list
      List<Map<String, String>> orderListWithMap = [];
      for(var item in orderedItemList){
        orderListWithMap.add({
          'id' : item['id'],
          'name' : item['name'],
          'quantity' : item['quantity'],
          'price' : item['price'],
          'discount' : item['discount'],
          'discountType' : item['discountType'],
          'itemTotal' : item['itemTotal'],
        });
      }

      // calculating discount
      if(totalDiscountType =='%'){

        double discount = subTotal * (double.parse(totalDiscount) / 100);
        total = subTotal - discount;
        double tax = total * (double.parse(taxController.text.toString())/100);
        netBill = total + tax;
      }
      else{
        total = subTotal - double.parse(totalDiscount);
        double tax = total * (double.parse(taxController.text.toString())/100);
        netBill = total + tax;
      }

      Map<String, dynamic> invoice = {
        'invoiceId': widget.invoiceData.invoiceId,
        'customer': customerController.text,
        'phone': phoneController.text,
        'address': addressController.text,
        'discount': discountController.text,
        'discountType': totalDiscountType,
        'tax': taxController.text,
        'waiterName': selectedWaiterName,
        'waiterId': selectedWaiterId,
        'table': tableController.text,
        'dateTime': widget.invoiceData.dateTime,
        'paymentMethod': selectedPaymentMethod,
        'orders': orderListWithMap,
        'subTotal': subTotal.toStringAsFixed(2),
        'total': total.toStringAsFixed(2),
        'netBill': netBill.toStringAsFixed(2)
      };

      await InvoiceController().updateInvoice(docId: widget.invoiceData.invoiceId, invoice: invoice, context: context);


    }
  }

}