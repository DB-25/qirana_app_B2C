class ApiResponse<T> {
  String message;
  String error;
  bool status;
  List<T> listData;

  ApiResponse({
    this.message,
    this.error,
    this.status,
    this.listData,
  });

  factory ApiResponse.fromMap(Map<String, dynamic> map) {
    return ApiResponse(
      listData: map.containsKey('listData') ? (map['listData'] ?? '') : '',
      message: map.containsKey('msg') ? (map['msg'] ?? '') : '',
      error: map.containsKey('msg') ? (map['msg'] ?? '') : '',
      status: map.containsKey('status') ? (map['status'] ?? '') : '',
    );
  }
}
