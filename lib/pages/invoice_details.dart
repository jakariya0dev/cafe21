import 'package:flutter/material.dart';
import '../const.dart';
import '../widget/invoice_item.dart';

class InvoiceDetails extends StatefulWidget {
  const InvoiceDetails({Key? key}) : super(key: key);

  @override
  State<InvoiceDetails> createState() => _InvoiceDetailsState();
}

class _InvoiceDetailsState extends State<InvoiceDetails> {
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

            }, icon: const Icon(Icons.edit, color: Colors.white,)),
            IconButton(onPressed: (){}, icon: const Icon(Icons.delete_forever, color: Colors.white,)),
          ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // constraints: const BoxConstraints.expand(),
            // height: MediaQuery.of(context).size.height,
            height: 10*(65+10)+230+16+96,
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [

                _BuildNameContainer(),
                 SizedBox(height: 16),
                _BuildBoxRow(),
                _BuildOrderItemList()


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
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      // color: Colors.amber,
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),

                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      CircleAvatar(
                           radius: 10,
                          child: Text('id', style: TextStyle(fontSize: 11),),),
                      SizedBox(width: 5,),
                      Text('1234567890', style: TextStyle(fontSize: 12, color: Colors.black45, fontWeight: FontWeight.bold))
                    ],
                  ),),
                const Padding(
                  padding:  EdgeInsets.symmetric(vertical: 8.0,),
                  child: Text('Zakaria Hossain', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: Colors.white),),
                ),
                Row(
                  children: const [
                    Text('✆ 01762940480', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    SizedBox(width: 8,),
                    Text('Served by', style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),),
                    SizedBox(width: 4,),
                    Text('Jack', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),

                  ],
                )
              ],
            ),
          ),
          _BuildPriceCard()
        ],
      ),
    );
  }
}

class _BuildPriceCard extends StatelessWidget {
  const _BuildPriceCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      // bottom: 10,
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
                  // blurRadius: 0.1,
                  // offset: Offset(4, 4),
                  // spreadRadius: 4
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
                      'Payment method'.toUpperCase(),
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Online Payment',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'ordered at'.toUpperCase(),
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Aug 24, 2020 12:30 pm',
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

                Text('total amount'.toUpperCase(), style: const TextStyle(fontSize: 11, color: Colors.grey),),
                 Text('\$1000', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.grey.shade700),)

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
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        _BuildBoxContent(title: 'discount', value: '10%', color: 0xfffbb35f),
        _BuildBoxContent(title: ' service Tax', value: '10%', color: 0xff09af80),
        _BuildBoxContent(title: 'table no.', value: '01', color: 0xfff65d5a),
      ],
    );
  }
}

class _BuildOrderItemList extends StatelessWidget {
  const _BuildOrderItemList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),

      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index){
        return _BuildListTile(inedx: index);
      }, separatorBuilder: (context, index){
        return const SizedBox(height: 10,);
      }, itemCount: 10,),
    ));
  }
}

class _BuildListTile extends StatelessWidget {
  const _BuildListTile({
    Key? key,
    required this.inedx
  }) : super(key: key);
 final inedx;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.all(8),
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
            children: const [
              Text('100', style: Const.invDetailsListTitle,),
              Icon(Icons.close, color: Colors.grey,),
              Text('100', style: Const.invDetailsListTitle,),
              Expanded(child: SizedBox()),
              Text('\$1100', style: Const.invDetailsListTitle,),
            ],
          ),
           Text('${inedx+1}. this an item title', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.grey.shade600,),
           )],

      ),
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

  final title, value, color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 80,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(color),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(value,style: const TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),),
        Text(title.toUpperCase(), style: const TextStyle(fontSize: 11, color: Colors.white),),
      ],
    ),);
  }
}
