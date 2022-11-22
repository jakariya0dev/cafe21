import 'package:cafe21/controller/common_function.dart';
import 'package:cafe21/views/create_cafe_admin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard_page.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  late SharedPreferences prefs;

  @override
  initState(){
    init();
    super.initState();
  }

  init() async {
    prefs = await SharedPreferences.getInstance();
  }
  
  int index = 0;

  List icons = ['assets/icons/icon_waiter.png', 'assets/icons/icon_food.png', 'assets/icons/icon_invoice.png'];

  List descriptions = ['First add your waiter data in database', 'Next add your food category and all of you food item data', 'And after that you can add new sales data'];

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(32),
          constraints: const BoxConstraints.expand(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(icons[index], height: width*0.25, width: width*0.25),
              const SizedBox(height: 32),
              Text(descriptions[index], style: const TextStyle(fontSize: 22), textAlign: TextAlign.center,)
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: index == 0 ? null : () {
                index--;
                setState(() {});
              },
              child: const Icon(Icons.arrow_back_ios),
            ),
            TextButton(
              onPressed: index == 2 ? () async {

                await prefs.setBool('isNotFirstInstall', true);
                await CommonFunction.generateDatabase();
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateCafeAdmin()));
              } :() {
                index++; setState(() {});
              },
              child: index == 2 ? const Text('Finish') : const Icon(Icons.arrow_forward_ios),
            )
          ],
        ),
      ),
    );
  }
}
