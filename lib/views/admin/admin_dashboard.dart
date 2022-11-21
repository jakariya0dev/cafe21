import 'package:cafe21/app_color.dart';
import 'package:cafe21/controller/admin_dashboard_controller.dart';
import 'package:cafe21/model/data.dart';
import 'package:flutter/material.dart';
import 'package:cafe21/views/admin/app_user.dart';
import 'add_user.dart';
import 'add_category_page.dart';
import 'add_food_page.dart';
import 'add_waiter_page.dart';
import 'category_list_page.dart';
import 'product_list_page.dart';
import 'waiter_list_page.dart';
import 'cafe_details.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {


  String appbarTitle = 'Admin Dashboard';
  String addButtonText = '';

  // bottom navbar
  List pages = const [ProductListPage(), FoodCategoryPage(), WaiterListPage(), AppUser(), CafeDetails()];
  late int bottomNavIndex;

  @override
  initState(){
    bottomNavIndex = widget.index;
    AdminDashboardController().getAppUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    setButtonText();

    return Scaffold(
      extendBody: true,
      backgroundColor: AppColor.scaffoldColor,
      appBar: AppBar(
        title: Text(appbarTitle),
        titleTextStyle: const TextStyle(fontWeight: FontWeight.w500),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: bottomNavIndex ==4 ? null : MaterialButton(
              onPressed: () {
                if(bottomNavIndex==0){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddFoodPage(index: bottomNavIndex)));
                }
                else if(bottomNavIndex==1){
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddCategoryPage(index: bottomNavIndex)));
                }
                else if(bottomNavIndex==2){
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddWaiterPage(index: bottomNavIndex)));
                }
                else if(bottomNavIndex==3){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AddUser()));
                }
                else{}
              },
              color: const Color(AppColor.box5),
              child: Text(addButtonText),
            ),
          )
        ],
      ),
      body: pages[bottomNavIndex],
      // body: allCategoryData.isNotEmpty
      //     ? pages[bottomNavIndex]
      //     : const Center(
      //         child: CircularProgressIndicator(),
      //       ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(10),
        child: BottomNavigationBar(
          currentIndex: bottomNavIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.deepPurple.shade900,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          unselectedItemColor: Colors.deepPurple,
          unselectedLabelStyle: const TextStyle(color: Colors.deepPurple),
          elevation: 8,
          onTap: (value) {
            bottomNavIndex = value;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.food_bank_outlined), label: 'Product'),
            BottomNavigationBarItem(
                icon: Icon(Icons.category_outlined), label: 'Category'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_pin_outlined), label: 'Waiter'),
            BottomNavigationBarItem(
                icon: Icon(Icons.supervised_user_circle), label: 'User'),
            BottomNavigationBarItem(
                icon: Icon(Icons.admin_panel_settings_outlined), label: 'Cafe'),

          ],
        ),
      ),
    );
  }

  void setButtonText() {
    if(bottomNavIndex==0){
      addButtonText = 'Add product';
    }
    else if(bottomNavIndex==1){
      addButtonText = 'Add category';
    }
    else if(bottomNavIndex==2){
      addButtonText = 'Add waiter';
    }
    else if(bottomNavIndex==3){
      addButtonText = 'Add User';
    }
    else {
      addButtonText = 'Add waiter';
    }
  }

}

