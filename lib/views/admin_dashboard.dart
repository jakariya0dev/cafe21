import 'package:cafe21/app_color.dart';
import 'package:cafe21/controller/admin_dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:cafe21/model/data.dart';
import 'package:cafe21/main.dart';


class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {

  String appbarTitle = 'Admin Dashboard';
  List<dynamic> foodList = [];

  // bottom navbar
  List pages = [];
  int bottomNavIndex = 0;
  int selectedButtonCategory = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {

    foodList = allFoodsData.where((e) => e['type'] == allCategoryData[selectedButtonCategory]).toList();
    pages = [foodItemPage(), waiterListPage(), foodCategoryPage()];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColor.scaffoldColor,
      appBar: AppBar(
        title: Text(appbarTitle),
        titleTextStyle: const TextStyle(fontWeight: FontWeight.w500),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: MaterialButton(onPressed: () {

              if(bottomNavIndex == 0){
                addFoodItem();
              }
              else if(bottomNavIndex == 1){
                addWaiter();
              }
              else if(bottomNavIndex == 2){
                addCategory();
              }

            },
            color: const Color(AppColor.box5),
              child: const Text('Add new'),
            ),
          )
        ],
      ),
      body:  allCategoryData.isNotEmpty ? pages[bottomNavIndex] : const Center(child: CircularProgressIndicator(),),
      bottomNavigationBar: Container(

        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(50),
          // color: Colors.blue.shade50
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: BottomNavigationBar(
            currentIndex: bottomNavIndex,
            // backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.deepPurple.shade900,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedItemColor: Colors.deepPurple,
            unselectedLabelStyle: const TextStyle(color: Colors.deepPurple),
            elevation: 8,
            onTap: (value) {
              bottomNavIndex = value;
              setState(() {});
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.food_bank_outlined), label: 'Product'),
              BottomNavigationBarItem(icon: Icon(Icons.person_pin_outlined), label: 'Waiter'),
              BottomNavigationBarItem(icon:Icon(Icons.category_outlined), label: 'Category'),
            ],
          ),
        ),
      ),
    );
  }

  //  Build 3 pages

  Container foodItemPage(){

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
                      // color: index == selectedButtonCategory ? Colors.purple : Colors.amber,
                        border: index == selectedButtonCategory ? const Border(
                            bottom: BorderSide(
                                color: Colors.deepPurple,
                                width: 2
                            )
                        ) : null
                    ) ,
                    child: TextButton(
                      onPressed: () {
                        selectedButtonCategory = index;
                        foodList.clear();
                        getData();

                      },
                      child: Text(allCategoryData[index], style: TextStyle(fontWeight: index == selectedButtonCategory ? FontWeight.bold : FontWeight.normal),),
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
          const SizedBox(height: 10,),
          foodList.isNotEmpty ? Expanded(
            child: ListView.separated(
              itemCount: foodList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  isThreeLine: false,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                  ),
                  dense: true,
                  onTap: (){
                    editFoodItem(index);
                  },
                  onLongPress: (){
                    deleteFoodItem(index);
                  },
                  tileColor: index%2==0 ? Colors.blue.shade200 : Colors.blue.shade100,
                  leading: CircleAvatar(
                    child: Text((index+1).toString(), style: const TextStyle(color: Colors.white),),),
                  title: Text(foodList[index]['name']),
                  subtitle: Text(foodList[index]['type']),
                  trailing: Text('\$${foodList[index]['price']}', style: const TextStyle( fontWeight: FontWeight.bold, fontSize: 18),),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 4,);
              },
            ),
          ) : const Center(child: Text('No food item'),),
        ],
      ),
    );
  }

  Container waiterListPage(){
    return Container(
      margin: const EdgeInsets.all(16),
      constraints: const BoxConstraints(),
      child: ListView.separated(
        itemCount: allWaiterData.length,
        itemBuilder: (context, index) {
          return  ListTile(
            isThreeLine: false,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)
            ),
            dense: true,
            onTap: (){
              editWaiter(index);
            },
            onLongPress: (){
              deleteWaiter(index);
            },
            tileColor: index%2==0 ? Colors.blue.shade200 : Colors.blue.shade100,
            leading: CircleAvatar(child: Text((index+1).toString()),),
            title: Text('Name: ${allWaiterData[index]['name']}'),
            subtitle: Text('Phone: ${allWaiterData[index]['phone']}'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('100', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                const SizedBox(height: 4,),
                Text('Orders'.toUpperCase(), style: const TextStyle(fontSize: 9),)
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox( height: 4,
          );
        },
      ),
    );
  }

  Container foodCategoryPage(){
    return Container(
      constraints: const BoxConstraints(),
      margin: const EdgeInsets.all(16),
      child: ListView.separated(
        itemCount: allCategoryData.length,
        itemBuilder: (context, index) {
          return  ListTile(
            isThreeLine: false,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)
            ),
            dense: true,
            onTap: (){
              editCategory(index);
            },
            onLongPress: () async {
              await deleteCategory(allCategoryData[index]);
              setState(() {});
            },
            tileColor: index%2==0 ? Colors.blue.shade200 : Colors.blue.shade100,
            trailing: const Icon(Icons.edit_calendar),
            title: Text('${index+1}. ${allCategoryData[index]}', style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 4,);
        },
      ),
    );
  }

  //  Foods Data Manipulation

  addFoodItem(){
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    String msg = '';
    String dropDownHeader = 'Select';
    bool isCategorySelected = false;

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
                height: 32,
                child: TextField(
                  controller: nameController,
                  style: TextStyle(color: Colors.deepPurple.shade900, ),
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
                  const Expanded(child: SizedBox()),
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    height: 28,
                    child: DropdownButton(
                      isDense: true,
                      alignment: Alignment.centerRight,
                      hint: Text(dropDownHeader),
                      items: allCategoryData.map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.toString()))).toList(),
                      onChanged: (value) {
                        // print(value);
                        dropDownHeader = value.toString();
                        isCategorySelected = true;
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
                    prefixIcon: const Icon(Icons.currency_exchange),
                    hintText: 'Food price',
                    isDense: true,
                    hintStyle: TextStyle(color: Colors.blue.shade300),
                    suffixIcon: InkWell(
                      onTap: () {
                        priceController.clear();
                        setState(() {});
                      },
                      child: Icon(Icons.clear, color: Colors.blue.shade300,),
                    ),
                  ),
                ),
              ),
              Text(msg, style: const TextStyle(color: Colors.red),)
            ],
          ),
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.center,

          actions: [
            MaterialButton(
              color: const Color(AppColor.box4),
              onPressed: () {
                nameController.clear();
                descriptionController.clear();
                priceController.clear();

                Navigator.pop(context);
              },
              child: const Text('CANCEL', style: TextStyle(
                  color: Colors.white
              ),),
            ),
            MaterialButton(
              color: const Color(AppColor.box5),
              onPressed: () async {
                if (nameController.text.isEmpty) {
                  msg = 'Error: Enter food name!';
                  setState((){});
                }
                else if (isCategorySelected == false) {
                  msg = 'Error: Select food category!';
                  setState((){});
                }
                else if(descriptionController.text.isEmpty){
                  msg = 'Error: Enter food description!';
                  setState((){});
                }
                else if (priceController.text.isEmpty) {
                  msg = 'Error: Food price is Empty!';
                  setState((){});
                }
                else{
                  await AdminDashboardController().addNewFoodData({
                    'name': nameController.text,
                    'category': dropDownHeader,
                    'description': descriptionController.text,
                    'price': priceController.text
                  });
                  Navigator.pop(context);
                  SnackBar snackBar = SnackBar(
                    backgroundColor: Colors.purple,
                    content: const Text('Data Added Successfully!'),
                    action: SnackBarAction(
                      label: 'OK',
                      textColor: Colors.white,
                      onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),),);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  foodList.clear();
                  setState(() {});
                  getData();
                }
              },
              child: const Text('OK', style: TextStyle(
                  color: Colors.white
              ),),
            ),
          ],
        );
      },);
    },);
  }

  editFoodItem(index){

    TextEditingController nameController = TextEditingController(text: foodList[index]['name']);
    TextEditingController descriptionController = TextEditingController(text: foodList[index]['description']);
    TextEditingController priceController = TextEditingController(text: foodList[index]['price']);

    String dropDownHeader = foodList[index]['type'];

    showDialog(context: context, builder: (context) {
      return StatefulBuilder(builder: (context, setState){
        return AlertDialog(
          scrollable: true,
          backgroundColor: AppColor.drawerListTileColor,
          title: const Text('Update Food data', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.deepPurple),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                height: 32,
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
                  const Expanded(child: SizedBox()),
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    height: 28,
                    child: DropdownButton(
                      isDense: true,
                      alignment: Alignment.centerRight,
                      hint: Text(dropDownHeader),
                      items: allCategoryData.map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.toString()))).toList(),
                      onChanged: (value) {
                        // print(value);
                        dropDownHeader = value.toString();
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
              onPressed: () async {

                Navigator.pop(context);
                String msg = await AdminDashboardController().updateFoodData({
                  'name' : nameController.text,
                  'category' : dropDownHeader,
                  'description' : descriptionController.text,
                  'price' : priceController.text
                }, foodList[index]['docId']);
                foodList.clear();
                getData();
                SnackBar snackBar = SnackBar(backgroundColor: Colors.purple, content: Text(msg), action: SnackBarAction(label: 'OK', textColor: Colors.white, onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),),);
                scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
              },
              child: const Text('OK', style: TextStyle(
                  color: Colors.white
              ),),
            ),
          ],
        );
      },);
    },);
  }

  deleteFoodItem(index){
    showDialog(context: context, builder: (context) {
      return  AlertDialog(
        title: const Text('Are you sure!', style: TextStyle(color: Colors.red),),
        content: const Text('This item will be deleted.'),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          MaterialButton(onPressed: () async {
            Navigator.pop(context);
            String msg = await AdminDashboardController().deleteFoodData(foodList[index]['docId'], context);
            foodList.clear();
            getData();
            SnackBar snackBar = SnackBar(content: Text(msg), action: SnackBarAction(label: 'OK', onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),),);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
            color: const Color(AppColor.box5),
            child: const Text('OK', style: TextStyle(color: Colors.white),),
          ),
          MaterialButton(onPressed: (){
            Navigator.pop(context);
          },
            color: const Color(AppColor.box4),
            child: const Text('CANCEL', style: TextStyle(color: Colors.white),),
          ),
        ],
      );
    },);
  }

  //  Waiter Data Manipulation

  addWaiter(){
    TextEditingController idController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController nidController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController addressController = TextEditingController();

    String msg = '';
    // bool isCategorySelected = false;

    showDialog(context: context, builder: (context) {
      return StatefulBuilder(builder: (context, setState){
        return AlertDialog(
          backgroundColor: AppColor.drawerListTileColor,
          title: const Text('Add waiter data', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.deepPurple),),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  height: 32,
                  child: TextField(
                    controller: idController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.deepPurple.shade900),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.numbers),
                      hintText: 'Waiter ID',
                      isDense: true,
                      hintStyle: TextStyle(color: Colors.blue.shade300),
                      suffixIcon: InkWell(
                        onTap: () {
                          idController.clear();
                          setState(() {});
                        },
                        child:  Icon(Icons.clear, color: Colors.blue.shade300,),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  height: 32,
                  child: TextField(
                    controller: nameController,
                    style: TextStyle(color: Colors.deepPurple.shade900),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
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
                  height: 32,
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(color: Colors.deepPurple.shade900),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone_android),
                      hintText: 'Phone number',
                      isDense: true,
                      hintStyle: TextStyle(color: Colors.blue.shade300),
                      suffixIcon: InkWell(
                        onTap: () {
                          phoneController.clear();
                          setState(() {});

                        },
                        child: Icon(Icons.clear, color: Colors.blue.shade300,),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  height: 32,
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.deepPurple.shade900),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.mail_outline),
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
                  height: 32,
                  child: TextField(
                    controller: nidController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.deepPurple.shade900),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.web),
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
                  height: 72,
                  child: TextField(
                    controller: addressController,
                    style: TextStyle(color: Colors.deepPurple.shade900),
                    maxLines: 5,
                    minLines: 1,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Details Address',
                      labelText: 'Address',
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
                Text(msg, style: const TextStyle(color: Colors.red),)
              ],
            ),
          ),
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.center,

          actions: [
            MaterialButton(
              color: const Color(AppColor.box4),
              onPressed: () {
                idController.clear();
                nameController.clear();
                phoneController.clear();
                nidController.clear();
                emailController.clear();
                addressController.clear();
                Navigator.pop(context);
              },
              child: const Text('CANCEL', style: TextStyle(
                  color: Colors.white
              ),),
            ),
            MaterialButton(
              color: const Color(AppColor.box5),
              onPressed: () async {

                if (idController.text.isEmpty) {
                  msg = 'Error: Enter waiter id!';
                  setState((){});
                }
                else if (nameController.text.isEmpty) {
                  msg = 'Error: Name is empty!';
                  setState((){});
                }
                else if(phoneController.text.isEmpty){
                  msg = 'Error: Enter phone number!';
                  setState((){});
                }else if (emailController.text.isEmpty) {
                  msg = 'Error: Email is empty!';
                  setState((){});
                }else if (nidController.text.isEmpty) {
                  msg = 'Error: Enter nid number!';
                  setState((){});
                }else if (addressController.text.isEmpty) {
                  msg = 'Error: Address is Empty!';
                  setState((){});
                }
                else{
                  await AdminDashboardController().addNewWaiterData({
                    'id': idController.text,
                    'name': nameController.text,
                    'phone': phoneController.text,
                    'email': emailController.text,
                    'nid': nidController.text,
                    'address': addressController.text,
                    'image': '',
                  });
                  Navigator.pop(context);
                  foodList.clear();
                  getData();
                  SnackBar snackBar = SnackBar(backgroundColor: Colors.purple, content: const Text('Data Added Successfully!'), action: SnackBarAction(label: 'OK', onPressed: () => Navigator.pop(context),),);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                   idController.clear();
                   nameController.clear();
                   phoneController.clear();
                   nidController.clear();
                   emailController.clear();
                   addressController.clear();
                }
              },
              child: const Text('OK', style: TextStyle(
                  color: Colors.white
              ),),
            ),
          ],
        );
      },);
    },);
  }

  editWaiter(index){
    TextEditingController idController = TextEditingController(text: allWaiterData[index]['id']);
    TextEditingController nameController = TextEditingController(text: allWaiterData[index]['name']);
    TextEditingController phoneController = TextEditingController(text: allWaiterData[index]['phone']);
    TextEditingController nidController = TextEditingController(text: allWaiterData[index]['nid']);
    TextEditingController emailController = TextEditingController(text: allWaiterData[index]['email']);
    TextEditingController addressController = TextEditingController(text: allWaiterData[index]['address']);

    showDialog(context: context, builder: (context) {
      return StatefulBuilder(builder: (context, setState){
        return AlertDialog(
          backgroundColor: AppColor.drawerListTileColor,
          scrollable: true,
          title: const Text('Add waiter data', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.deepPurple),),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  height: 28,
                  child: TextField(
                    controller: idController,
                    style: TextStyle(color: Colors.deepPurple.shade900),
                    decoration: InputDecoration(
                      hintText: 'Waiter ID',
                      prefix: const Text('ID: '),
                      isDense: true,
                      hintStyle: TextStyle(color: Colors.blue.shade300),
                      suffixIcon: InkWell(
                        onTap: () {
                          idController.clear();
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
                    controller: nameController,
                    style: TextStyle(color: Colors.deepPurple.shade900),
                    decoration: InputDecoration(
                      hintText: 'Waiter name',
                      prefix: const Text('Name: '),
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
                      prefix: const Text('Phone: '),
                      isDense: true,
                      hintStyle: TextStyle(color: Colors.blue.shade300),
                      suffixIcon: InkWell(
                        onTap: () {
                          phoneController.clear();
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
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.deepPurple.shade900),
                    decoration: InputDecoration(
                      hintText: 'Email Address',
                      prefix: const Text('Email: '),
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
                      prefix: const Text('Nid: '),
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
                      prefix: const Text('Address: '),
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
              onPressed: () async {
                Navigator.pop(context);
                await AdminDashboardController().deleteWaiterData(allWaiterData[index]['docId']);
                String msg = await AdminDashboardController().updateWaiterData({
                  'id' : idController.text,
                  'name' : nameController.text,
                  'phone' : phoneController.text,
                  'email' : emailController.text,
                  'nid' : nidController.text,
                  'address' : addressController.text,
                  'image' : '',
                });
                allWaiterData.clear();
                getData();

                SnackBar snackBar = SnackBar(content: Text(msg), action: SnackBarAction(label: 'OK', onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),),);
                scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
              },
              child: const Text('OK', style: TextStyle(
                  color: Colors.white
              ),),
            ),
          ],
        );
      },);
    },);
  }

  deleteWaiter(index){
    showDialog(context: context, builder: (context) {
      return  AlertDialog(
        title: const Text('Are you sure!', style: TextStyle(color: Colors.red),),
        content: const Text('This item will be deleted.'),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          MaterialButton(onPressed: () async {
            Navigator.pop(context);
            String msg = await AdminDashboardController().deleteWaiterData(allWaiterData[index]['docId']);
            allWaiterData.clear();
            getData();
            SnackBar snackBar = SnackBar(content: Text(msg), action: SnackBarAction(label: 'OK', onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),),);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
            color: const Color(AppColor.box5),
            child: const Text('OK', style: TextStyle(color: Colors.white),),
          ),
          MaterialButton(onPressed: (){
            Navigator.pop(context);
          },
            color: const Color(AppColor.box4),
            child: const Text('CANCEL', style: TextStyle(color: Colors.white),),
          ),
        ],
      );
    },);
  }

  // Category Data Manipulation

  addCategory(){
    TextEditingController nameController = TextEditingController();
    String msg = '';

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
              Text(msg, style: const TextStyle(color: Colors.red),)
            ],
          ),
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            MaterialButton(
              color: const Color(AppColor.box4),
              onPressed: () {
                nameController.clear();
                Navigator.pop(context);
              },
              child: const Text('CANCEL', style: TextStyle(
                  color: Colors.white
              ),),
            ),
            MaterialButton(
              color: const Color(AppColor.box5),
              onPressed: () async {
                if(nameController.text.isEmpty){
                  msg = 'Error: Enter category name!';
                  setState((){});
                }else{
                  await AdminDashboardController().addNewCategoryName(context: context, name: nameController.text);
                  Navigator.pop(context);
                  allCategoryData.clear();
                  getData();
                  SnackBar snackBar = SnackBar(backgroundColor: Colors.purple, content: const Text('Data Added Successfully!'), action: SnackBarAction(label: 'OK', textColor: Colors.white, onPressed: () => Navigator.pop(context),),);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                },
              child: const Text('OK', style: TextStyle(
                  color: Colors.white
              ),),
            ),
          ],
        );
      },);
    },);
  }

  editCategory(index){

    TextEditingController nameController = TextEditingController(text: allCategoryData[index]);

    showDialog(context: context, builder: (context) {
      return StatefulBuilder(builder: (context, setState){
        return AlertDialog(
          backgroundColor: AppColor.drawerListTileColor,
          title:  const Text('Add waiter data', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.deepPurple),),
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
              onPressed: () async {

                allCategoryData.removeAt(index);
                allCategoryData.insert(index, nameController.text);
                Navigator.pop(context);
                String msg = await AdminDashboardController().updateCategoryName(allCategoryData);
                allCategoryData.clear();
                getData();
                SnackBar snackBar = SnackBar(backgroundColor: Colors.purple, content: Text(msg), action: SnackBarAction(label: 'OK', textColor: Colors.white, onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),),);
                scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
              },
              child: const Text('OK', style: TextStyle(
                  color: Colors.white
              ),),
            ),
          ],
        );
      },);
    },);
  }

  deleteCategory(name){
    showDialog(context: context, builder: (context) {
      return  AlertDialog(
        title: const Text('Are you sure!', style: TextStyle(color: Colors.red),),
        content: const Text('This item will be deleted.'),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          MaterialButton(onPressed: () async {
            String msg = await AdminDashboardController().deleteCategory(name);
            Navigator.pop(context);
            allCategoryData.clear();
            getData();
            SnackBar snackBar = SnackBar(backgroundColor: Colors.purple, content: Text(msg), action: SnackBarAction(label: 'OK', textColor: Colors.white, onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),),);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

          },
            color: const Color(AppColor.box5),
            child: const Text('OK', style: TextStyle(color: Colors.white),),
          ),
          MaterialButton(onPressed: (){
            Navigator.pop(context);
          },
            color: const Color(AppColor.box4),
            child: const Text('CANCEL', style: TextStyle(color: Colors.white),),
          ),
        ],
      );
    },);
  }

}

