import 'package:cafe21/app_color.dart';
import 'package:cafe21/controller/dashboard_controller.dart';
import 'package:cafe21/views//invoice_list.dart';
import 'package:flutter/material.dart';
import 'package:cafe21/controller/drawer_controller.dart';
import 'admin_dashboard.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  bool isSelectedBottomButtonOne = true;
  bool isSelectedBottomButtonTwo = false;

  List waiterList = [], foodList = [], categoryList = [];
  List sellsData = [];
  List sellsDataFiltered = [];
  double totalTax = 0;
  double totalWithTax = 0;
  double totalWithoutTax = 0;
  String title = 'Today\'s sells data';


  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {

    sellsData = await DashboardController().getSellsData();
    foodList = await DashboardController().getAllFood();
    categoryList = await DashboardController().getAllFoodCategory();
    waiterList = await DashboardController().getAllWaiter();

    getDailyData();
    calculationInvoiceData();
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
      drawer: myDrawer(),
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          margin: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildTitleContainer(width, totalWithTax,),
                SizedBox(
                  height: 120,
                  child: Row(
                    children: [
                      BuildBoxContent(
                        title: 'Without Tax',
                        value: totalWithoutTax.toStringAsFixed(1),
                        color: AppColor.boxOne,
                      ),
                      BuildBoxContent(
                        title: 'Tax Collection',
                        value: (totalWithTax-totalWithoutTax).toStringAsFixed(2),
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
              color: Colors.white, borderRadius: BorderRadius.circular(32)),
          child: const BuildBottomNavbar(),
        ),
      ),
    );
  }

  Widget buildTitleContainer(width, value) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(16),
          height: width * 0.4,
          width: width,
          decoration: const BoxDecoration(color: Color(0xff7c79ea)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text('Sells'),
                      ),
                      Text(
                        '\$${value.toStringAsFixed(2)}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Text(
                    'Total No. invoice: ${sellsDataFiltered.length}',
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: getDataByDate,
                    icon: const Icon(Icons.calendar_month, color: Colors.white,),
                  ),
                  IconButton(
                    onPressed: getDailyData,
                    icon: const Icon(Icons.refresh, color: Colors.white,),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget myDrawer(){
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(child: Text('Logo')),
            accountName: Text('Manager'),
            accountEmail: Text('Chef de cuisine'),
          ),
          Expanded(
            child: ListView(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    getAllTotalData();
                  },
                  child: const DrawerListTile(
                    icon: Icons.account_balance_wallet_outlined,
                    text: 'Total summery',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    getDailyData();
                  },
                  child: const DrawerListTile(
                    icon: Icons.view_day_outlined,
                    text: 'Today\'s Data',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    getWeeklyData();
                  },
                  child: const DrawerListTile(
                    icon: Icons.weekend_outlined,
                    text: 'Weekly data',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    getMonthlyData();
                  },
                  child: const DrawerListTile(
                    icon: Icons.calendar_month,
                    text: 'Monthly data',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminDashboard(),));

                  },
                  child: const DrawerListTile(
                    icon: Icons.admin_panel_settings_outlined,
                    text: 'Admin area',
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await MyDrawerController().userLogOut(context);
                  },
                  child: const DrawerListTile(
                    icon: Icons.logout,
                    text: 'Logout',
                  ),
                ),
              ],
            ),
          ),

          ListTile(
            dense: true,
            leading: const Icon(Icons.devices),
            title: const Text('Developer info'),
            onTap: () {
              Navigator.pop(context);
              showAboutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> getDataByDate() async {

    String idForCompare, year, month, day;

    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    );

    if(date != null){
      year = date.year.toString();
      int pMonth = date.month;
      int pDay = date.day;


      if(pMonth<10) {
        month = pMonth.toString().padLeft(2, '0');
      }else {
        month = pMonth.toString();
      }
      if(pDay<10) {
        day = pDay.toString().padLeft(2, '0');
      }else {
        day = pDay.toString();
      }

      idForCompare = year+month+day;
      sellsDataFiltered = sellsData.where((element) => element.invoiceId.toString().substring(0, 8) == idForCompare).toList();
    }

    calculationInvoiceData();

  }

  Future<void> getDailyData() async {

    String idForCompare, year, month, day;
    DateTime date = DateTime.now();


      year = date.year.toString();
      int pMonth = date.month;
      int pDay = date.day;

      if(pMonth<10) {
        month = pMonth.toString().padLeft(2, '0');
      }else {
        month = pMonth.toString();
      }
      if(pDay<10) {
        day = pDay.toString().padLeft(2, '0');
      }else {
        day = pDay.toString();
      }

      idForCompare = year+month+day;

      sellsDataFiltered = sellsData.where((element) => element.invoiceId.toString().substring(0, 8) == idForCompare).toList();
      calculationInvoiceData();

  }

  getWeeklyData(){
    var sevenDaysAgoFromNow = DateTime.now().subtract(const Duration(days: 7));
    sellsDataFiltered = sellsData.where((element) => element.dateTime.toDate().isAfter(sevenDaysAgoFromNow)).toList();
    calculationInvoiceData();
    setState(() {});
  }

  getMonthlyData(){
    var now = DateTime.now();
    var thirtyDaysAgoFromNow = DateTime(now.year, now.month-1, now.day);
    sellsDataFiltered = sellsData.where((element) => element.dateTime.toDate().isAfter(thirtyDaysAgoFromNow)).toList();
    calculationInvoiceData();
    setState(() {});
  }
  getAllTotalData(){
    sellsDataFiltered = sellsData;
    calculationInvoiceData();
  }

  calculationInvoiceData(){

    totalWithTax = 0;
    totalWithoutTax = 0;

    for (var item in sellsDataFiltered) {

      totalWithTax = totalWithTax + double.parse(item.netBill);
      totalWithoutTax = totalWithoutTax + double.parse(item.total);
    }
    setState(() {

    });
    // print(totalWithTax);
    // print(totalWithoutTax);
  }

  showAboutDialog(context){
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        scrollable: true,
        backgroundColor: Colors.purple.shade500,
        elevation: 24,
        actionsAlignment: MainAxisAlignment.center,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage('assets/images/logo.png'),
            ),
            const SizedBox(height: 16,),
            const Text('Brain Storm 21', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 25),),
            Text('Your Complete it partner', style: TextStyle(color: Colors.grey.shade300),),
            Text('www.brainstorm21.com', style: TextStyle(color: Colors.grey.shade300),),
            Text('Cell: +8801521466603', style: TextStyle(color: Colors.grey.shade300),),
            const SizedBox(height: 16,),
            const Text('Email:\nquery@brainstorm21.com', textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),

          ],

        ),
        actions: [
          MaterialButton(
            shape: const StadiumBorder(),
            onPressed: () => Navigator.pop(context),
            textColor: Colors.white,
            color: const Color(AppColor.box7),
            child: const Text('OK'),
          )
        ],
      );
    },);
  }
}


// classes for views

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

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key, required this.icon, required this.text,

  }) : super(key: key);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, top: 4, bottom: 4),
      child: Row(
        children:  [
          Icon(icon, color: Colors.grey.shade700),
          const SizedBox(width: 16,),
          Text(text, style: const TextStyle(fontWeight: FontWeight.w500),)],
      ),
    );
  }
}