class ProductModel {
  String primaryId;
  String name;
  String metaDescription;
  String description;
  String url;
  String discount;
  String imageOne;
  String imageTwo;
  String price;
  String status;

  ProductModel({
    this.primaryId,
    this.name,
    this.metaDescription,
    this.description,
    this.url,
    this.discount,
    this.imageOne,
    this.imageTwo,
    this.price,
    this.status,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      primaryId: map.containsKey('primaryId') ? (map['primaryId'] ?? '') : '',
      name: map.containsKey('name') ? (map['name'] ?? '') : '',
      metaDescription: map.containsKey('metaDescription')
          ? (map['metaDescription'] ?? '')
          : '',
      description:
          map.containsKey('description') ? (map['description'] ?? '') : '',
      url: map.containsKey('url') ? (map['url'] ?? '') : '',
      discount: map.containsKey('discount') ? (map['discount'] ?? '') : '',
      imageOne: map.containsKey('imageOne') ? (map['imageOne'] ?? '') : '',
      imageTwo: map.containsKey('imageTwo') ? (map['imageTwo'] ?? '') : '',
      price: map.containsKey('price') ? (map['price'] ?? '') : '',
      status: map.containsKey('status') ? (map['status'] ?? '') : '',
    );
  }
}
