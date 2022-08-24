import 'package:cafe21/model/invoice_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Services {
  var db = FirebaseFirestore.instance;

  Future<List> getFoodData(String type) async {

    var foodData = [];

    await db
        .collection('foods')
        .where('type', isEqualTo: type)
        .get()
        .then((value) {
      for (var element in value.docs) {
        foodData.add({
          'name': element['name'],
          'price': element['price'],
          'id': element.id,
        });
      }
    });

    return foodData;

  }

  addDataToServer(data){
    String docId = DateTime.now().year.toString()+DateTime.now().month.toString()+DateTime.now().day.toString()+DateTime.now().hour.toString()+DateTime.now().minute.toString()+DateTime.now().second.toString();
    db.collection('invoice').doc(docId).set({
      'customer' : data.customar,
      'phone' : data.phone,
      'price' : data.phone,
      'discount' : data.discount,
      'tax' : data.tax,
      'waiter' : data.waiter,
      'table' : data.table,
      'date-time' : data.dateTime,
      'order' : data.order
    });
  }

  Future<List> getTodaysSells() async {

    List <InvoiceModel> invoice = [];

    await db.collection('invoice').get().then((value){
      for(var element in value.docs){
        InvoiceModel invoiceModel = InvoiceModel(invoiceId: element.id, customar: element['customer'], phone: element['phone'], discount: element['discount'], tax: element['tax'],waiter: element['waiter'], table: element['table'], order: element['order'], dateTime: element['date-time'],);
        invoice.add(invoiceModel);
      }


    });

    return invoice;
  }
  add() {
    db
        .collection('foods')
        .add({
          'name': 'Curried Tuna Salad burger',
          'type': 'burger ',
          'price': '220',
          'image':
              'https://images.unsplash.com/photo-1571091718767-18b5b1457add?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8YnVyZ2VyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
          'description':
              'You cant go wrong with our cheeseburger, a signature flame-grilled beef patty topped with a simple layer of melted American cheese, crinkle cut pickles, yellow mustard, and ketchup on a toasted sesame seed bun'
        })
        .then((value) => db.collection('foods').add({
              'name': 'Revisited Chicken Salad burger',
              'type': 'burger ',
              'price': '210',
              'image':
                  'https://images.unsplash.com/photo-1551782450-a2132b4ba21d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8YnVyZ2VyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
              'description':
                  'You cant go wrong with our cheeseburger, a signature flame-grilled beef patty topped with a simple layer of melted American cheese, crinkle cut pickles, yellow mustard, and ketchup on a toasted sesame seed bun'
            }))
        .then((value) => db.collection('foods').add({
              'name': 'Grilled Gouda and Naan burger',
              'type': 'burger ',
              'price': '230',
              'image':
                  'https://images.unsplash.com/photo-1551782450-17144efb9c50?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGJ1cmdlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
              'description':
                  'You cant go wrong with our cheeseburger, a signature flame-grilled beef patty topped with a simple layer of melted American cheese, crinkle cut pickles, yellow mustard, and ketchup on a toasted sesame seed bun'
            }))
        .then((value) => db.collection('foods').add({
              'name': 'Egg and Avocado burger',
              'type': 'burger ',
              'price': '250',
              'image':
                  'https://images.unsplash.com/photo-1572802419224-296b0aeee0d9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTR8fGJ1cmdlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
              'description':
                  'You cant go wrong with our cheeseburger, a signature flame-grilled beef patty topped with a simple layer of melted American cheese, crinkle cut pickles, yellow mustard, and ketchup on a toasted sesame seed bun'
            }))
        .then((value) => db.collection('foods').add({
              'name': 'Crispy Chicken burger',
              'type': 'burger ',
              'price': '260',
              'image':
                  'https://images.unsplash.com/photo-1561758033-d89a9ad46330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjB8fGJ1cmdlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
              'description':
                  'You cant go wrong with our cheeseburger, a signature flame-grilled beef patty topped with a simple layer of melted American cheese, crinkle cut pickles, yellow mustard, and ketchup on a toasted sesame seed bun'
            }))
        .then((value) => print('Success'));
  }
}
