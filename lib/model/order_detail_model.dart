class OrderDetailModel {
  String primaryId;
  String buyingDate;
  String item;
  String quantity;
  String weight;
  String price;
  String mrp;
  String buyerName;

  OrderDetailModel(
      {this.primaryId,
      this.buyingDate,
      this.item,
      this.quantity,
      this.weight,
      this.price,
      this.mrp,
      this.buyerName});

  factory OrderDetailModel.fromMap(Map<String, dynamic> map) {
    return OrderDetailModel(
      primaryId: map.containsKey('primaryId') ? (map['primaryId'] ?? '') : '',
      buyingDate:
          map.containsKey('buyingDate') ? (map['buyingDate'] ?? '') : '',
      item: map.containsKey('item') ? (map['item'] ?? '') : '',
      quantity: map.containsKey('quantity') ? (map['quantity'] ?? '') : '',
      weight: map.containsKey('weight') ? (map['weight'] ?? '') : '',
      price: map.containsKey('price') ? (map['price'] ?? '') : '',
      mrp: map.containsKey('mrp') ? (map['mrp'] ?? '') : '',
      buyerName: map.containsKey('buyerName') ? (map['buyerName'] ?? '') : '',
    );
  }
}
