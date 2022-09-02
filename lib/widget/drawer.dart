import 'package:cafe21/app_color.dart';
import 'package:cafe21/pages/admin_dashboard.dart';
import 'package:cafe21/pages/dashboard_page.dart';
import 'package:cafe21/pages/login_page.dart';
import 'package:flutter/material.dart';

import '../controller/admin_dashboard_controller.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: const CircleAvatar(child: Text('Logo')),
            accountName: const Text('Manager'),
            accountEmail: const Text('Chef de cuisine'),
            onDetailsPressed: () {},
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  dense: true,
                  tileColor: AppColor.drawerListTileColor,
                  leading: const Icon(Icons.restaurant_sharp),
                  title: const Text('Total summery'),
                  onTap: () {},
                ),
                const Divider(height: 0),
                ListTile(
                  dense: true,
                  tileColor: AppColor.drawerListTileColor,
                  leading: const Icon(Icons.restaurant_sharp),
                  title: const Text('Toady\'s cell summery'),
                  onTap: () {},
                ),
                const Divider(height: 0),
                ListTile(
                  dense: true,
                  tileColor: AppColor.drawerListTileColor,
                  leading: const Icon(Icons.restaurant_sharp),
                  title: const Text('Last 7 day\'s summery'),
                  onTap: () {},
                ),
                const Divider(height: 0),
                ListTile(
                  dense: true,
                  tileColor: AppColor.drawerListTileColor,
                  leading: const Icon(Icons.restaurant_sharp),
                  title: const Text('Last 30 day\'s summery'),
                  onTap: () {},
                ),
                const Divider(height: 0),
                ListTile(
                  dense: true,
                  tileColor: AppColor.drawerListTileColor,
                  leading: const Icon(Icons.restaurant_sharp),
                  title: const Text('Admin Area'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminDashboard(),));
                  },
                ),
                // const Divider(height: 0),
                // ListTile(
                //   dense: true,
                //   tileColor: AppColor.drawerListTileColor,
                //   leading: const Icon(Icons.restaurant_sharp),
                //   title: const Text('Add category'),
                //   onTap: () {
                //     showAddFoodProductDataDialog(context: context);
                //   },
                // ),
                // const Divider(height: 0),
                // ListTile(
                //   tileColor: AppColor.drawerListTileColor,
                //   dense: true,
                //   leading: const Icon(Icons.restaurant_sharp),
                //   title: const Text('Add product'),
                //   onTap: () {
                //     showAddCategoryDataDialog(context: context);
                //   },
                // ),
                // const Divider(height: 0),
              ],
            ),
          ),
          ListTile(
            dense: true,
            leading: const Icon(Icons.my_library_add),
            title: const Text('Admin Area'),
            onTap: () {

            },
          ),
        ],
      ),
    );

  }

  showAddWaiterDataDialog({context}){
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController nidController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController addressController = TextEditingController();

    showDialog(context: context, builder: (context) {
      return StatefulBuilder(builder: (context, setState){
        return AlertDialog(
          backgroundColor: AppColor.drawerListTileColor,
          title: const Text('Add waiter data', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.deepPurple),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                height: 28,
                child: TextField(
                  controller: nameController,
                  style: TextStyle(color: Colors.deepPurple.shade900),
                  decoration: InputDecoration(
                    hintText: 'Waiter name',
                    isDense: true,
                    hintStyle: TextStyle(color: Colors.blue.shade300),
                    suffixIcon: InkWell(
                      onTap: () {
                        nameController.clear();
                        setState(() {});
                      },
                      child:  Icon(Icons.clear, color: Colors.blue.shade300,),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                height: 28,
                child: TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(color: Colors.deepPurple.shade900),
                  decoration: InputDecoration(
                    hintText: 'Phone number',
                    isDense: true,
                    hintStyle: TextStyle(color: Colors.blue.shade300),
                    suffixIcon: InkWell(
                      onTap: () {
                        phoneController.clear();
                        setState(() {});
                        print('phone');
                      },
                      child: Icon(Icons.clear, color: Colors.blue.shade300,),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                height: 28,
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.deepPurple.shade900),
                  decoration: InputDecoration(
                    hintText: 'Email Address',
                    isDense: true,
                    hintStyle: TextStyle(color: Colors.blue.shade300),
                    suffixIcon: InkWell(
                      onTap: () {
                        emailController.clear();
                        setState(() {});
                      },
                      child: Icon(Icons.clear, color: Colors.blue.shade300,),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                height: 28,
                child: TextField(
                  controller: nidController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.deepPurple.shade900),
                  decoration: InputDecoration(
                    hintText: 'National id number',
                    isDense: true,
                    hintStyle: TextStyle(color: Colors.blue.shade300),
                    suffixIcon: InkWell(
                      onTap: () {
                        nidController.clear();
                        setState(() {});
                      },
                      child: Icon(Icons.clear, color: Colors.blue.shade300,),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                height: 28,
                child: TextField(
                  controller: addressController,
                  style: TextStyle(color: Colors.deepPurple.shade900),
                  decoration: InputDecoration(
                    hintText: 'Details Address',
                    isDense: true,
                    hintStyle: TextStyle(color: Colors.blue.shade300),
                    suffixIcon: InkWell(
                      onTap: () {
                        addressController.clear();
                        setState(() {});
                      },
                      child: Icon(Icons.clear, color: Colors.blue.shade300,),
                    ),
                  ),
                ),
              ),

            ],
          ),
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.center,

          actions: [

            MaterialButton(
              color: const Color(AppColor.box4),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('CANCEL', style: TextStyle(
                  color: Colors.white
              ),),
            ),
            MaterialButton(
              color: const Color(AppColor.box5),
              onPressed: () {},
              child: const Text('OK', style: TextStyle(
                  color: Colors.white
              ),),
            ),
          ],
        );
      },);
    },);
  }

  showAddFoodProductDataDialog({context}){
    TextEditingController nameController = TextEditingController();
    TextEditingController categoryController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController imageController = TextEditingController();

    List<String> category = ['category', 'desc', 'options', 'name', 'price'];
    String dropDownHeader = 'Select';

    showDialog(context: context, builder: (context) {
      return StatefulBuilder(builder: (context, setState){
        return AlertDialog(
          backgroundColor: AppColor.drawerListTileColor,
          title: const Text('Add Food data', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.deepPurple),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                height: 28,
                child: TextField(
                  controller: nameController,
                  style: TextStyle(color: Colors.deepPurple.shade900),
                  decoration: InputDecoration(
                    hintText: 'Food name',
                    isDense: true,
                    hintStyle: TextStyle(color: Colors.blue.shade300),
                    suffixIcon: InkWell(
                      onTap: () {
                        nameController.clear();
                        setState(() {});
                      },
                      child:  Icon(Icons.clear, color: Colors.blue.shade300,),
                    ),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Category:'),
                  Expanded(child: const SizedBox()),
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    height: 28,
                    child: DropdownButton(
                      isDense: true,
                      alignment: Alignment.centerRight,
                      hint: Text(dropDownHeader),
                      items: category.map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.toString()))).toList(),
                      onChanged: (value) {
                        print(value);
                        dropDownHeader = value.toString();
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                height: 28,
                child: TextField(
                  controller: descriptionController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.deepPurple.shade900),
                  decoration: InputDecoration(
                    hintText: 'Product description',
                    isDense: true,
                    hintStyle: TextStyle(color: Colors.blue.shade300),
                    suffixIcon: InkWell(
                      onTap: () {
                        descriptionController.clear();
                        setState(() {});
                      },
                      child: Icon(Icons.clear, color: Colors.blue.shade300,),
                    ),
                  ),
                ),
              ),
              // Container(
              //   margin: const EdgeInsets.only(bottom: 16),
              //   height: 28,
              //   child: TextField(
              //     controller: priceController,
              //     keyboardType: TextInputType.number,
              //     style: TextStyle(color: Colors.deepPurple.shade900),
              //     decoration: InputDecoration(
              //       hintText: 'National id number',
              //       isDense: true,
              //       hintStyle: TextStyle(color: Colors.blue.shade300),
              //       suffixIcon: InkWell(
              //         onTap: () {
              //           nidController.clear();
              //           setState(() {});
              //         },
              //         child: Icon(Icons.clear, color: Colors.blue.shade300,),
              //       ),
              //     ),
              //   ),
              // ),

            ],
          ),
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.center,

          actions: [

            MaterialButton(
              color: const Color(AppColor.box4),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('CANCEL', style: TextStyle(
                  color: Colors.white
              ),),
            ),
            MaterialButton(
              color: const Color(AppColor.box5),
              onPressed: () {},
              child: const Text('OK', style: TextStyle(
                  color: Colors.white
              ),),
            ),
          ],
        );
      },);
    },);
  }

  showAddCategoryDataDialog({context}){
    TextEditingController nameController = TextEditingController();


    showDialog(context: context, builder: (context) {
      return StatefulBuilder(builder: (context, setState){
        return AlertDialog(
          backgroundColor: AppColor.drawerListTileColor,
          title: const Text('Add Category data', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.deepPurple),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                height: 28,
                child: TextField(
                  controller: nameController,
                  style: TextStyle(color: Colors.deepPurple.shade900),
                  decoration: InputDecoration(
                    hintText: 'Category name',
                    isDense: true,
                    hintStyle: TextStyle(color: Colors.blue.shade300),
                    suffixIcon: InkWell(
                      onTap: () {
                        nameController.clear();
                        setState(() {});
                      },
                      child:  Icon(Icons.clear, color: Colors.blue.shade300,),
                    ),
                  ),
                ),
              ),
            ],
          ),
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.center,

          actions: [

            MaterialButton(
              color: const Color(AppColor.box4),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('CANCEL', style: TextStyle(
                  color: Colors.white
              ),),
            ),
            MaterialButton(
              color: const Color(AppColor.box5),
              onPressed: () {},
              child: const Text('OK', style: TextStyle(
                  color: Colors.white
              ),),
            ),
          ],
        );
      },);
    },);
  }

}
