
class InvoiceModel{

   final String invoiceId, customer, phone, address, discount, tax, waiterId, table;
   final String discountType, paymentMethod, subTotal, total, netBill;
   final String? biller;
   final dateTime;
   final List orders;

  InvoiceModel({
    required this.invoiceId,
    required this.customer,
    required this.phone,
    required this.address,
    required this.discount,
    required this.discountType,
    required this.tax,
    required this.waiterId,
    required this.table,
    required this.dateTime,
    required this.paymentMethod,
    required this.orders,
    required this.subTotal,
    required this.total,
    required this.netBill,
    required this.biller,
  });

   // factory InvoiceModel.fromFirestore(
   //     DocumentSnapshot<Map<String, dynamic>> snapshot,
   //     SnapshotOptions? options,
   //     ) {
   //   final data = snapshot.data();
   //   return InvoiceModel(
   //     invoiceId: data?['invoiceId'],
   //     customer: data?['customer'],
   //     phone: data?['phone'],
   //     discount: data?['discount'],
   //     tax: data?['tax'],
   //     waiter: data?['waiter'],
   //     table: data?['table'],
   //     dateTime : data?['dateTime'],
   //     orders : data?['orders'] is Iterable ? List.from(data?['orders']) : null,
   //   );
   // }
   //
   // Map<String, dynamic> toFirestore() {
   //   return {
   //     if (invoiceId != null) "invoiceId": invoiceId,
   //     if (customer != null) "customer": customer,
   //     if (phone != null) "country": phone,
   //     if (discount != null) "capital": discount,
   //     if (tax != null) "population": tax,
   //     if (waiter != null) "regions": waiter,
   //     if (table != null) "table": table,
   //     if (dateTime != null) "dateTime": dateTime,
   //     if (orders != null) "orders": orders,
   //   };
   // }

}