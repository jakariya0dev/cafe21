import 'package:cafe21/cons/app_color.dart';
import 'package:cafe21/controller/dashboard_controller.dart';
import 'package:cafe21/widget/dashboard/bottom_nav.dart';
import 'package:cafe21/widget/dashboard/build_box_content.dart';
import 'package:cafe21/widget/dashboard/build_most_seller_items.dart';
import 'package:cafe21/widget/dashboard/build_most_selling_item.dart';
import 'package:cafe21/widget/dashboard/build_tile_card.dart';
import 'package:cafe21/widget/dashboard/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:cafe21/model/data.dart';
import 'package:cafe21/cons/enums.dart';
import 'invoice/invoice_entry.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  bool isSelectedBottomButtonOne = true;
  bool isSelectedBottomButtonTwo = false;
  bool isDataLoading = true;

  @override
  void initState() {
    allSellsData.clear();
    init();
    super.initState();
  }

  init() async {

    // getting all data from server
    if(allSellsData.isEmpty){
      await DashboardController().getAllSellsData();
    }
    if(allFoodsData.isEmpty){
      await DashboardController().getAllFood();
    }
    if(allCategoryData.isEmpty){
      await DashboardController().getAllFoodCategory();
    }
    if(allWaiterData.isEmpty){
      await DashboardController().getAllWaiter();
    }

    await DashboardController().getCafeDetails();

    // user role remember
    userRoleData = prefs?.getString(UserKey.role.name);
    userEmailData = prefs?.getString(UserKey.email.name);

    // print(userRoleData);
    // print(userEmailData);

    // calculating data for ui rendering
    DashboardController().getDailyData();
    DashboardController().calculationInvoiceData();
    DashboardController().calculateMostSells();

    // for stop loading indicator
    isDataLoading = false;
    setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        title: const Text('Sells Dashboard', style: TextStyle(color: Colors.white)),
        titleTextStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: MaterialButton(
                color: const Color(AppColor.box5),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const InvoiceEntry(),)),
                child: Text(
                  'New sell',
                  style: TextStyle(color: Colors.grey.shade100),
                )),
          ),
        ],
      ),
      drawer: MyDrawer(updateSate: changeState),
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          margin: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BuildTitleCard(
                    title: DashboardController.titleForData,
                    width: width, value: DashboardController.totalWithTax,
                    updateSate: changeState,
                ),
                SizedBox(
                  height: 120,
                  child: Row(
                    children: [
                      BuildBoxContent(
                        title: 'Without Tax',
                        value: DashboardController.totalWithoutTax.toStringAsFixed(1),
                        color: AppColor.boxOne,
                        isLoading: isDataLoading,
                      ),
                      BuildBoxContent(
                        title: 'Tax Collection',
                        value: (DashboardController.totalWithTax-DashboardController.totalWithoutTax).toStringAsFixed(2),
                        color: AppColor.boxTwo,
                        isLoading: isDataLoading,
                      ),
                      // BuildBoxContent(title: 'Tax Collection', value: '100', color: AppColor.boxThree,),
                    ],
                  ),
                ),
                BuildMostSellingItem(
                  width: width,
                  height: height,
                  mostSellingItems: DashboardController.countMostSellingFood,
                  title: 'Most Selling Foods',
                  isLoading: isDataLoading,
                ),
                SizedBox(
                  height: 120,
                  child: Row(
                    children: [
                      BuildBoxContent(
                        title: 'total Food',
                        value: '${allFoodsData.length}',
                        color: AppColor.box4,
                        isLoading: isDataLoading,
                      ),
                      BuildBoxContent(
                        title: 'total Category',
                        value: '${allCategoryData.length}',
                        color: AppColor.box5,
                        isLoading: isDataLoading,
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
                        isLoading: isDataLoading,
                      ),
                      BuildBoxContent(
                        title: 'App User',
                        value: allAppUserData.length.toString(),
                        color: AppColor.box7,
                        isLoading: isDataLoading,
                      ),
                      // BuildBoxContent(title: 'Tax Collection', value: '100', color: AppColor.boxThree,),
                    ],
                  ),
                ),
                BuildMostSellerList(
                  width: width,
                  height: height,
                  items: DashboardController.countMostServingPerson,
                  waiterList: allWaiterData,
                  title: 'Most Serving Waiter',
                  isLoading: isDataLoading,
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

  changeState(){
    setState(() {});
  }

}