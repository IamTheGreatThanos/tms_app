class OrdersResponse {
  final String? customerName;
  final String? date;
  final String? title;
  final List<Address> addresses;
  final bool isCurrent;

  OrdersResponse({
    required this.customerName,
    required this.date,
    required this.addresses,
    this.isCurrent = false,
    this.title = "Нужно отвезти в Алматы 1156789 коробок разобранного металических стелажей. Нужно отвезти в Алматы 1156789 коробок разобранного металических стелажей",
  });
}

class Address {
  final String? title;
  final String? streetName;
  final bool isFrom;

  Address({
    required this.title,
    required this.streetName,
    required this.isFrom,
  });
}
