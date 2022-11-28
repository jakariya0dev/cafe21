import 'package:cafe21/controller/admin_dashboard_controller.dart';
import 'package:cafe21/controller/common_function.dart';
import 'package:cafe21/controller/dashboard_controller.dart';
import 'package:cafe21/model/data.dart';
import 'package:cafe21/views/admin/admin_dashboard.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:cafe21/controller/connection_checker.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {

  DashboardController dashboardController = DashboardController();
  TextEditingController nameController = TextEditingController();

  getData() async {
    allFoodsData.clear();
    allWaiterData.clear();
    allCategoryData.clear();
    await dashboardController.getAllFoodCategory();
    await dashboardController.getAllFood();
    await dashboardController.getAllWaiter();
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
    var w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const AdminDashboard(index: 1)));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin area', style: TextStyle(fontSize: 16),),
          leading: BackButton(
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const AdminDashboard(index: 1))),
          ),
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/icons/icon_food.png', height: 80, width: 80,),
              const SizedBox(height: 16),
              const Text(
                'Add new food category',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple),
              ),
              const SizedBox(height: 50),
              Container(padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Category Name', style: TextStyle(fontSize: 14, fontFamily: 'Lato'),),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          hintText: 'Enter category name',
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              nameController.clear();
                            },
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              MaterialButton(
                minWidth: w,
                height: 50,
                color: Colors.purple,
                onPressed: saveCategoryName,
                child: const Text(
                  'SAVE',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  saveCategoryName() async {

    if (connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
      CommonFunction().showSnackBar('No internet!\nCheck internet connection', context);
    }
    else{
      CommonFunction()
          .showLoadingIndicatorWithTitle(context: context, title: 'Adding item');
      bool isSuccessful = await AdminDashboardController()
          .addNewCategoryName(name: nameController.text);

      if (isSuccessful) {
        nameController.clear();
        await getData();
        Navigator.pop(context);
        CommonFunction().showSnackBar('Successfully added', context);
      }
      else {
        CommonFunction().showSnackBar('Cant add category', context);
      }
    }
  }
}
