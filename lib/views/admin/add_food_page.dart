import 'package:cafe21/cons/app_color.dart';
import 'package:cafe21/controller/admin_dashboard_controller.dart';
import 'package:cafe21/controller/common_function.dart';
import 'package:cafe21/controller/connection_checker.dart';
import 'package:cafe21/controller/dashboard_controller.dart';
import 'package:cafe21/model/data.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:cafe21/views/admin/admin_dashboard.dart';

class AddFoodPage extends StatefulWidget {
  const AddFoodPage({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<AddFoodPage> createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {

  CommonFunction commonFunction = CommonFunction();
  DashboardController dashboardController = DashboardController();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  String msg = '';
  String dropDownHeader = 'Select';
  String categoryId = '';
  bool isCategorySelected = false;

  getData() async {
    allFoodsData.clear();
    allWaiterData.clear();
    allCategoryData.clear();
    await dashboardController.getAllFoodCategory();
    await dashboardController.getAllFood();
    await dashboardController.getAllWaiter();
    setState(() {});
  }

  @override
  void initState() {
    ConnectionChecker().checkInternetConnection((){
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminDashboard(index: 0)));
      return false;
    },
        child: Scaffold(
          backgroundColor: AppColor.scaffoldColor,
          appBar: AppBar(
            leading: BackButton(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminDashboard(index: 0))),
            ),
          ),
          body: Container(
            constraints: const BoxConstraints.expand(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Add Food data',
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.deepPurple, fontSize: 20),
                ),
                SizedBox(
                  height: 32,
                  child: Center(
                    child: Text(
                      msg,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  height: 32,
                  child: TextField(
                    controller: nameController,
                    style: TextStyle(
                      color: Colors.deepPurple.shade900,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Food name',
                      isDense: true,
                      hintStyle: TextStyle(color: Colors.blue.shade200),
                      suffixIcon: InkWell(
                        onTap: () {
                          nameController.clear();
                          setState(() {});
                        },
                        child: Icon(
                          Icons.clear,
                          color: Colors.blue.shade300,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Category:'),
                    const Expanded(child: SizedBox()),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      height: 28,
                      child: DropdownButton(
                        isDense: true,
                        alignment: Alignment.centerRight,
                        hint: Text(
                          dropDownHeader,
                          overflow: TextOverflow.ellipsis,
                        ),
                        items: allCategoryData
                            .map(
                              (e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e['name'].toString(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ).toList(),
                        onChanged: (value) {
                          Map map = value as Map;
                          dropDownHeader = map['name'];
                          categoryId = map['id'];
                          isCategorySelected = true;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  height: 120,
                  child: TextField(
                    minLines: 3,
                    maxLines: 8,
                    controller: descriptionController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.deepPurple.shade900),
                    decoration: InputDecoration(
                      labelText: 'Product description',
                      // hintText: 'Product description',
                      border: const OutlineInputBorder(),
                      isDense: true,
                      // hintStyle: TextStyle(color: Colors.blue.shade200),
                      labelStyle: TextStyle(color: Colors.blue.shade500, fontSize: 16),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  height: 32,
                  child: TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.deepPurple.shade900),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.currency_exchange),
                      hintText: 'Food price',
                      isDense: true,
                      hintStyle: TextStyle(color: Colors.blue.shade200),
                      suffixIcon: InkWell(
                        onTap: () {
                          priceController.clear();
                          setState(() {});
                        },
                        child: Icon(
                          Icons.clear,
                          color: Colors.blue.shade300,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                  child: Center(
                    child: Text(
                      msg,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: MaterialButton(
                        color: const Color(AppColor.box4),
                        onPressed: () {
                          nameController.clear();
                          descriptionController.clear();
                          priceController.clear();
                          dropDownHeader = 'Select';
                          categoryId = '';
                          isCategorySelected = false;
                          setState(() {});
                        },
                        child: const Text(
                          'CLEAR ALL',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(child: MaterialButton(
                      color: const Color(AppColor.box5),
                      onPressed: () async {
                        if (nameController.text.isEmpty) {
                          msg = 'Error: Enter food name!';
                          setState(() {});
                        }
                        else if (isCategorySelected == false) {
                          msg = 'Error: Select food category!';
                          setState(() {});
                        }
                        else if (descriptionController.text.isEmpty) {
                          msg = 'Error: Enter food description!';
                          setState(() {});
                        }
                        else if (priceController.text.isEmpty) {
                          msg = 'Error: Food price is Empty!';
                          setState(() {});
                        }
                        else if (connectivityResult !=
                            ConnectivityResult.mobile &&
                            connectivityResult != ConnectivityResult.wifi) {
                          commonFunction.showSnackBar(
                              'No internet!\nCheck internet connection', context);
                        }
                        else {
                          commonFunction.showLoadingIndicatorWithTitle(
                              context: context,
                              title: 'Product adding please wait');
                          bool isSuccessful =
                          await AdminDashboardController().addNewFoodData({
                            'name': nameController.text,
                            'category': categoryId,
                            'description': descriptionController.text,
                            'price': priceController.text
                          });
                              if(isSuccessful){
                                Navigator.pop(context);
                                getData();
                                commonFunction.showSnackBar('Successfully added', context);
                              }else{
                                commonFunction.showSnackBar('Can not save data', context);
                              }
                        }
                      },
                      child: const Text(
                        'SAVE DATA',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),),
                  ],
                )
              ],
            ),
          ),
        ),
    );
  }

}
