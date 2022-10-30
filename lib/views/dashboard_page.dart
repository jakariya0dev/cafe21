import 'package:cafe21/app_color.dart';
import 'package:cafe21/controller/common_function.dart';
import 'package:cafe21/controller/dashboard_controller.dart';
import 'package:cafe21/views//invoice_list.dart';
import 'package:flutter/material.dart';
import 'package:cafe21/controller/drawer_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cafe21/cons/const_string.dart';
import 'package:cafe21/model/data.dart';
import 'admin_dashboard.dart';
import 'invoice_entry.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  bool isSelectedBottomButtonOne = true;
  bool isSelectedBottomButtonTwo = false;

  List sellsDataFiltered = [];

  // for calculating most selling things and waiter
  Map <String, int> countMostSellingFood = {};
  Map <String, int> countMostServingPerson = {};

  double totalTax = 0;
  double totalWithTax = 0;
  double totalWithoutTax = 0;
  String title = 'Today\'s sells data';
  SharedPreferences? prefs;
  String? userRole;


  @override
  void initState() {
    allSellsData.clear();
    init();
    super.initState();

  }

  init() async {

    await DashboardController().getAllSellsData();
    await DashboardController().getAllFood();
    await DashboardController().getAllFoodCategory();
    await DashboardController().getAllWaiter();

    // user role remember
    prefs = await SharedPreferences.getInstance();
    userRole = prefs?.getString(ConstString.userRole);
    getDailyData();
    calculationInvoiceData();
    calculateMostSellingItem();
    setState(() {});

  }

  getWeeklyData(){
    var sevenDaysAgoFromNow = DateTime.now().subtract(const Duration(days: 7));
    sellsDataFiltered = allSellsData.where((element) => element.dateTime.toDate().isAfter(sevenDaysAgoFromNow)).toList();
    calculationInvoiceData();
    setState(() {});
  }

  getMonthlyData(){
    var now = DateTime.now();
    var thirtyDaysAgoFromNow = DateTime(now.year, now.month-1, now.day);
    sellsDataFiltered = allSellsData.where((element) => element.dateTime.toDate().isAfter(thirtyDaysAgoFromNow)).toList();
    calculationInvoiceData();
    setState(() {});
  }

  getAllTotalData(){
    sellsDataFiltered = allSellsData;
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

  calculateMostSellingItem(){

    List foodIdFromInvoice = [];
    List waiterNameFromInvoice = [];

    Map <String, int> countMostSellingFoodBeforeSort = {};
    Map <String, int> countMostServingPersonBeforeSort = {};

    // getting all food id and waiter name from invoices
    for (var invoice in allSellsData) {

      waiterNameFromInvoice.add(invoice.waiterName);

      for(var item in invoice.orders){
        foodIdFromInvoice.add(item['id']);
      }

    }

    // SUM of food orders
    for (var foodId in foodIdFromInvoice){
      countMostSellingFoodBeforeSort[foodId] = (countMostSellingFoodBeforeSort[foodId] ?? 0) + 1;
    }

    // SUM of waiter orders
    for (var waiterName in waiterNameFromInvoice){
      countMostServingPersonBeforeSort[waiterName] = (countMostServingPersonBeforeSort[waiterName] ?? 0) + 1;
    }

    // reversed the map ex:321
    countMostSellingFood = Map.fromEntries(
        countMostSellingFoodBeforeSort.entries.toList()..sort((e1, e2) => e2.value.compareTo(e1.value)));
    countMostServingPerson = Map.fromEntries(
        countMostServingPersonBeforeSort.entries.toList()..sort((e1, e2) => e2.value.compareTo(e1.value)));


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
      sellsDataFiltered = allSellsData.where((element) => element.invoiceId.toString().substring(0, 8) == idForCompare).toList();
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

    sellsDataFiltered = allSellsData.where((element) => element.invoiceId.toString().substring(0, 8) == idForCompare).toList();
    calculationInvoiceData();

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
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: MaterialButton(
                color: const Color(AppColor.box5),
                onPressed: CommonFunction().saveDemoInvoice,//() => Navigator.push(context, MaterialPageRoute(builder: (context) => const InvoiceEntry(),)),
                child: Text(
                  'New sell',
                  style: TextStyle(color: Colors.grey.shade100),
                )),
          ),
        ],
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
                _BuildMostSellingItem(
                  width: width,
                  height: height,
                  items: countMostSellingFood,
                  foods: allFoodsData,
                  title: 'Most Selling Foods'
                ),
                SizedBox(
                  height: 120,
                  child: Row(
                    children: [
                      BuildBoxContent(
                        title: 'total Food',
                        value: '${allFoodsData.length}',
                        color: AppColor.box4,
                      ),
                      BuildBoxContent(
                        title: 'total Category',
                        value: '${allCategoryData.length}',
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
                        value: '${allWaiterData.length}',
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
                _BuildMostSellerList(
                  width: width,
                  height: height,
                  items: countMostServingPerson,
                  waiterList: allWaiterData,
                  title: 'Most Serving Waiter'
                ),
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
          UserAccountsDrawerHeader(
            currentAccountPicture: const CircleAvatar(child: Text('Logo')),
            accountName: Text(userRole.toString()),
            accountEmail: const Text('Chef de cuisine'),
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

class _BuildMostSellingItem extends StatelessWidget {
  const _BuildMostSellingItem({
    Key? key, required this.items, required this.height, required this.width, required this.foods, required this.title,
  }) : super(key: key);

  final Map items;
  final List foods;
  final double height, width;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: Color(0xff40407a)),
      child: items.isEmpty ? const Center(child: CircularProgressIndicator()) : Column(
        children: [
          Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(
            height: 16
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                List food = foods.where((element) => element['id'] == items.keys.elementAt(index)).toList();
                return Container(
                  height: 32,
                  padding: const EdgeInsets.all(8),
                  color: index%2==0? Colors.blue.shade300 : Colors.blue.shade200,
                  child: Row(
                    children: [
                      Expanded(child: Text('${index+1}. ${food[0]['name']}')),
                      Text(items.values.elementAt(index).toString())
                    ],
                  ),
                );
              },),
          )
        ],
      ),
    );
  }
}

class _BuildMostSellerList extends StatelessWidget {
  const _BuildMostSellerList({
    Key? key, required this.items, required this.height, required this.width, required this.waiterList, required this.title,
  }) : super(key: key);

  final Map items;
  final List waiterList;
  final double height, width;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: Color(0xff40407a)),
      child: items.isEmpty ? const Center(child: CircularProgressIndicator()) : Column(
        children:  [
           Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {

                List waiter = waiterList.where((element) => element['name'] == items.keys.elementAt(index)).toList();

              return Container(
                height: 32,
                padding: const EdgeInsets.all(8),
                color: index%2==0? Colors.blue.shade300 : Colors.blue.shade200,
                child: Row(
                  children: [
                    Text('${index+1}. '),
                    Expanded(child: Text(waiter[0]['name'] ?? '')), // ${}
                    Text(items.values.elementAt(index).toString())
                  ],
                ),
              );
            },),
          )
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