import 'package:cafe21/app_color.dart';
import 'package:cafe21/cons/enums.dart';
import 'package:cafe21/controller/admin_dashboard_controller.dart';
import 'package:cafe21/controller/common_function.dart';
import 'package:cafe21/controller/connection_checker.dart';
import 'package:cafe21/controller/dashboard_controller.dart';
import 'package:cafe21/model/data.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {

  List<dynamic> foodList = [];
  int selectedCategoryButtonIndex = 0;
  DashboardController dashboardController = DashboardController();

  @override
  void initState() {
    ConnectionChecker().checkInternetConnection(() {
      setState(() {});
    });
    setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(),
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            // margin: const EdgeInsets.all(10),
            color: Colors.white,
            height: 55,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        border: index == selectedCategoryButtonIndex
                            ? const Border(
                                bottom: BorderSide(
                                    color: Colors.deepPurple, width: 2))
                            : null),
                    child: TextButton(
                      onPressed: () {
                        selectedCategoryButtonIndex = index;
                        foodList.clear();
                        setData();
                      },
                      child: Text(
                        allCategoryData[index][CategoryListKey.name.name],
                        style: TextStyle(
                            fontWeight: index == selectedCategoryButtonIndex
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 10,
                  );
                },
                itemCount: allCategoryData.length),
          ),
          const SizedBox(
            height: 10,
          ),
          foodList.isNotEmpty
              ? Expanded(
                  child: ListView.separated(
                    itemCount: foodList.length,
                    itemBuilder: (context, index) {
                      // find category name by id
                      List categoryName = allCategoryData
                          .where((e) =>
                              e[CategoryListKey.id.name] ==
                              foodList[index]['type'])
                          .toList();

                      return ListTile(
                        isThreeLine: false,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        dense: true,
                        onTap: () {
                          editFoodItem(index);
                        },
                        onLongPress: () {
                          deleteFoodItem(index);
                        },
                        tileColor: index % 2 == 0
                            ? Colors.blue.shade100
                            : Colors.blue.shade100,
                        leading: CircleAvatar(
                          child: Text(
                            (index + 1).toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          foodList[index]['name'],
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        subtitle: Text(categoryName[0]
                                [CategoryListKey.name.name]
                            .toString()),
                        trailing: Text(
                          '\$${foodList[index]['price']}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black54),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 4,
                      );
                    },
                  ),
                )
              : const Center(
                  child: Text('No food item'),
                ),
        ],
      ),
    );
  }

  setData() {
    foodList = allFoodsData
        .where((e) =>
            e['type'] ==
            allCategoryData[selectedCategoryButtonIndex]
                [CategoryListKey.id.name])
        .toList();
    setState(() {});
  }

  //  Foods Data Manipulation

  editFoodItem(index) {
    TextEditingController nameController =
        TextEditingController(text: foodList[index]['name']);
    TextEditingController descriptionController =
        TextEditingController(text: foodList[index]['description']);
    TextEditingController priceController =
        TextEditingController(text: foodList[index]['price']);

    String errorMsg = '';

    // getting specific category map
    List category = allCategoryData
        .where((e) => foodList[index]['type'] == e[CategoryListKey.id.name])
        .toList();
    String dropDownHeader = category[0][CategoryListKey.name.name];
    String categoryId = foodList[index]['type'];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              scrollable: true,
              backgroundColor: AppColor.drawerListTileColor,
              title: const Text(
                'Update Food data',
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.deepPurple),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    height: 32,
                    child: TextField(
                      controller: nameController,
                      maxLines: 3,
                      minLines: 1,
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
                                    e[CategoryListKey.name.name].toString(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            Map map = value as Map;
                            dropDownHeader = map[CategoryListKey.name.name];
                            categoryId = map[CategoryListKey.id.name];
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    height: 100,
                    child: TextField(
                      minLines: 3,
                      maxLines: 5,
                      controller: descriptionController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.deepPurple.shade900),
                      decoration: InputDecoration(
                        labelText: 'Product description',
                        border: const OutlineInputBorder(),
                        isDense: true,
                        labelStyle: TextStyle(color: Colors.blue.shade300),
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
                        hintText: 'Food price',
                        isDense: true,
                        hintStyle: TextStyle(color: Colors.blue.shade300),
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
                  Text(
                    errorMsg,
                    style: const TextStyle(color: Colors.red),
                  )
                ],
              ),
              alignment: Alignment.center,
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                MaterialButton(
                  color: const Color(AppColor.box5),
                  onPressed: () async {
                    if (nameController.text.isEmpty) {
                      errorMsg = 'Error: Enter food name!';
                      setState(() {});
                    }
                    else if (categoryId.isEmpty) {
                      errorMsg = 'Error: Select food category!';
                      setState(() {});
                    }
                    // else if (descriptionController.text.isEmpty) {
                    //   errorMsg = 'Error: Enter food description!';
                    //   setState(() {});
                    // }
                    else if (priceController.text.isEmpty) {
                      errorMsg = 'Error: Food price is Empty!';
                      setState(() {});
                    }
                    else if (connectivityResult !=
                            ConnectivityResult.mobile &&
                        connectivityResult != ConnectivityResult.wifi) {
                      Navigator.pop(context);
                      CommonFunction().showSnackBar(
                          'No internet!\nCheck internet connection', context);
                    }
                    else {
                      Navigator.pop(context);
                      String msg =
                          await AdminDashboardController().updateFoodData({
                        'name': nameController.text,
                        'category': categoryId,
                        'description': descriptionController.text,
                        'price': priceController.text
                      }, foodList[index]['id']);
                      await fetchUpdatedData();
                      showSnackbar(msg);
                    }
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
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
              ],
            );
          },
        );
      },
    );
  }

  deleteFoodItem(index) {
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
                  Navigator.pop(context);
                  String msg = await AdminDashboardController()
                      .deleteFoodData(foodList[index]['id'], context);
                  await fetchUpdatedData();
                  showSnackbar(msg);
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

  fetchUpdatedData() async {
    foodList.clear();
    allFoodsData.clear();
    await dashboardController.getAllFood();
    setData();
  }
}
