class InvoiceModel{
   final String invoiceId, customer, phone, discount, tax, waiter, table;
   final dateTime;
   final List orders;
  InvoiceModel(
      {
        required this.invoiceId,
        required this.customer,
      required this.phone,
      required this.discount,
      required this.tax,
      required this.waiter,
      required this.table,
      required this.dateTime,
      required this.orders});


}