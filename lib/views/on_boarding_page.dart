import 'package:cafe21/views/create_cafe_admin.dart';
import 'package:flutter/material.dart';
import 'package:cafe21/model/data.dart';
import 'package:flutter_svg/svg.dart';

import 'dashboard_page.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  
  int pageIndex = 0;

  final List _onBoardingIcons = ['assets/on_svg/category.svg', 'assets/on_svg/food.svg', 'assets/on_svg/waiter.svg', 'assets/on_svg/invoice.svg'];

  final List _titles = ['First, Add Categories', 'Second, Add Food Items', 'Third, Add Waiters Name', 'Final, Create Invoices'];
  final List _descriptions = ['First step, after creating admin account go to drawer section. Then click \'Admin Area\'. Then select category from bottom and add category name from top', 'Second step, after adding category name select foods section, Click add food from top bar. and fill the all necessary data then save it', 'Third step, you have to add Waiters Name. For now have added a test waiter, you can edit or delete it. And add new waiter data from waiter section', 'Final step, after completing all step now you can add invoice. Back to dashboard page and click new sale or invoice and save it '];

  @override
  Widget build(BuildContext context) {

    // double height = MediaQuery.of(context).size.height;
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
              SizedBox(
                height: width * 0.75,
                width: width * 0.75,
                child: SvgPicture.asset(
                    _onBoardingIcons[pageIndex],
                    semanticsLabel: 'Acme Logo'
                ),
              ),
              const SizedBox(height: 32),
              Text(_titles[pageIndex], style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.deepPurple), textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Text(_descriptions[pageIndex], style: const TextStyle(fontSize: 16, color: Color(
                  0xff161346)), textAlign: TextAlign.center,),
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
              onPressed: pageIndex == 0 ? null : () {
                pageIndex--;
                setState(() {});
              },
              child: const Text('Back', style: TextStyle(fontWeight: FontWeight.w500),),
            ),
            Row(
              children: List.generate(4, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Icon(Icons.circle, size: 8, color: index == pageIndex ? Colors.purple : Colors.grey,),
                );
              }),
            ),
            TextButton(
              onPressed: pageIndex == 3 ? () async {
                if(prefs?.getBool('isNotFirstInstall')==true){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DashBoard()));
                }
                else{
                  await prefs?.setBool('isNotFirstInstall', true).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateCafeAdmin())));
                  
                }

              } : () {
                pageIndex++;
                    setState(() {});
              },
              child: pageIndex == 3 ? const Text('Finish') : const Text('Next', style: TextStyle(fontWeight: FontWeight.w500),),
            )
          ],
        ),
      ),
    );
  }
}
