import 'package:cloud_firestore/cloud_firestore.dart';

class OrderItemModel{

  String id, name, price, discount,discountType, quantity, itemTotal;
  final int isAddedIndex;

  OrderItemModel({required this.id, required this.name, required this.price, required this.discount, required this.quantity, required this.itemTotal, required this.isAddedIndex, required this.discountType});

}