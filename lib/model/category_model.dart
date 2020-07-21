class CategoryModel {
  String primaryId;
  String name;
  String description;
  String imageOne;
  String url;
  String position;
  String status;

  CategoryModel({
    this.primaryId,
    this.name,
    this.description,
    this.imageOne,
    this.url,
    this.position,
    this.status,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      primaryId: map.containsKey('primaryId') ? (map['primaryId'] ?? '') : '',
      name: map.containsKey('name') ? (map['name'] ?? '') : '',
      description:
          map.containsKey('description') ? (map['description'] ?? '') : '',
      imageOne: map.containsKey('imageOne') ? (map['imageOne'] ?? '') : '',
      url: map.containsKey('url') ? (map['url'] ?? '') : '',
      position: map.containsKey('position') ? (map['position'] ?? '') : '',
      status: map.containsKey('status') ? (map['status'] ?? '') : '',
    );
  }
}
