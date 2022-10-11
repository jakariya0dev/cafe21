import 'package:cafe21/model/invoice_model.dart';
import 'package:cafe21/views/invoice_list.dart';
import 'package:cafe21/views/invoice_print.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cafe21/const.dart';
import 'package:cafe21/controller/common_function.dart';
import 'package:cafe21/cons/const_string.dart';
import 'package:cafe21/widget/discount_container.dart';
import 'package:cafe21/views/invoice_update.dart';

class InvoiceDetails extends StatefulWidget {
  const InvoiceDetails({Key? key, required this.invoiceData, required this.isServerData}) : super(key: key);

  final InvoiceModel invoiceData;
  final bool isServerData;

  @override
  State<InvoiceDetails> createState() => _InvoiceDetailsState();
}

class _InvoiceDetailsState extends State<InvoiceDetails> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late double netBill, totalAmountAfterDiscount, totalAmount = 0;
  SharedPreferences? pref;

  @override
  initState() {
    super.initState();
    init();
  }

  init() async {
    for (var i = 0; i < widget.invoiceData.orders.length; i++) {
      totalAmount = totalAmount +
          (double.parse(widget.invoiceData.orders[i]['itemTotal']));
    }
    totalAmountAfterDiscount = totalAmount -
        (totalAmount * (int.parse(widget.invoiceData.discount) / 100));
    netBill = totalAmountAfterDiscount +
        (totalAmountAfterDiscount * (int.parse(widget.invoiceData.tax) / 100));

    pref = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue.shade800,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: () {
                if (pref?.getString('userRole') == 'admin') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InvoiceUpdate(
                                invoiceData: widget.invoiceData,
                              )));
                } else {
                  CommonFunction().showWarningDialog(
                      'Only admin can edit invoice', context);
                }
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () async {
                if (pref?.getString(ConstString.userRole) ==
                    ConstString.userRoleAdmin) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InvoiceList()));
                } else {
                  CommonFunction().showWarningDialog(
                      'Only admin can delete invoice', context);
                }
              },
              icon: const Icon(
                Icons.delete_forever,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InvoicePrint(
                              invoiceData: widget.invoiceData,
                              isServerData: true,
                            )));
              },
              icon: const Icon(
                Icons.print,
                color: Colors.white,
              )),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Flexible(
            child: Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _BuildNameContainer(
                      id: widget.invoiceData.invoiceId,
                      name: widget.invoiceData.customer,
                      phone: widget.invoiceData.phone,
                      waiterName: widget.invoiceData.waiterName,
                      waiterId: widget.invoiceData.waiterId,
                      paymentMethod: widget.invoiceData.paymentMethod,
                      date: DateFormat.yMMMd()
                          .add_jm()
                          .format(widget.invoiceData.dateTime.toDate())
                          .toString(),
                      totalAmount: widget.invoiceData.subTotal,
                      totalAmountAfterDiscount: widget.invoiceData.total,
                      netAmount: widget.invoiceData.netBill,
                      address: widget.invoiceData.address),
                  const SizedBox(height: 16),
                  _BuildBoxRow(
                      discount: widget.invoiceData.discount,
                      discountType: widget.invoiceData.discountType,
                      tax: widget.invoiceData.tax,
                      table: widget.invoiceData.table),
                  _BuildOrderItemList(
                    orders: widget.invoiceData.orders,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BuildNameContainer extends StatelessWidget {


  const _BuildNameContainer({
    Key? key,
    required this.id,
    required this.name,
    required this.phone,
    required this.paymentMethod,
    required this.date,
    required this.totalAmount,
    required this.totalAmountAfterDiscount,
    required this.netAmount,
    required this.address,
    required this.waiterName,
    required this.waiterId,
  }) : super(key: key);

  final String id, name, phone, paymentMethod, date, address, waiterName, waiterId;
  final String totalAmount, totalAmountAfterDiscount, netAmount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Stack(
        children: [
          Container(
            height: 180,
            width: double.maxFinite,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.blue.shade800,
                  Colors.blue.shade500,
                ])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircleAvatar(
                            radius: 10,
                            child: Text(
                              'id',
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(id,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      date,
                      style: Const.italicStyleSubHeading,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        paymentMethod,
                        style: Const.italicStyleSubHeading,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    const Text(
                      'Cell: ',
                      style: Const.italicStyleSubHeading,
                    ),
                    Text(
                      phone,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      'Served by',
                      style: Const.italicStyleSubHeading,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      waiterName,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          ),
          _BuildPriceCard(
            totalAmount: totalAmount,
            totalAmountAfterDiscount: totalAmountAfterDiscount,
            netAmount: netAmount,
          )
        ],
      ),
    );
  }
}

class _BuildPriceCard extends StatelessWidget {
  const _BuildPriceCard({
    Key? key,
    required this.totalAmount,
    required this.totalAmountAfterDiscount,
    required this.netAmount,
  }) : super(key: key);

  final String totalAmount, totalAmountAfterDiscount, netAmount;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: 100,
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
              )
            ]),
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Amount'.toUpperCase(),
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    const SizedBox(height: 2),
                    RichText(
                      text: TextSpan(
                          text: '\$',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade400),
                          children: [
                            TextSpan(
                              text: totalAmount,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade700),
                            )
                          ]
                      ),),
                    const SizedBox(height: 12),
                    Text(
                      'After discount'.toUpperCase(),
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    const SizedBox(height: 2),
                    RichText(
                      text: TextSpan(
                      text: '\$',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey.shade400),
                      children: [
                        TextSpan(
                          text: totalAmountAfterDiscount,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700),
                        )
                      ]
                    ),),
                  ],
                ),
              ),
            ),
            VerticalDivider(
              color: Colors.grey.shade300,
              thickness: 1,
              endIndent: 10,
              indent: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Net bill'.toUpperCase(),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),

                    child: RichText(
                      text: TextSpan(
                        text: '\$',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.shade400),
                        children: [
                          TextSpan(
                            text : netAmount,
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    '\$${(double.parse(netAmount) - double.parse(totalAmountAfterDiscount)).toStringAsFixed(1)} Service tax added',
                    style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _BuildBoxRow extends StatelessWidget {
  const _BuildBoxRow({
    Key? key,
    required this.discount,
    required this.tax,
    required this.table,
    required this.discountType,
  }) : super(key: key);

  final String discount, discountType, tax, table;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _BuildBoxContent(
            title: 'discount',
            value: discount,
            type: discountType,
            color: 0xfffbb35f),
        _BuildBoxContent(
            title: 'service Tax', value: tax, type: '%', color: 0xff09af80),
        _BuildBoxContent(
            title: 'Table no', value: table, type: '', color: 0xff656565),
      ],
    );
  }
}

class _BuildBoxContent extends StatelessWidget {
  const _BuildBoxContent(
      {Key? key,
      required this.title,
      required this.value,
      required this.type,
      required this.color})
      : super(key: key);

  final String title, value, type;
  final int color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 85,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Color(color), borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
              text: TextSpan(
                  text: value,
                  style: const TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                  children: [
                TextSpan(text: type, style: const TextStyle(fontSize: 14, color: Colors.white70))
              ])),
          const SizedBox(
            height: 5,
          ),
          Text(
            title.toUpperCase(),
            style: const TextStyle(fontSize: 11, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _BuildOrderItemList extends StatelessWidget {
  const _BuildOrderItemList({
    Key? key,
    required this.orders,
  }) : super(key: key);

  final List orders;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemBuilder: (context, index) {
      return _BuildListTile(
        index: index,
        orders: orders,
      );
    },
    separatorBuilder: (context, index) {
      return const SizedBox(
        height: 10,
      );
    },
    itemCount: orders.length,
      ),
    );
  }
}

class _BuildListTile extends StatelessWidget {
  const _BuildListTile({
    Key? key,
    required this.index,
    required this.orders,
  }) : super(key: key);

  final int index;
  final List orders;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.09),
          border: const Border(left: BorderSide(color: Colors.blue, width: 5))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                orders[index]["price"].toString(),
                style: Const.invDetailsListTitle,
              ),
              const Icon(
                Icons.close,
                color: Colors.grey,
                size: 16,
              ),
              Text(
                orders[index]["quantity"].toString(),
                style: Const.invDetailsListTitle,
              ),
              const SizedBox(width: 5),
              DiscountContainer(
                discount: orders[index]["discount"],
                type: orders[index]["discountType"],
              ),
              const Expanded(child: SizedBox()),
              RichText(text: TextSpan(
                text: '\$',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.blueGrey.shade200),
                children: [
                  TextSpan(
                    text: orders[index]['itemTotal'],
                    style: Const.invDetailsListPrice,
                  )
                ]
              ))
            ],
          ),
          Text(
            '${index + 1}. ${orders[index]["name"]}',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          )
        ],
      ),
    );
  }
}
