class SubCategoryModel {
  String primaryId;
  String name;
  String description;
  String url;
  String status;

  SubCategoryModel({
    this.primaryId,
    this.name,
    this.description,
    this.url,
    this.status,
  });

  factory SubCategoryModel.fromMap(Map<String, dynamic> map) {
    return SubCategoryModel(
      primaryId: map.containsKey('primaryId') ? (map['primaryId'] ?? '') : '',
      name: map.containsKey('name') ? (map['name'] ?? '') : '',
      description:
          map.containsKey('description') ? (map['description'] ?? '') : '',
      url: map.containsKey('url') ? (map['url'] ?? '') : '',
      status: map.containsKey('status') ? (map['status'] ?? '') : '',
    );
  }
}
