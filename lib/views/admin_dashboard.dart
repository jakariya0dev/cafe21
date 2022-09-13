import 'package:cafe21/app_color.dart';
import 'package:cafe21/controller/admin_dashboard_controller.dart';
import 'package:flutter/material.dart';


class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {

  String appbarTitle = 'Admin Dashboard';
  List<dynamic> categoryList = [];
  List<dynamic> foodList = [];
  List<dynamic> waiterList = [];
  List pages = [];

  int bottomNavIndex = 0;


  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    categoryList = await AdminDashboardController().getCategoryList();
    foodList = await AdminDashboardController().getProductData();
    waiterList = await AdminDashboardController().getWaiterData();
    pages = [foodItemPage(), waiterListPage(), foodCategoryPage()];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: foodList.isNotEmpty ? pages[bottomNavIndex] : const Center(child: CircularProgressIndicator(),),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavIndex,
        // backgroundColor: Colors.deepPurple.shade100,
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
          BottomNavigationBarItem(icon: Text('100', style: TextStyle(fontSize: 25, color: Colors.deepPurple),), label: 'Product'),
          BottomNavigationBarItem(icon: Text('10', style: TextStyle(fontSize: 25, color: Colors.deepPurple),), label: 'Waiter'),
          BottomNavigationBarItem(icon: Text('05', style: TextStyle(fontSize: 25, color: Colors.deepPurple),), label: 'Category'),
        ],
      ),
    );
  }

  //  Build 3 pages

  Container foodItemPage(){

    int selectedButtonCategory = 0;
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
                        // print(selectedButtonCategory);
                        // setState(() {});
                      },
                      child: Text(categoryList[index], style: TextStyle(fontWeight: index == selectedButtonCategory ? FontWeight.bold : FontWeight.normal),),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 10,
                  );
                },
                itemCount: categoryList.length),
          ),
          const SizedBox(height: 10,),
          Expanded(
            child: ListView.separated(
              itemCount: foodList.length-1,
              itemBuilder: (context, index) {
                return  ListTile(
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
                  tileColor: index%2==0 ? Colors.blue.shade50 : Colors.blue.shade100,
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
          ),
        ],
      ),
    );
  }

  Container waiterListPage(){
    return Container(
      margin: const EdgeInsets.all(16),
      constraints: const BoxConstraints(),
      child: ListView.separated(
        itemCount: waiterList.length,
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
            tileColor: index%2==0 ? Colors.blue.shade50 : Colors.blue.shade100,
            leading: CircleAvatar(child: Text((index+1).toString()),),
            title: Text('Name: ${waiterList[index]['name']}'),
            subtitle: Text('Phone: ${waiterList[index]['phone']}'),
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
        itemCount: categoryList.length,
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
              await deleteCategory(categoryList[index]);
              setState(() {});
            },
            tileColor: index%2==0 ? Colors.blue.shade50 : Colors.blue.shade100,
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('25', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                Text('Foods'.toUpperCase(), style: const TextStyle(fontSize: 9),)
              ],
            ),
            title: Text('${index+1}. ${categoryList[index]}', style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
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

    // List<String> category = ['category', 'desc', 'options', 'name', 'price'];
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
                      items: categoryList.map((e) => DropdownMenuItem(
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
                height: 28,
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

    // List<String> category = ['category', 'desc', 'options', 'name', 'price'];
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
                  const Expanded(child: SizedBox()),
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    height: 28,
                    child: DropdownButton(
                      isDense: true,
                      alignment: Alignment.centerRight,
                      hint: Text(dropDownHeader),
                      items: categoryList.map((e) => DropdownMenuItem(
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
                height: 28,
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
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                  controller: idController,
                  style: TextStyle(color: Colors.deepPurple.shade900),
                  decoration: InputDecoration(
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
              onPressed: () async {
                await AdminDashboardController().addNewWaiterData(
                    {
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
    TextEditingController idController = TextEditingController(text: waiterList[index]['id']);
    TextEditingController nameController = TextEditingController(text: waiterList[index]['name']);
    TextEditingController phoneController = TextEditingController(text: waiterList[index]['phone']);
    TextEditingController nidController = TextEditingController(text: waiterList[index]['nid']);
    TextEditingController emailController = TextEditingController(text: waiterList[index]['email']);
    TextEditingController addressController = TextEditingController(text: waiterList[index]['address']);

    showDialog(context: context, builder: (context) {
      return StatefulBuilder(builder: (context, setState){
        return AlertDialog(
          backgroundColor: AppColor.drawerListTileColor,
          scrollable: true,
          title: const Text('Add waiter data', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.deepPurple),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 16),
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
                await AdminDashboardController().deleteWaiterData(waiterList[index]['docId']);
                String msg = await AdminDashboardController().updateWaiterData({
                  'id' : idController.text,
                  'name' : nameController.text,
                  'phone' : phoneController.text,
                  'email' : emailController.text,
                  'nid' : nidController.text,
                  'address' : addressController.text,
                  'image' : '',
                });
                waiterList.clear();
                getData();

                SnackBar snackBar = SnackBar(content: Text(msg), action: SnackBarAction(label: 'OK', onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),),);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
            String msg = await AdminDashboardController().deleteWaiterData(waiterList[index]['docId']);
            waiterList.clear();
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
                await AdminDashboardController().addNewCategoryName(context: context, name: nameController.text);
                Navigator.pop(context);
                categoryList.clear();
                getData();
                SnackBar snackBar = SnackBar(backgroundColor: Colors.purple, content: const Text('Data Added Successfully!'), action: SnackBarAction(label: 'OK', textColor: Colors.white, onPressed: () => Navigator.pop(context),),);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

    TextEditingController nameController = TextEditingController(text: categoryList[index]);

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

                categoryList.removeAt(index);
                categoryList.insert(index, nameController.text);
                Navigator.pop(context);
                String msg = await AdminDashboardController().updateCategoryName(categoryList);
                categoryList.clear();
                getData();
                SnackBar snackBar = SnackBar(backgroundColor: Colors.purple, content: Text(msg), action: SnackBarAction(label: 'OK', textColor: Colors.white, onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),),);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
            categoryList.clear();
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

