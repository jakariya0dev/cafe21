import 'package:cafe21/cons/app_color.dart';
import 'package:cafe21/controller/admin_dashboard_controller.dart';
import 'package:cafe21/controller/common_function.dart';
import 'package:cafe21/controller/connection_checker.dart';
import 'package:cafe21/controller/dashboard_controller.dart';
import 'package:cafe21/model/data.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class FoodCategoryPage extends StatefulWidget {
  const FoodCategoryPage({Key? key}) : super(key: key);

  @override
  State<FoodCategoryPage> createState() => _FoodCategoryPageState();
}

class _FoodCategoryPageState extends State<FoodCategoryPage> {

  DashboardController dashboardController = DashboardController();

  getData() async {
    allFoodsData.clear();
    // allWaiterData.clear();
    allCategoryData.clear();
    await dashboardController.getAllFoodCategory();
    await dashboardController.getAllFood();
    // await dashboardController.getAllWaiter();
    setState(() {});
  }

  @override
  void initState() {
    ConnectionChecker().checkInternetConnection(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      constraints: const BoxConstraints(),
      margin: const EdgeInsets.all(16),
      child: allCategoryData.isEmpty ? const Center(child: Text('No food item')) : Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child:  Text('Total food category: ${allCategoryData.length}'),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: allCategoryData.length,
              itemBuilder: (context, index) {
                List items = allFoodsData.where((e) => e['category'] == allCategoryData[index]['id']).toList();
                return ListTile(
                  isThreeLine: false,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  dense: true,
                  onTap: () {
                    _editCategory(index);
                  },
                  onLongPress: () async {
                    await _deleteCategory(
                        allCategoryData[index]['id']);
                    setState(() {});
                  },
                  leading: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.blue,
                    child: Text('${index + 1}', style: const TextStyle(color: Colors.white),),
                  ),
                  tileColor: Colors.white,
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(
                         items.length.toString().padLeft(2, '0'),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'items'.toUpperCase(),
                        style: const TextStyle(fontSize: 9),
                      )
                    ],
                  ),
                  title: Text(
                    '${allCategoryData[index]['name']}',
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15, fontFamily: 'Lato'),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 8,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Category Data Manipulation
  _editCategory(index) {
    TextEditingController nameController = TextEditingController(
        text: allCategoryData[index]['name']);
    String errorMsg = '';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: AppColor.drawerListTileColor,
              title: const Text(
                'Update waiter data',
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.deepPurple),
              ),
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
                          child: Icon(
                            Icons.clear,
                            color: Colors.blue.shade300,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(errorMsg, style: const TextStyle(color: Colors.red))
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
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                MaterialButton(
                  color: const Color(AppColor.box5),
                  onPressed: () async {
                    if (nameController.text.isEmpty) {
                      CommonFunction
                          .showGetXSnackBar('Message', 'Add ordered item in list!');
                    } else if (connectivityResult !=
                            ConnectivityResult.mobile &&
                        connectivityResult != ConnectivityResult.wifi) {
                      CommonFunction.showGetXSnackBar(
                          'No internet', 'Check internet connection.');
                    } else {
                      bool isSuccessful =
                          await AdminDashboardController().updateCategoryName(
                        id: allCategoryData[index]['id'],
                        name: nameController.text,
                      );
                      if (isSuccessful) {
                        _pop();
                        await getData();
                        CommonFunction.showGetXSnackBar('Message!', 'Successfully updated');
                      } else {
                        CommonFunction.showGetXSnackBar('Error!', 'Can not update');
                      }
                    }
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  _deleteCategory(id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Are you sure!',
            style: TextStyle(color: Colors.red),
          ),
          content: const Text('This item will be deleted.'),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            MaterialButton(
              onPressed: () async {
                if (connectivityResult != ConnectivityResult.mobile &&
                    connectivityResult != ConnectivityResult.wifi) {
                  CommonFunction.showGetXSnackBar(
                      'No internet', 'Check internet connection');
                }
                else {

                  // close warning dialog
                  Navigator.pop(context);

                  // show loading indicator
                  CommonFunction().showLoadingIndicatorWithTitle(context: context, title: 'Deleting Data...');

                  // calling for delete
                  bool isSuccessful = await AdminDashboardController().deleteCategory(id);
                    if (isSuccessful) {

                      // Clear previous data & Getting new data after deleted
                      await getData();

                      // close loading indicator
                      _pop();

                      // show successful message
                      CommonFunction.showGetXSnackBar('Message!', 'Successfully deleted');
                    }
                    else {
                      // close loading indicator
                      _pop();

                      // show successful message
                      CommonFunction.showGetXSnackBar('Message', 'Can not delete');
                    }
                }
              },
              color: const Color(AppColor.box5),
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: const Color(AppColor.box4),
              child: const Text(
                'CANCEL',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  _pop() {
    Navigator.pop(context);
  }

}
