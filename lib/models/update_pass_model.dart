class UpdatePassResponse {
  UpdatePassResponse({
    required this.status,
    required this.message,
    required this.data,
  });
  late final bool status;
  late final String message;
  late final List<dynamic> data;

  UpdatePassResponse.fromJson(Map<String, dynamic> json){
    status = json['success'];
    message = json['message'];
    data = List.castFrom<dynamic, dynamic>(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = status;
    _data['message'] = message;
    _data['data'] = data;
    return _data;
  }
}