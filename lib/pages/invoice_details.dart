import 'package:cafe21/model/invoice_model.dart';
import 'package:cafe21/pages/invoice.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../const.dart';
import 'invoice_update.dart';

class InvoiceDetails extends StatefulWidget {
  const InvoiceDetails({Key? key, required this.invoiceData}) : super(key: key);

  final InvoiceModel invoiceData;


  @override
  State<InvoiceDetails> createState() => _InvoiceDetailsState();
}

class _InvoiceDetailsState extends State<InvoiceDetails> {

  late double netBill;
  double totalAmount = 0;
  late double totalAmountAfterDiscount;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(widget.invoiceData.customer);

    for(var i = 0; i < widget.invoiceData.orders.length; i++ ){

      totalAmount = totalAmount + (int.parse(widget.invoiceData.orders[i]['price'])*int.parse(widget.invoiceData.orders[i]['quantity']));
    }
    totalAmountAfterDiscount = totalAmount - (totalAmount*(int.parse(widget.invoiceData.discount)/100));
    netBill = totalAmountAfterDiscount + (totalAmountAfterDiscount*(int.parse(widget.invoiceData.tax)/100));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue.shade800,
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.close, color: Colors.white,)),
          actions: [
            IconButton(onPressed: (){

              Navigator.push(context, MaterialPageRoute(builder: (context) => const InvoiceUpdate()));
            }, icon: const Icon(Icons.edit, color: Colors.white,)),
            IconButton(onPressed: (){}, icon: const Icon(Icons.delete_forever, color: Colors.white,)),
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Invoice(invoiceData: widget.invoiceData, isServerData: true,)));
            }, icon: const Icon(Icons.print, color: Colors.white,)),

          ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(

            height: widget.invoiceData.orders.length*(65+10)+230+16+100,
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _BuildNameContainer(id: widget.invoiceData.invoiceId, name: widget.invoiceData.customer, phone: widget.invoiceData.phone, waiter: widget.invoiceData.waiter, paymentMethod: "Online Payment", date: DateFormat.yMMMd().add_jm().format(widget.invoiceData.dateTime.toDate()).toString(), totalAmount: totalAmount, totalAmountAfterDiscount: totalAmountAfterDiscount, netAmount: netBill,),
                const SizedBox(height: 16),
                _BuildBoxRow(discount: widget.invoiceData.discount, tax: widget.invoiceData.tax, table: widget.invoiceData.table),
                _BuildOrderItemList(orders: widget.invoiceData.orders,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BuildNameContainer extends StatelessWidget {
  const _BuildNameContainer({
    Key? key,required this.id,required this.name,required this.phone,required this.waiter,required this.paymentMethod,required this.date, required this.totalAmount, required this.totalAmountAfterDiscount, required this.netAmount,
  }) : super(key: key);

  final String id, name, phone, waiter, paymentMethod, date;
  final double totalAmount, totalAmountAfterDiscount, netAmount;

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
                ]
              )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children:  [
                          const CircleAvatar(
                               radius: 10,
                              child: Text('id', style: TextStyle(fontSize: 11),),),
                          const SizedBox(width: 5,),
                          Text(id, style: const TextStyle(fontSize: 12, color: Colors.black45, fontWeight: FontWeight.bold))
                        ],
                      ),),
                    const SizedBox(width: 10,),
                    Text(date, style: Const.italicStyleSubHeading,)
                  ],
                ),
                 Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(name, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),),
                      const SizedBox(width: 8,),
                      const Text('Online Payment', style: Const.italicStyleSubHeading,)
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Text('Cell: ', style: Const.italicStyleSubHeading,),
                    Text(phone, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    const SizedBox(width: 8,),
                    const Text('Served by', style: Const.italicStyleSubHeading,),
                    const SizedBox(width: 4,),
                    Text(waiter, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),

                  ],
                )
              ],
            ),
          ),
          _BuildPriceCard(totalAmount: totalAmount, totalAmountAfterDiscount: totalAmountAfterDiscount, netAmount: netAmount,)
        ],
      ),
    );
  }
}

class _BuildPriceCard extends StatelessWidget {
  const _BuildPriceCard({
    Key? key,
    required this.totalAmount, required this.totalAmountAfterDiscount, required this.netAmount,
  }) : super(key: key);

  final double totalAmount, totalAmountAfterDiscount, netAmount;

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
            ]
        ),
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
                    Text(
                      '\$$totalAmount',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'After discount'.toUpperCase(),
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '\$$totalAmountAfterDiscount',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700),
                    ),
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
            Padding(padding: const EdgeInsets.all(16), child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text('Net bill'.toUpperCase(), style: const TextStyle(fontSize: 12, color: Colors.grey),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text('\$$netAmount', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.grey.shade700),),
                ),
                Text('\$${(netAmount-totalAmountAfterDiscount).toStringAsFixed(1)} Service tax added', style: const TextStyle(fontSize: 10, color: Colors.grey, fontStyle: FontStyle.italic),),
              ],
            ),)
          ],
        ),

      ),
    );
  }
}

class _BuildBoxRow extends StatelessWidget {
  const _BuildBoxRow({
    Key? key,required this.discount,required this.tax,required this.table,
  }) : super(key: key);

  final String discount, tax, table;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _BuildBoxContent(title: 'discount', value: '$discount%', color: 0xfffbb35f),
        _BuildBoxContent(title: 'service Tax', value: '$tax%', color: 0xff09af80),
        _BuildBoxContent(title: 'Table no', value: table, color: 0xff656565),

      ],
    );
  }
}

class _BuildBoxContent extends StatelessWidget {
  const _BuildBoxContent({
    Key? key,
    required this.title,
    required this.value,
    required this.color
  }) : super(key: key);

  final String title, value;
  final int color;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 85,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(color),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(value,style: const TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.normal),),
        const SizedBox(height: 5,),
        Text(title.toUpperCase(), style: const TextStyle(fontSize: 11, color: Colors.white),),
      ],
    ),);
  }
}

class _BuildOrderItemList extends StatelessWidget {
  const _BuildOrderItemList({
    Key? key, required this.orders,
  }) : super(key: key);

  final List orders;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),

      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index){
          return _BuildListTile(index: index, orders: orders,);
        }, separatorBuilder: (context, index){
        return const SizedBox(height: 10,);
      }, itemCount: orders.length,),
    ));
  }
}

class _BuildListTile extends StatelessWidget {
  const _BuildListTile({
    Key? key,
    required this.index, required this.orders,
  }) : super(key: key);

  final int index;
  final List orders;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration:  BoxDecoration(
          color: Colors.blue.withOpacity(0.09),
          border: const Border(
              left: BorderSide(
                  color: Colors.blue,
                  width: 5
              )
          )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children:  [
              Text(orders[index]["price"].toString(), style: Const.invDetailsListTitle,),
              const Icon(Icons.close, color: Colors.grey, size: 16,),
              Text(orders[index]["quantity"].toString(), style: Const.invDetailsListTitle,),
              const Expanded(child: SizedBox()),
              Text('\$${(int.parse(orders[index]["price"])*int.parse(orders[index]["quantity"]))}', style: Const.invDetailsListPrice,),
            ],
          ),
          Text('${index+1}. ${orders[index]["name"]}', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.grey.shade700,),
          )],

      ),
    );
  }
}