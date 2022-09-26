import 'package:cafe21/app_color.dart';
import 'package:cafe21/controller/dashboard_controller.dart';
import 'package:cafe21/views//invoice_list.dart';
import 'package:cafe21/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:cafe21/cons/const_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  bool isSelectedBottomButtonOne = true;
  bool isSelectedBottomButtonTwo = false;
  late SharedPreferences prefs;

  List waiterList = [], foodList = [], categoryList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {

    foodList = await DashboardController().getAllFood();
    categoryList = await DashboardController().getAllFoodCategory();
    waiterList = await DashboardController().getAllWaiter();


    // print(totalFood);
    prefs = await SharedPreferences.getInstance();
    // print(prefs.getBool(ConstString.isLogged));
    // print(prefs.getString(ConstString.userRole));
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(

        title: const Text('Sells Dashboard'),
        titleTextStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      ),
      drawer: const MyDrawer(),
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          margin: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(16),
                  height: width * 0.4,
                  width: width,
                  decoration: const BoxDecoration(color: Color(0xff7c79ea)
                      // color: Colors.white
                      ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Todays Sells Data',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                // color:  Color(0xff6a67dc),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            child: const Text('Sells'),
                          ),
                          const Text(
                            '\$10,000',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      const Text(
                        'Total No. invoice 10 6',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 120,
                  child: Row(
                    children: const [
                      BuildBoxContent(
                        title: 'Without Tax',
                        value: '100',
                        color: AppColor.boxOne,
                      ),
                      BuildBoxContent(
                        title: 'Tax Collection',
                        value: '100',
                        color: AppColor.boxTwo,
                      ),
                      // BuildBoxContent(title: 'Tax Collection', value: '100', color: AppColor.boxThree,),
                    ],
                  ),
                ),
                const _BuildMostSellerList(title: 'Most Selling Food Item', name: 'Chicken Curry Masala', value: '100',),
                const _BuildMostSellerList(title: 'Most Dishes Serve By', name: 'Zakaria Hossain', value: '100'),
                SizedBox(
                  height: 120,
                  child: Row(
                    children: [
                      BuildBoxContent(
                        title: 'total Food',
                        value: '${foodList.length}',
                        color: AppColor.box4,
                      ),
                      BuildBoxContent(
                        title: 'total Category',
                        value: '${categoryList.length}',
                        color: AppColor.box5,
                      ),
                      // BuildBoxContent(title: 'Tax Collection', value: '100', color: AppColor.boxThree,),
                    ],
                  ),
                ),
                SizedBox(
                  height: 120,
                  child: Row(
                    children:  [
                      BuildBoxContent(
                        title: 'Total Waiter',
                        value: '${waiterList.length}',
                        color: AppColor.box6,
                      ),
                      const BuildBoxContent(
                        title: 'App User',
                        value: '02',
                        color: AppColor.box7,
                      ),
                      // BuildBoxContent(title: 'Tax Collection', value: '100', color: AppColor.boxThree,),
                    ],
                  ),
                ),
                // Container(
                //   margin: const EdgeInsets.all(1),
                //   child: Column(
                //     children: [
                //       Row(
                //         children: [
                //           Expanded(
                //             child: Container(
                //               height: 100,
                //               color: Colors.blue,
                //               child: const Text('Hello World'),
                //             ),
                //           ),
                //           Expanded(
                //               child: Container(
                //             color: Colors.purple,
                //             child: const Text('Hello World'),
                //           ))
                //         ],
                //       ),
                //       Row(
                //         children: [
                //           Expanded(
                //               child: Container(
                //             color: Colors.amber,
                //             child: const Text('Hello World'),
                //           )),
                //           Expanded(
                //               child: Container(
                //             color: Colors.green,
                //             child: const Text('Hello World'),
                //           ))
                //         ],
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          ),

        ),
      ),
      bottomNavigationBar: SizedBox(
        height: height * 0.08,
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white,
            borderRadius: BorderRadius.circular(32)
          ),

          child: const BuildBottomNavbar(),
        ),
      ),
    );
  }
}

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

class _BuildMostSellerList extends StatelessWidget {
  const _BuildMostSellerList({
    Key? key, required this.title, required this.name, required this.value,
  }) : super(key: key);

  final String title, name, value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: Color(0xff40407a)),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.white,
            // foregroundColor: Colors.white,
            child: Icon(
              Icons.ac_unit,
              // color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  fontSize: 15,
                ),
                ),
                Text(name,
                  style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.white),
                ),
              ],
            ),
          ),
           Text(value,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class BuildBoxContent extends StatelessWidget {
  const BuildBoxContent(
      {Key? key, required this.title, required this.value, required this.color})
      : super(key: key);

  final String title, value;
  final int color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Color(color), borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            value.isEmpty ? const Center(child: CircularProgressIndicator(color: Colors.white,)) : Text(
              value,
              style: const TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              title.toUpperCase(),
              style: const TextStyle(fontSize: 11, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}