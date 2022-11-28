import 'package:cafe21/views/invoice/invoice_list.dart';
import 'package:flutter/material.dart';

class BuildBottomNavbar extends StatelessWidget {
  const BuildBottomNavbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(child: Container(
            alignment: Alignment.center,
            child: const Text('Dashboard'))),
        Expanded(
          child: MaterialButton(
            height: double.infinity,
            shape: const StadiumBorder(),
            color: const Color(0xff40407a),
            textColor: Colors.white,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const InvoiceList(),));
            }, child: const Text('invoice'),),
        )
      ],
    );
  }
}