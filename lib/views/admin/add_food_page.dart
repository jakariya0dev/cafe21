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
            title: const Text('Admin area', style: TextStyle(fontSize: 16),),
            leading: BackButton(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminDashboard(index: 0))),
            ),
          ),
          body: Container(
            constraints: const BoxConstraints.expand(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/icons/icon_food.png', height: 80, width: 80,),
                  const SizedBox(height: 16),
                  const Text(
                    'Add Food data',
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.deepPurple, fontSize: 18, fontFamily: 'Lato'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    msg,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Food Name', style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w500, fontFamily: 'Lato'),),
                        TextField(
                          controller: nameController,
                          style: TextStyle(
                            color: Colors.deepPurple.shade900,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Type food name here',
                            isDense: true,
                            hintStyle: TextStyle(color: Colors.grey.shade300),
                            border: InputBorder.none,
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Food Price', style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w500, fontFamily: 'Lato'),),
                        TextField(
                          controller: priceController,
                          style: TextStyle(
                            color: Colors.deepPurple.shade900,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Type food price here',
                            isDense: true,
                            hintStyle: TextStyle(color: Colors.grey.shade300),
                            border: InputBorder.none,
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Food Description', style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w500, fontFamily: 'Lato'),),
                        TextField(
                          controller: descriptionController,
                          style: TextStyle(
                            color: Colors.deepPurple.shade900,
                          ),
                          maxLines: 5,
                          minLines: 3,
                          decoration: InputDecoration(
                            hintText: 'Type food description here',
                            isDense: true,
                            hintStyle: TextStyle(color: Colors.grey.shade300),
                            border: InputBorder.none,
                            suffixIcon: InkWell(
                              onTap: () {
                                descriptionController.clear();
                                setState(() {});
                              },
                              child: Icon(
                                Icons.clear,
                                color: Colors.blue.shade300,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text('Waiter name: '),
                        ),
                        const SizedBox(width: 8),
                        DropdownButton(
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: MaterialButton(
                          height: 50,
                          color: const Color(AppColor.box4),
                          onPressed: () {
                            nameController.clear();
                            descriptionController.clear();
                            priceController.clear();
                            dropDownHeader = 'Select';
                            categoryId = '';
                            isCategorySelected = false;
                            msg = '';
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
                        height: 50,
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
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
    );
  }

}
