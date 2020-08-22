class OrderProduct {
  OrderProduct({this.quantity, this.productId});

  String quantity;
  String productId;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'productId': productId,
        'quantity': quantity,
      };
}
