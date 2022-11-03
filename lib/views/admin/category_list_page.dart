import 'package:cafe21/app_color.dart';
import 'package:cafe21/cons/enums.dart';
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
    allWaiterData.clear();
    allCategoryData.clear();
    await dashboardController.getAllFoodCategory();
    await dashboardController.getAllFood();
    await dashboardController.getAllWaiter();
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
      child: ListView.separated(
        itemCount: allCategoryData.length,
        itemBuilder: (context, index) {
          return ListTile(
            isThreeLine: false,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            dense: true,
            onTap: () {
              editCategory(index);
            },
            onLongPress: () async {
              await deleteCategory(
                  allCategoryData[index][CategoryListKey.id.name]);
              setState(() {});
            },
            tileColor:
                index % 2 == 0 ? Colors.blue.shade100 : Colors.blue.shade100,
            trailing: const Icon(Icons.edit_calendar),
            title: Text(
              '${index + 1}. ${allCategoryData[index][CategoryListKey.name.name]}',
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 4,
          );
        },
      ),
    );
  }

  // Category Data Manipulation

  editCategory(index) {
    TextEditingController nameController = TextEditingController(
        text: allCategoryData[index][CategoryListKey.name.name]);
    String errorMsg = '';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: AppColor.drawerListTileColor,
              title: const Text(
                'Add waiter data',
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
                      CommonFunction()
                          .showSnackBar('Add ordered item in list!', context);
                    } else if (connectivityResult !=
                            ConnectivityResult.mobile &&
                        connectivityResult != ConnectivityResult.wifi) {
                      CommonFunction().showSnackBar(
                          'No internet!\nCheck internet connection.', context);
                    } else {
                      bool isSuccessful =
                          await AdminDashboardController().updateCategoryName(
                        id: allCategoryData[index][CategoryListKey.id.name],
                        name: nameController.text,
                      );
                      if (isSuccessful) {
                        Navigator.pop(context);
                        await getData();
                        showSnackbar('Successfully updated');
                      } else {
                        showSnackbar('Cant update');
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

  deleteCategory(id) {
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
                  CommonFunction().showSnackBar(
                      'No internet!\nCheck internet connection', context);
                } else {
                  bool isSuccessful =
                      await AdminDashboardController().deleteCategory(id);
                  if (isSuccessful = true) {
                    Navigator.pop(context);
                    allCategoryData.clear();
                    getData();
                    showSnackbar('Successfully deleted');
                  } else {
                    Navigator.pop(context);
                    showSnackbar('Cant delete');
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

  showSnackbar(msg) {
    CommonFunction().showSnackBar(msg, context);
  }
}
