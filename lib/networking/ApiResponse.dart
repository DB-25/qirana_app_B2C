class ApiResponse<T> {
  String message;
  String error;
  bool status;
  List<T> listData;
  List<T> data;

  ApiResponse(
      {this.message, this.error, this.status, this.listData, this.data});

  factory ApiResponse.fromMap(Map<String, dynamic> map) {
    return ApiResponse(
        listData: map.containsKey('listData') ? (map['listData'] ?? '') : '',
        message: map.containsKey('msg') ? (map['msg'] ?? '') : '',
        error: map.containsKey('msg') ? (map['msg'] ?? '') : '',
        status: map.containsKey('status') ? (map['status'] ?? '') : '');
  }

  factory ApiResponse.fromMap2(Map<String, dynamic> map) {
    return ApiResponse(
        message: map.containsKey('msg') ? (map['msg'] ?? '') : '',
        error: map.containsKey('msg') ? (map['msg'] ?? '') : '',
        status: map.containsKey('status') ? (map['status'] ?? '') : '',
        data: map.containsKey("data") ? (map["data"] ?? '') : '');
  }
}
